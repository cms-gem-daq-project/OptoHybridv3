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
    data_clk_i       : in std_logic;
    frame_clk_i      : in std_logic;
    clock            : in std_logic;

    -- serial data
    elink_o_p        : out std_logic_vector(1 downto 0);
    elink_o_n        : out std_logic_vector(1 downto 0);

    elink_i_p        : in  std_logic_vector(1 downto 0);
    elink_i_n        : in  std_logic_vector(1 downto 0);

    -- parallel data
    data_i           : in std_logic_vector (15 downto 0);
    data_o           : out std_logic_vector(15 downto 0);
    valid_o          : out std_logic
);
end gbt_serdes;

architecture Behavioral of gbt_serdes is

    signal from_gbt_raw      : std_logic_vector(15 downto 0) := (others => '0');
    signal from_gbt          : std_logic_vector(15 downto 0) := (others => '0');

    signal to_gbt            : std_logic_vector(15 downto 0) := (others => '0');
    signal to_gbt_polswap    : std_logic_vector(15 downto 0) := (others => '0');
    signal to_gbt_bitslipped : std_logic_vector(15 downto 0) := (others => '0');
    signal to_gbt_remap      : std_logic_vector(15 downto 0) := (others => '0');
    signal to_gbt_reg        : std_logic_vector(15 downto 0) := (others => '0');

    signal iserdes_reset     : std_logic := '1';
    signal oserdes_reset     : std_logic := '1';

    signal from_gbt_s1       : std_logic_vector(15 downto 0) := (others => '0');
    signal from_gbt_s2       : std_logic_vector(15 downto 0) := (others => '0');

    signal   to_gbt_s1       : std_logic_vector(15 downto 0) := (others => '0');
    signal   to_gbt_s2       : std_logic_vector(15 downto 0) := (others => '0');

    -- ignore timing on s1 for metastability chain
    attribute ASYNC_REG     : string;
    attribute ASYNC_REG of from_gbt_s1: signal is "TRUE";
    attribute ASYNC_REG of   to_gbt_s1: signal is "TRUE";

    signal data_clk_inv : std_logic;
    signal oserdes_clk : std_logic;
    signal oserdes_clkdiv : std_logic;
    signal iserdes_clk : std_logic;
    signal iserdes_clkdiv : std_logic;

    signal pulse_length     : std_logic_vector (3 downto 0) := x"f";

    signal reset : std_logic;

begin

    oserdes_clk    <= not data_clk_i;
    oserdes_clkdiv <= frame_clk_i;

    iserdes_clk    <= data_clk_i;
    iserdes_clkdiv <= frame_clk_i;

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

    process (frame_clk_i) begin
    if (rising_edge(frame_clk_i)) then
        reset <= reset_i;
    end if;
    end process;

    process(iserdes_clkdiv)
    begin
    if (rising_edge(iserdes_clkdiv)) then
        iserdes_reset <= reset;
    end if;
    end process;

    process(oserdes_clkdiv)
    begin
    if (rising_edge(oserdes_clkdiv)) then
        oserdes_reset <= reset;
    end if;
    end process;

    --================--
    --== INPUT DATA ==--
    --================--

    -- Input deserializer
    i_from_gbt_des : entity work.from_gbt_des
    port map(
        data_in_from_pins_p => elink_i_p,
        data_in_from_pins_n => elink_i_n,
        data_in_to_device   => from_gbt_raw,
        bitslip             => '0',
        clk_in              => iserdes_clk,
        clk_div_in          => iserdes_clkdiv,
        io_reset            => iserdes_reset
    );


    -- remap to account for how the Xilinx IPcore assigns the output pins
    -- flip-flop for routing and alignment
    process (iserdes_clkdiv) begin
        if (rising_edge(iserdes_clkdiv)) then
            from_gbt <= from_gbt_raw(1) & from_gbt_raw(3) & from_gbt_raw(5) & from_gbt_raw(7) & from_gbt_raw(9) & from_gbt_raw(11) & from_gbt_raw(13) & from_gbt_raw(15)  &
                        from_gbt_raw(0) & from_gbt_raw(2) & from_gbt_raw(4) & from_gbt_raw(6) & from_gbt_raw(8) & from_gbt_raw(10) & from_gbt_raw(12) & from_gbt_raw(14);
        end if;
    end process;

    --=================--
    --== OUTPUT DATA ==--
    --=================--

    -- tx polarity swaps

    process(oserdes_clkdiv)
    begin
    if (rising_edge(oserdes_clkdiv)) then
        if (oserdes_reset='1') then
            to_gbt_polswap <= (others => '0');
        else

            -- OH v3a has POLARITY SWAP on elink 1
            to_gbt_polswap <= not to_gbt (15 downto 8) & to_gbt (7 downto 0);

        end if;
    end if;
    end process;

    -- Bitslip the output to serializer

    i_gbt_tx_bitslip : entity work.gbt_tx_bitslip
    port map(
        fabric_clk  => oserdes_clkdiv,
        reset       => oserdes_reset,
        bitslip_cnt => 0,
        din         => to_gbt_polswap, -- 16 bit data input, synchronized to frame-clock
        dout        => to_gbt_bitslipped
    );


    -- Rearrange data to account for how the serdes handles the bits
    --     ie, if data comes in 0, 1, 2, 3, 4, 5, 6, 7,
    --         the output will be 3210, 7654
    -------------------------------------------------------------

    process(oserdes_clkdiv)
    begin
    if (rising_edge(oserdes_clkdiv)) then
        if (oserdes_reset='1') then
            to_gbt_remap   <= (others => '0');
        else


            -- dout <=    data(15) & data(7) &
            --            data(14) & data(6) &
            --            data(13) & data(5) &
            --            data(12) & data(4) &
            --            data(11) & data(3) &
            --            data(10) & data(2) &
            --            data(9)  & data(1) &
            --            data(8)  & data(0) ;

            to_gbt_remap <= to_gbt_bitslipped(8)  & to_gbt_bitslipped(0) &
                            to_gbt_bitslipped(9)  & to_gbt_bitslipped(1) &
                            to_gbt_bitslipped(10) & to_gbt_bitslipped(2) &
                            to_gbt_bitslipped(11) & to_gbt_bitslipped(3) &
                            to_gbt_bitslipped(12) & to_gbt_bitslipped(4) &
                            to_gbt_bitslipped(13) & to_gbt_bitslipped(5) &
                            to_gbt_bitslipped(14) & to_gbt_bitslipped(6) &
                            to_gbt_bitslipped(15) & to_gbt_bitslipped(7);
        end if;
    end if;
    end process;

    -- register input to the oserdes for better timing

    process(oserdes_clk)
    begin
    if (rising_edge(oserdes_clk)) then
            to_gbt_reg <= to_gbt_remap;
    end if;
    end process;


    -- To ensure that data flows out of all OSERDESE1 blocks in a multiple bit output structure:
    --  1) Place a register in front of the OSERDESE1 inputs.
    --  2) Clock the register by the CLKDIV clock of the OSERDESE1.
    --  3) Use the same reset signal for the register as for the OSERDESE1.


    -- Output serializer
    -- we want to output the data on the falling edge of the clock so that the GBT can sample on the rising edge

    i_to_gbt_ser : entity work.to_gbt_ser
    port map(
        data_out_from_device    => to_gbt_remap,
        data_out_to_pins_p      => elink_o_p,
        data_out_to_pins_n      => elink_o_n,
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
    process(clock)
    begin
        if (rising_edge(clock)) then
            from_gbt_s1 <= from_gbt;
            from_gbt_s2 <= from_gbt_s1;
        end if;
    end process;

    data_o <= from_gbt_s2; -- synchronized from "from_gbt"

    -- data from FPGA clock domain to GBT frame clock

    process(oserdes_clkdiv)
    begin
        if (rising_edge(oserdes_clkdiv)) then
            to_gbt_s1 <= data_i;
            to_gbt_s2 <= to_gbt_s1;
        end if;
    end process;

    to_gbt <= to_gbt_s2;   -- synchronized from data_i

end Behavioral;
