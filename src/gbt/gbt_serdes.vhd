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
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library unisim;
use unisim.vcomponents.all;

library work;

entity gbt_serdes is
generic(
    DEBUG : boolean := FALSE
);
port(

    reset_i          : in std_logic;

    -- input clocks

    gbt_rx_clk_div_i : in std_logic; -- 40 MHz phase shiftable frame clock from GBT
    gbt_rx_clk_i     : in std_logic; -- 320 MHz phase shiftable frame clock from GBT

    gbt_tx_clk_div_i : in std_logic; -- 40 MHz phase shiftable frame clock from GBT
    gbt_tx_clk_i     : in std_logic; -- 320 MHz phase shiftable frame clock from GBT

    clock            : in std_logic;

    gbt_tx_bitslip0 : in std_logic_vector(1 downto 0) ;
    gbt_tx_bitslip1 : in std_logic_vector(1 downto 0) ;

    -- serial data to/from GBTx
    elink_o_p        : out std_logic_vector(1 downto 0);
    elink_o_n        : out std_logic_vector(1 downto 0);

    elink_i_p        : in  std_logic_vector(1 downto 0);
    elink_i_n        : in  std_logic_vector(1 downto 0);

    -- parallel data to/from FPGA logic
    data_i           : in  std_logic_vector (15 downto 0);
    data_o           : out std_logic_vector (15 downto 0);
    valid_o          : out std_logic
);
end gbt_serdes;

architecture Behavioral of gbt_serdes is

    signal from_gbt_raw      : std_logic_vector(15 downto 0) := (others => '0');
    signal from_gbt_remapped : std_logic_vector(15 downto 0) := (others => '0');
    signal from_gbt          : std_logic_vector(15 downto 0) := (others => '0');

    signal to_gbt            : std_logic_vector(15 downto 0) := (others => '0');
    signal to_gbt_bitslipped : std_logic_vector(15 downto 0) := (others => '0');
    signal to_gbt_remapped   : std_logic_vector(15 downto 0) := (others => '0');
    signal to_gbt_reg        : std_logic_vector(15 downto 0) := (others => '0');

    signal iserdes_reset     : std_logic := '1';
    signal iserdes_reset_s0  : std_logic := '1';
    signal oserdes_reset     : std_logic := '1';
    signal oserdes_reset_s0  : std_logic := '1';

    signal iserdes_reset_srl : std_logic;
    signal oserdes_reset_srl : std_logic;

    signal data_clk_inv : std_logic;
    signal oserdes_clk : std_logic;
    signal oserdes_clkdiv : std_logic;
    signal iserdes_clk : std_logic;
    signal iserdes_clkdiv : std_logic;

    signal pulse_length : std_logic_vector (3 downto 0) := x"f";

    constant reset_dly : std_logic_vector (3 downto 0) := x"f";

    signal reset : std_logic;

begin

    oserdes_clk    <= gbt_tx_clk_i;
    oserdes_clkdiv <= gbt_tx_clk_div_i;

    iserdes_clk    <= gbt_rx_clk_i;
    iserdes_clkdiv <= gbt_rx_clk_div_i;

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

    process (oserdes_clkdiv) begin
    if (rising_edge(oserdes_clkdiv)) then
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

    -- Input deserializer
    i_from_gbt_des80 : entity work.from_gbt_des
    port map(
        data_in_from_pins_p => (elink_i_p(0 downto 0)),
        data_in_from_pins_n => (elink_i_n(0 downto 0)),
        data_in_to_device   => from_gbt_raw(7 downto 0),
        bitslip             => '0',
        clk_in              => iserdes_clk,
        clk_div_in          => iserdes_clkdiv,
        io_reset            => iserdes_reset
    );

    -- Input deserializer
    i_from_gbt_des320 : entity work.from_gbt_des
    port map(
        data_in_from_pins_p => elink_i_p(1 downto 1),
        data_in_from_pins_n => elink_i_n(1 downto 1),
        data_in_to_device   => from_gbt_raw(15 downto 8),
        bitslip             => '0',
        clk_in              => iserdes_clk,
        clk_div_in          => iserdes_clkdiv,
        io_reset            => iserdes_reset
    );



    -- remap to account for how the Xilinx IPcore assigns the output pins
    -- flip-flop for routing and alignment
    process (iserdes_clkdiv) begin
        if (rising_edge(iserdes_clkdiv)) then

            -- 10 bit mapping
            from_gbt_remapped <=
                from_gbt_raw(12) &
                from_gbt_raw(13) &
                from_gbt_raw(14) &
                from_gbt_raw(15) &
                from_gbt_raw(8)  &
                from_gbt_raw(9)  &
                from_gbt_raw(10) &
                from_gbt_raw(11) &
                from_gbt_raw(0)  &
                from_gbt_raw(1)  &
                from_gbt_raw(2)  &
                from_gbt_raw(3)  &
                from_gbt_raw(4)  &
                from_gbt_raw(5)  &
                from_gbt_raw(6)  &
                from_gbt_raw(7);

            from_gbt <= from_gbt_remapped;

        end if;
    end process;

    --=================--
    --== OUTPUT DATA ==--
    --=================--

    -- Bitslip the output to serializer

    i_gbt_tx_bitslip0 : entity work.gbt_tx_bitslip
    port map(
        fabric_clk  => oserdes_clkdiv,
        reset       => reset,
        bitslip_cnt => to_integer(unsigned(gbt_tx_bitslip0)),
        din         => to_gbt(7 downto 0), -- 16 bit data input, synchronized to frame-clock
        dout        => to_gbt_bitslipped (7 downto 0)
    );

    i_gbt_tx_bitslip1 : entity work.gbt_tx_bitslip
    port map(
        fabric_clk  => oserdes_clkdiv,
        reset       => reset,
        bitslip_cnt => to_integer(unsigned(gbt_tx_bitslip1)),
        din         => to_gbt (15 downto 8), -- 16 bit data input, synchronized to frame-clock
        dout        => to_gbt_bitslipped (15 downto 8)
    );


    -- Rearrange data to account for how the serdes handles the bits
    --     ie, if data comes in 0, 1, 2, 3, 4, 5, 6, 7,
    --         the output will be 3210, 7654
    -------------------------------------------------------------

    process(oserdes_clkdiv)
    begin
    if (rising_edge(oserdes_clkdiv)) then
        if (reset='1') then
            to_gbt_remapped   <= (others => '0');
        else

            -- 10 bit mapping
            to_gbt_remapped <=
                to_gbt_bitslipped(12) &
                to_gbt_bitslipped(13) &
                to_gbt_bitslipped(14) &
                to_gbt_bitslipped(15) &
                to_gbt_bitslipped(8) &
                to_gbt_bitslipped(9) &
                to_gbt_bitslipped(10) &
                to_gbt_bitslipped(11) &
                to_gbt_bitslipped(0) &
                to_gbt_bitslipped(1) &
                to_gbt_bitslipped(2) &
                to_gbt_bitslipped(3) &
                to_gbt_bitslipped(4) &
                to_gbt_bitslipped(5) &
                to_gbt_bitslipped(6) &
                to_gbt_bitslipped(7);

        end if;
    end if;
    end process;

    -- register input to the oserdes for better timing

    process(oserdes_clkdiv)
    begin
    if (rising_edge(oserdes_clkdiv)) then
            to_gbt_reg <= to_gbt_remapped;
    end if;
    end process;


    -- To ensure that data flows out of all OSERDESE1 blocks in a multiple bit output structure:
    --  1) Place a register in front of the OSERDESE1 inputs.
    --  2) Clock the register by the CLKDIV clock of the OSERDESE1.
    --  3) Use the same reset signal for the register as for the OSERDESE1.


    -- Output serializer
    -- we want to output the data on the falling edge of the clock so that the GBT can sample on the rising edge

    i_to_gbt_ser80 : entity work.to_gbt_ser
    port map(
        data_out_from_device    => to_gbt_reg(7 downto 0),
        data_out_to_pins_p      => elink_o_p(0 downto 0),
        data_out_to_pins_n      => elink_o_n(0 downto 0),
        clk_in                  => oserdes_clk,
        clk_div_in              => oserdes_clkdiv,
        io_reset                => oserdes_reset
    );

    i_to_gbt_ser320 : entity work.to_gbt_ser
    port map(
        -- POLARITY SWAP ON ELINK #1
        data_out_from_device    => (not (to_gbt_reg (15 downto 8))),
        data_out_to_pins_p      => elink_o_p(1 downto 1),
        data_out_to_pins_n      => elink_o_n(1 downto 1),
        clk_in                  => oserdes_clk,
        clk_div_in              => oserdes_clkdiv,
        io_reset                => oserdes_reset
    );

    --=====================--
    --== DOMAIN CROSSING ==--
    --=====================--

    -- transition data from sampling clock to fabric clock
    -- and vice versa

    -- data from gbt to FPGA clock domain

    i_gbt_to_fpga_clk : entity work.gbt_cdc_fifo
    port map(
        rst  => reset,
        wr_en => '1',
        rd_en => '1',
        din => from_gbt,
        dout => data_o,
        wr_clk => iserdes_clkdiv,
        rd_clk => clock,
        full => open,
        empty => open
    );

    -- data from FPGA clock domain to GBT frame clock

    i_fpga_to_gbt_clk : entity work.gbt_cdc_fifo
    port map(
        rst  => reset,
        wr_en => '1',
        rd_en => '1',
        din => data_i,
        dout => to_gbt,
        wr_clk => clock,
        rd_clk  => oserdes_clkdiv,
        full => open,
        empty => open
    );

end Behavioral;
