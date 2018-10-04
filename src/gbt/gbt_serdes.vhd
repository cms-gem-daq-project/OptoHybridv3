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
    centering_cnt_iodly_increment_max   : integer := 10;
    MXBITS : integer := 8
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

    -- serial data to/from GBTx
    elink_o_p        : out std_logic;
    elink_o_n        : out std_logic;

    elink_i_p        : in  std_logic;
    elink_i_n        : in  std_logic;

    gbt_link_error_i : in std_logic; -- error on gbt rx
    gbt_ready_i      : in std_logic;

    delay_refclk       : in std_logic;
    delay_refclk_reset : in std_logic;

    -- parallel data to/from FPGA logic
    data_i           : in  std_logic_vector (MXBITS-1 downto 0);
    data_o           : out std_logic_vector (MXBITS-1 downto 0);
    valid_o          : out std_logic
);
end gbt_serdes;

architecture Behavioral of gbt_serdes is

    type state_t is (DELAY, BITSLIP, CENTER, IDLE);

    signal from_gbt_raw                  : std_logic_vector(MXBITS-1 downto 0) := (others => '0');
    signal from_gbt_bitslipped           : std_logic_vector(MXBITS-1 downto 0) := (others => '0');
    signal from_gbt_remapped             : std_logic_vector(MXBITS-1 downto 0) := (others => '0');
    signal from_gbt                      : std_logic_vector(MXBITS-1 downto 0) := (others => '0');

    signal to_gbt                        : std_logic_vector(MXBITS-1 downto 0) := (others => '0');
    signal to_gbt_sync                   : std_logic_vector(MXBITS-1 downto 0) := (others => '0');

    signal state                         : state_t := IDLE;

    signal iserdes_reset                 : std_logic := '1';
    signal oserdes_reset                 : std_logic := '1';

    signal idelay_cnt                    : std_logic_vector(4 downto 0);
    signal idelay_cnt_last               : std_logic_vector(4 downto 0);

    signal centered                      : std_logic := '0';
    signal centering_cnt_iodly_increment : integer range 0 to centering_cnt_iodly_increment_max := 0;

    signal delay_reset                   : std_logic := '0';

    signal waiting_for_idelay_update     : std_logic := '0';
    signal idelay_update_timeout_cnt     : integer range 0 to 1023 := 0;

    signal rx_bitslip_cnt                : integer range 0 to MXBITS-1 := 0;
    signal iodly_increment               : std_logic := '0';

    signal bitslip_increment             : std_logic := '0';

    signal reset                         : std_logic;


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
        data_in_from_pins_p : in  std_logic_vector(0 to 0);
        data_in_from_pins_n : in  std_logic_vector(0 to 0);
        delay_reset         : in  std_logic;
        delay_data_ce       : in  std_logic_vector(0 to 0);
        delay_data_inc      : in  std_logic_vector(0 to 0);
        ref_clock           : in  std_logic;
        bitslip             : in  std_logic;
        clk_in              : in  std_logic;
        clk_div_in          : in  std_logic;
        refclk_reset        : in  std_logic;
        cntvalueout         : out std_logic_vector (4 downto 0);
        io_reset            : in  std_logic;
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

    --------------------------------------------------------------------------------------------------------------------
    -- synchronize resets from logic clock to gbt clock domains
    --------------------------------------------------------------------------------------------------------------------

    synchronizer_oserdes_reset:
    entity work.synchronizer generic map(N_STAGES => 2)
    port map(
      async_i => reset_i,
      clk_i   => gbt_tx_clk_div,
      sync_o  => oserdes_reset
    );

    synchronizer_iserdes_reset:
    entity work.synchronizer generic map(N_STAGES => 2)
    port map(
      async_i => reset_i,
      clk_i   => gbt_rx_clk_div,
      sync_o  => iserdes_reset
    );

    --------------------------------------------------------------------------------------------------------------------
    -- Alignment state machine
    --------------------------------------------------------------------------------------------------------------------

    process (gbt_rx_clk_div) begin
        if (rising_edge(gbt_rx_clk_div)) then

                --=========================--
                --==  Sequential logic   ==--
                --=========================--
                case state is
                    when IDLE =>


                        if (gbt_link_error_i='1') then
                            if (unsigned(idelay_cnt) /= 21) then
                                state <= DELAY;
                            else
                                state <= BITSLIP;
                            end if;
                        elsif (gbt_ready_i='1' and centered='0') then
                            state <= CENTER;
                        end if;

                    when DELAY =>


                        if (gbt_link_error_i='0') then
                            state <= IDLE;
                        else
                            if (unsigned(idelay_cnt) = 21) then
                                state <= BITSLIP;
                            end if;
                        end if;

                    when BITSLIP =>


                        if (gbt_link_error_i='0') then
                            state <= IDLE;
                        else
                            state <= DELAY;
                        end if;

                    when CENTER =>


                        if (centered='1') then
                            state <= IDLE;
                        end if;

                end case;

                --==========================--
                --==  Combinational Logic ==--
                --==========================--
                case state is
                    when IDLE =>
                        delay_reset <= '0';
                        iodly_increment   <= '0';
                        bitslip_increment <= '0';
                        if (gbt_link_error_i='1') then
                            centered <= '0';
                        end if;

                    when DELAY =>

                        delay_reset <= '0';
                        bitslip_increment <= '0';

                        if (waiting_for_idelay_update='1') then
                            iodly_increment   <= '0';
                        else
                            iodly_increment   <= '1';
                        end if;

                    when BITSLIP =>
                        delay_reset <= '1';
                        iodly_increment   <= '0';
                        bitslip_increment <= '1';

                    when CENTER =>

                        delay_reset <= '0';
                        bitslip_increment <= '0';


                        if (waiting_for_idelay_update='1') then
                            iodly_increment   <= '0';
                        else
                            iodly_increment   <= '1';
                        end if;

                        if (waiting_for_idelay_update = '0') then
                            if ((centering_cnt_iodly_increment  = centering_cnt_iodly_increment_max) or (unsigned(idelay_cnt) = 30)) then
                                centering_cnt_iodly_increment <= 0;
                                centered <= '1';
                            else
                                centering_cnt_iodly_increment <= centering_cnt_iodly_increment + 1;
                            end if;
                        end if;

                end case;
        end if;
    end process;

    ------------------------------------------------------------------------------------------------------------------------
    -- Rx Bitslip Control
    ------------------------------------------------------------------------------------------------------------------------

    process (gbt_rx_clk_div) begin
    if (rising_edge(gbt_rx_clk_div)) then
            if (bitslip_increment='1') then
                if (rx_bitslip_cnt = 7) then
                    rx_bitslip_cnt <= 0;
                else
                    rx_bitslip_cnt <= rx_bitslip_cnt + 1;
                end if;
            end if;
        end if;
    end process;

    ------------------------------------------------------------------------------------------------------------------------
    -- IODELAY
    ------------------------------------------------------------------------------------------------------------------------

    process (gbt_rx_clk_div) begin
        if (rising_edge(gbt_rx_clk_div)) then
            if (waiting_for_idelay_update='1') then
              idelay_update_timeout_cnt <= idelay_update_timeout_cnt + 1;
            else
              idelay_update_timeout_cnt <= 0;
          end if;
      end if;
  end process;


    process (gbt_rx_clk_div) begin
    if (rising_edge(gbt_rx_clk_div)) then

        idelay_cnt_last <= idelay_cnt;

        if (idelay_update_timeout_cnt=15) then
            waiting_for_idelay_update <= '0';
        elsif (iodly_increment = '1') then
            waiting_for_idelay_update <= '1';
        elsif (idelay_cnt /= idelay_cnt_last) then
            waiting_for_idelay_update <= '0';
        end if;

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
            clk_in                  => gbt_rx_clk,
            clk_div_in              => gbt_rx_clk_div,
            io_reset                => iserdes_reset,
                                                                     -- Input, Output delay control signals
            CNTVALUEOUT             => idelay_cnt,
            DELAY_RESET             => iserdes_reset or delay_reset,                  -- Active high synchronous reset for input delay

            DELAY_DATA_CE           => (others => iodly_increment),  -- Enable a delay change event for the datapath

            DELAY_DATA_INC          => (others => '1'),              -- Delay increment, decrement signal of bit 0
                                                                     -- Controls whether the delay is incremented
                                                                     -- (when asserted) or decremented (when deasserted) when the delay
                                                                     -- clock is enabled. This pin is provided for each of the IODELAYE2
                                                                     -- components.

            REFCLK_RESET            => delay_refclk_reset,           -- Reference clock calibration POR reset
            REF_CLOCK               => delay_refclk                  -- Reference clock for IDELAYCTRL. Has to come from BUFG.
        );

    END GENERATE from_gbt_des_gen_v6;

    --------------------------------------------------------------------------------------------------------------------
    -- Artix-7
    --------------------------------------------------------------------------------------------------------------------

    from_gbt_des_gen_a7 : IF (FPGA_TYPE="ARTIX7") GENERATE

        -- Input deserializer

        i_from_gbt_des0 : from_gbt_des_a7
        port map
        (
            data_in_from_pins_p(0) => elink_i_p,
            data_in_from_pins_n(0) => elink_i_n,
            data_in_to_device      => from_gbt_raw,
            bitslip                => (others => '0'),
            clk_in                 => gbt_rx_clk,
            clk_div_in             => gbt_rx_clk_div,
            io_reset               => iserdes_reset
        );

    END GENERATE from_gbt_des_gen_a7;

    from_gbt_remapped <= from_gbt_raw(0) & from_gbt_raw(1) & from_gbt_raw(2) & from_gbt_raw(3) & from_gbt_raw(4) & from_gbt_raw(5) & from_gbt_raw(6) & from_gbt_raw(7);

    --------------------------------------------------------------------------------------------------------------------
    -- Bitslip
    --------------------------------------------------------------------------------------------------------------------

    i_gbt_rx_bitslip : entity work.bitslip
    generic map(
      g_WORD_SIZE => MXBITS
    )
    port map(
        fabric_clk  => gbt_rx_clk_div,
        reset       => reset,
        bitslip_cnt => rx_bitslip_cnt,
        din         => from_gbt_remapped,
        dout        => from_gbt
    );

    ------------------------------------------------------------------------------------------------------------------------
    -- cross domain from GBT rx clock to FPGA logic clock
    ------------------------------------------------------------------------------------------------------------------------

    gen_gbt_rx_data_synchronizer : for I in 0 to (MXBITS-1) generate
    begin
      synchronizer_oserdes_reset:
      entity work.synchronizer
      generic map(N_STAGES => 2)
      port map(
        async_i => from_gbt(I),
        clk_i   => clock,
        sync_o  => data_o(I)
      );
    end generate;

    --======================================================================================================================
    --== OUTPUT DATA ==--
    --======================================================================================================================

    process(clock)
    begin
    if (rising_edge(clock)) then
          to_gbt<= data_i(0) & data_i(1) & data_i(2) & data_i(3) & data_i(4) & data_i(5) & data_i(6) & data_i(7);
    end if;
    end process;

    -- To ensure that data flows out of all OSERDESE1 blocks in a multiple bit output structure:
    --  1) Place a register in front of the OSERDESE1 inputs.
    --  2) Clock the register by the CLKDIV clock of the OSERDESE1.
    --  3) Use the same reset signal for the register as for the OSERDESE1.

    gen_gbt_tx_data_synchronizer : for I in 0 to (MXBITS-1) generate
    begin
      synchronizer_oserdes_reset:
      entity work.synchronizer
      generic map(N_STAGES => 2)
      port map(
        async_i => to_gbt(I),
        clk_i   => gbt_tx_clk_div,
        sync_o  => to_gbt_sync(I)
      );
    end generate;

    -- Output serializer
    -- we want to output the data on the falling edge of the clock so that the GBT can sample on the rising edge

    ------------------------------------------------------------------------------------------------------------------------
    to_gbt_ser_gen_v6 : IF (FPGA_TYPE="VIRTEX6") GENERATE
    ------------------------------------------------------------------------------------------------------------------------

    i_to_gbt_ser320 : to_gbt_ser
    port map(
        -- POLARITY SWAP ON ELINK #1
        data_out_from_device    => ("not"(to_gbt_sync)),
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

    ------------------------------------------------------------------------------------------------------------------------
    to_gbt_ser_gen_a7: IF (FPGA_TYPE="ARTIX7") GENERATE
    ------------------------------------------------------------------------------------------------------------------------

    i_to_gbt_ser0 : to_gbt_ser_a7
    port map(
        data_out_from_device    => to_gbt_sync,
        data_out_to_pins_p(0)   => elink_o_p,
        data_out_to_pins_n(0)   => elink_o_n,
        clk_in                  => gbt_tx_clk,
        clk_div_in              => gbt_tx_clk_div,
        io_reset                => oserdes_reset
    );

    END GENERATE to_gbt_ser_gen_a7;


end Behavioral;
