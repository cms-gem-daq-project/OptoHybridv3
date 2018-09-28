----------------------------------------------------------------------------------
-- CMS Muon Endcap
-- GEM Collaboration
-- Optohybrid v3 Firmware -- GBT SerDes
-- T. Lenzi, E. Juska, A. Peck
----------------------------------------------------------------------------------
-- Description:
--   This module serializes and deserializes e-link data to and from the GBTx
----------------------------------------------------------------------------------
-- 2017/07/24 -- Conversion to 16 bit (2 elinks only)
-- 2017/07/24 -- Addition of flip-flop synchronization stages for X-domain transit
-- 2017/08/09 -- rework of module to cleanup and document source
-- 2017/08/26 -- Addition of actual CDC fifo
-- 2018/04/19 -- Addition of Artix-7 Support
-- 2018/09/27 -- Conversion to single elink communication
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library unisim;
use unisim.vcomponents.all;

library work;
use work.param_pkg.all;

entity gbt_serdes is
generic(
    DEBUG                  : boolean := FALSE;
    error_cnt_strobe_max : natural := 255
);
port(

    reset_i          : in std_logic;

    -- input clocks

    gbt_rx_clk_div   : in std_logic; -- 40 MHz phase shiftable frame clock from GBT
    gbt_rx_clk       : in std_logic; -- 320 MHz phase shiftable frame clock from GBT

    gbt_tx_clk_div   : in std_logic; -- 40 MHz phase shiftable frame clock from GBT
    gbt_tx_clk       : in std_logic; -- 320 MHz phase shiftable frame clock from GBT

    clock            : in std_logic;

    tx_delay_i       : in std_logic_vector (4 downto 0);

    gbt_tx_bitslip0 : in std_logic_vector(2 downto 0) ;
    gbt_tx_bitslip1 : in std_logic_vector(2 downto 0) ;

    -- serial data to/from GBTx
    elink_o_p        : out std_logic;
    elink_o_n        : out std_logic;

    elink_i_p        : in  std_logic;
    elink_i_n        : in  std_logic;

    gbt_link_error_i : in std_logic; -- error on gbt rx

    delay_refclk       : in std_logic;
    delay_refclk_reset : in std_logic;

    -- parallel data to/from FPGA logic
    data_i           : in  std_logic_vector (7 downto 0);
    data_o           : out std_logic_vector (7 downto 0);
    valid_o          : out std_logic
);
end gbt_serdes;

architecture Behavioral of gbt_serdes is

    signal from_gbt_raw      : std_logic_vector(7 downto 0) := (others => '0');
    signal from_gbt_remapped : std_logic_vector(7 downto 0) := (others => '0');
    signal from_gbt          : std_logic_vector(7 downto 0) := (others => '0');

    signal from_gbt_cdc0     : std_logic_vector(7 downto 0) := (others => '0');
    signal from_gbt_cdc1     : std_logic_vector(7 downto 0) := (others => '0');

    signal to_gbt            : std_logic_vector(7 downto 0) := (others => '0');
    signal to_gbt_synced     : std_logic_vector(7 downto 0) := (others => '0');
    signal to_gbt_bitslipped : std_logic_vector(7 downto 0) := (others => '0');
    signal to_gbt_remapped   : std_logic_vector(7 downto 0) := (others => '0');
    signal to_gbt_data       : std_logic_vector(7 downto 0) := (others => '0');

    signal iserdes_reset     : std_logic := '1';
    signal iserdes_reset_s0  : std_logic := '1';
    signal oserdes_reset     : std_logic := '1';
    signal oserdes_reset_s0  : std_logic := '1';

    signal error_cnt_strobe  : unsigned (7 downto 0);
    signal gbt_link_error_last  : std_logic := '0';
    signal increment_rx_delay  : std_logic := '0';

    signal iserdes_clk : std_logic;
    signal iserdes_clkdiv : std_logic;

    signal idly_rdy : std_logic;

    signal reset : std_logic;


    --==============--
    --== Virtex-6 ==--
    --==============--

    component to_gbt_ser
    port(
        data_out_from_device : in std_logic_vector(7 downto 0);
        delay_reset          : in std_logic;
        delay_data_ce        : in std_logic_vector(0 to 0);
        delay_data_inc       : in std_logic_vector(0 to 0);
        delay_tap_in         : in std_logic_vector(4 downto 0);
        ref_clock            : in std_logic;
        refclk_reset         : in std_logic;
        clk_in               : in std_logic;
        clk_div_in           : in std_logic;
        io_reset             : in std_logic;
        data_out_to_pins_p   : out std_logic_vector(0 to 0);
        data_out_to_pins_n   : out std_logic_vector(0 to 0);
        delay_tap_out        : out std_logic_vector(4 downto 0)
	 );
    end component;

    component from_gbt_des
    port(
        data_in_from_pins_p : in std_logic_vector(0 to 0);
        data_in_from_pins_n : in std_logic_vector(0 to 0);
        delay_reset         : in std_logic;
        delay_data_ce       : in std_logic_vector(0 to 0);
        delay_data_inc      : in std_logic_vector(0 to 0);
        ref_clock           : in std_logic;
        bitslip             : in std_logic;
        clk_in              : in std_logic;
        clk_div_in          : in std_logic;
        refclk_reset        : in std_logic;
        io_reset            : in std_logic;
        data_in_to_device   : out std_logic_vector(7 downto 0)
	 );
    end component;

    --===============--
    --== Artix-7 ==--
    --===============--

    component from_gbt_des_a7
        generic
        (-- width of the data for the system
            SYS_W       : integer := 1;
        -- width of the data for the device
            DEV_W       : integer := 8);
        port
        (
        -- From the system into the device
            data_in_from_pins_p     : in    std_logic_vector(SYS_W-1 downto 0);
            data_in_from_pins_n     : in    std_logic_vector(SYS_W-1 downto 0);
            data_in_to_device       : out   std_logic_vector(DEV_W-1 downto 0);
            bitslip                 : in    std_logic_vector(SYS_W-1 downto 0);                    -- Bitslip module is enabled in NETWORKING mode
                                                                                                   -- User should tie it to '0' if not needed
                                                                                                   -- Clock and reset signals
            clk_in                  : in    std_logic;                    -- Fast clock from PLL/MMCM
            clk_div_in              : in    std_logic;                    -- Slow clock from PLL/MMCM
            io_reset                : in    std_logic);                   -- Reset signal for IO circuit
    end component;

    component to_gbt_ser_a7
        generic
        (-- width of the data for the system
            SYS_W       : integer := 1;
        -- width of the data for the device
            DEV_W       : integer := 8);
        port
        (
                -- From the device out to the system
            data_out_from_device    : in    std_logic_vector(DEV_W-1 downto 0);
            data_out_to_pins_p      : out   std_logic_vector(SYS_W-1 downto 0);
            data_out_to_pins_n      : out   std_logic_vector(SYS_W-1 downto 0);


                -- Clock and reset signals
            clk_in                  : in    std_logic;                    -- Fast clock from PLL/MMCM
            clk_div_in              : in    std_logic;                    -- Slow clock from PLL/MMCM
            io_reset                : in    std_logic);                   -- Reset signal for IO circuit
    end component;

    --------------------------------------------------------------------------------------------------------------------
    begin
    --------------------------------------------------------------------------------------------------------------------

    iserdes_clk    <= gbt_rx_clk  ;
    iserdes_clkdiv <= gbt_rx_clk_div  ;

    --================--
    --==    RESET   ==--
    --================--

    -- power-on reset - this must be a clock synchronous pulse of a minimum of 2 and max 32 clock cycles (ISERDES spec)
    --  1)  Wait until all MMCM/PLL used in the design are locked.
    --  2)  Reset should only be deasserted when it is known that CLK and CLKDIV are stable and present.
    --  3)  Wait until all IDELAYCTRL components, when used, show RDY high.
    --  4)  Use on the reset net one flip-flop clocked by CLKDIV per ISERDESE1/OSERDESE1 pair.
    --      Put the flip-flop in the FPGA logic in front of the ISERDESE1/OSERDESE1 pair
    --      Put a timing constraint on the flip-flop to ISERDESE1/OSERDESE1 of one CLKDIV period or less.

    process (clock) begin
    if (rising_edge(clock)) then
        reset <= reset_i;
    end if;
    end process;


    -- every N bunch crossings, check if the GBT link is in an error state (i.e. receiving invalid headers)
    -- if there are two bad checks in a row, increment the phase of the RX clock
    -- keep incrementing until the data is valid

    process (iserdes_clkdiv) begin
        if (rising_edge(iserdes_clkdiv)) then

            if (reset='1') then
                error_cnt_strobe <= (others => '0');
            elsif (error_cnt_strobe < error_cnt_strobe_max) then
                error_cnt_strobe <= error_cnt_strobe + 1;
            else
                error_cnt_strobe <= (others => '0');
            end if;

            if (reset='1') then
                    gbt_link_error_last <= '0';
            else

                if (error_cnt_strobe = error_cnt_strobe_max) then
                    gbt_link_error_last <= gbt_link_error_i;
                end if;

                if (error_cnt_strobe = error_cnt_strobe_max and gbt_link_error_i='1' and gbt_link_error_last='1') then
                    increment_rx_delay <= '1';
                else
                    increment_rx_delay <= '0';
                end if;

            end if;


        end if;
    end process;

    --------------------------------------------------------------------------------------------------------------------
    -- synchronize resets from logic clock to gbt clock domains
    --------------------------------------------------------------------------------------------------------------------

    process (gbt_tx_clk_div  ) begin
    if (rising_edge(gbt_tx_clk_div  )) then
        oserdes_reset_s0 <= reset_i;
        oserdes_reset <= oserdes_reset_s0;
    end if;
    end process;

    process (iserdes_clkdiv) begin
    if (rising_edge(iserdes_clkdiv)) then
        iserdes_reset_s0 <= reset_i;
        iserdes_reset <= iserdes_reset_s0;
    end if;
    end process;

    --================--
    --== INPUT DATA ==--
    --================--

    --------------------------------------------------------------------------------------------------------------------
    -- Virtex-6
    --------------------------------------------------------------------------------------------------------------------
    from_gbt_des_gen_v6 : IF (FPGA_TYPE="VIRTEX6") GENERATE
    --------------------------------------------------------------------------------------------------------------------

        -- Input deserializer
        i_from_gbt_des320 : from_gbt_des
        port map(
            data_in_from_pins_p (0) => elink_i_p,
            data_in_from_pins_n (0) => elink_i_n,
            data_in_to_device       => from_gbt_raw,
            bitslip                 => '0',
            clk_in                  => iserdes_clk,
            clk_div_in              => iserdes_clkdiv,
            io_reset                => iserdes_reset,
                                                                 -- Input, Output delay control signals
            DELAY_RESET             => iserdes_reset,                -- Active high synchronous reset for input delay
            DELAY_DATA_CE           => (others => increment_rx_delay),           -- Enable signal for IODELAYE1 of bit 0
            DELAY_DATA_INC          => (others => '1'),              -- Delay increment, decrement signal of bit 0
            REFCLK_RESET            => delay_refclk_reset,           -- Reference clock calibration POR reset
            REF_CLOCK               => delay_refclk                  -- Reference clock for IDELAYCTRL. Has to come from BUFG.
        );

        -- remap to account for how the Xilinx IPcore assigns the output pins
        -- flip-flop for routing and alignment
        process (iserdes_clkdiv) begin
            if (rising_edge(iserdes_clkdiv)) then

                from_gbt_remapped <=
                    from_gbt_raw(4) &
                    from_gbt_raw(5) &
                    from_gbt_raw(6) &
                    from_gbt_raw(7) &
                    from_gbt_raw(0) &
                    from_gbt_raw(1) &
                    from_gbt_raw(2) &
                    from_gbt_raw(3);

                from_gbt <= from_gbt_remapped;

            end if;
        end process;

    END GENERATE from_gbt_des_gen_v6;

    --------------------------------------------------------------------------------------------------------------------
    -- Artix-7
    --------------------------------------------------------------------------------------------------------------------
    from_gbt_des_gen_a7 : IF (FPGA_TYPE="ARTIX7") GENERATE
    --------------------------------------------------------------------------------------------------------------------

        -- Input deserializer

        i_from_gbt_des0 : from_gbt_des_a7
        port map
        (
            data_in_from_pins_p(0) => elink_i_p,
            data_in_from_pins_n(0) => elink_i_n,
            data_in_to_device      => from_gbt_raw,
            bitslip                => (others => '0'),
            clk_in                 => iserdes_clk,
            clk_div_in             => iserdes_clkdiv,
            io_reset               => iserdes_reset
        );

        -- remap to account for how the Xilinx IPcore assigns the output pins
        -- flip-flop for routing and alignment
        process (iserdes_clkdiv) begin
            if (rising_edge(iserdes_clkdiv)) then

                -- 10 bit mapping
                from_gbt_remapped <=
                    from_gbt_raw(4) &
                    from_gbt_raw(5) &
                    from_gbt_raw(6) &
                    from_gbt_raw(7) &
                    from_gbt_raw(0) &
                    from_gbt_raw(1) &
                    from_gbt_raw(2) &
                    from_gbt_raw(3);

                from_gbt <= from_gbt_remapped;

            end if;
        end process;

    END GENERATE from_gbt_des_gen_a7;

    --=================--
    --== OUTPUT DATA ==--
    --=================--

    -- Bitslip the output to serializer

    i_gbt_tx_bitslip0 : entity work.gbt_tx_bitslip
    port map(
        fabric_clk  => clock,
        reset       => reset,
        bitslip_cnt => to_integer(unsigned(gbt_tx_bitslip0)),
        din         => data_i,
        dout        => to_gbt_bitslipped
    );

    -- Rearrange data to account for how the serdes handles the bits
    --     ie, if data comes in 0, 1, 2, 3, 4, 5, 6, 7,
    --         the output will be 3210, 7654
    -------------------------------------------------------------

    to_gbt_remapped <=
        to_gbt_bitslipped(0) &
        to_gbt_bitslipped(1) &
        to_gbt_bitslipped(2) &
        to_gbt_bitslipped(3) &
        to_gbt_bitslipped(4) &
        to_gbt_bitslipped(5) &
        to_gbt_bitslipped(6) &
        to_gbt_bitslipped(7);

    process(clock)
    begin
    if (rising_edge(clock)) then
            to_gbt_data  <= to_gbt_remapped;
    end if;
    end process;

    -- To ensure that data flows out of all OSERDESE1 blocks in a multiple bit output structure:
    --  1) Place a register in front of the OSERDESE1 inputs.
    --  2) Clock the register by the CLKDIV clock of the OSERDESE1.
    --  3) Use the same reset signal for the register as for the OSERDESE1.

    process(gbt_tx_clk_div  )
    begin
    if (rising_edge(gbt_tx_clk_div)) then
        to_gbt_synced <= to_gbt_data  ;
        to_gbt        <= to_gbt_synced;
    end if;
    end process;

    -- Output serializer
    -- we want to output the data on the falling edge of the clock so that the GBT can sample on the rising edge

    to_gbt_ser_gen_v6 : IF (FPGA_TYPE="VIRTEX6") GENERATE
    i_to_gbt_ser320 : to_gbt_ser
    port map(
        -- POLARITY SWAP ON ELINK #1
        data_out_from_device    => ("not"(to_gbt)),
        data_out_to_pins_p(0)   => elink_o_p,
        data_out_to_pins_n(0)   => elink_o_n,
        clk_in                  => gbt_tx_clk  ,
        clk_div_in              => gbt_tx_clk_div  ,
        io_reset                => oserdes_reset,

        DELAY_RESET             => '1',
        DELAY_DATA_CE           => (others => '1'),
        DELAY_DATA_INC          => (others => '0'),
        DELAY_TAP_IN            => tx_delay_i,
        DELAY_TAP_OUT           => open,
        REFCLK_RESET            => delay_refclk_reset,             -- Reference clock calibration POR reset
        REF_CLOCK               => delay_refclk
    );

    END GENERATE to_gbt_ser_gen_v6;

    to_gbt_ser_gen_a7: IF (FPGA_TYPE="ARTIX7") GENERATE

    i_to_gbt_ser0 : to_gbt_ser_a7
    port map(
        data_out_from_device    => to_gbt,
        data_out_to_pins_p(0)   => elink_o_p,
        data_out_to_pins_n(0)   => elink_o_n,
        clk_in                  => gbt_tx_clk  ,
        clk_div_in              => gbt_tx_clk_div  ,
        io_reset                => oserdes_reset
    );

    END GENERATE to_gbt_ser_gen_a7;

    --=====================--
    --== DOMAIN CROSSING ==--
    --=====================--

    -- transition data from sampling clock to fabric clock
    -- and vice versa

    -- data from gbt to FPGA clock domain

    process (clock) begin
        if (rising_edge(clock)) then

            from_gbt_cdc0 <= from_gbt;
            from_gbt_cdc1 <= from_gbt_cdc0;
            data_o        <= from_gbt_cdc1;

        end if;
    end process;

end Behavioral;
