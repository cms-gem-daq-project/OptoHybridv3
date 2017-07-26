----------------------------------------------------------------------------------
-- CMS Muon Endcap
-- GEM Collaboration
-- Optohybrid v3 Firmware -- GBT SerDes
-- 2017/07/24 -- Conversion to 16 bit (2 elinks only)
-- 2017/07/24 -- Addition of flip-flop synchronization stages for X-domain transit
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


library unisim;
use unisim.vcomponents.all;

library work;

entity gbt is
generic(
    DEBUG : boolean := FALSE
);
port(
    -- reset
    sync_reset_i     : in std_logic;

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
end gbt;

architecture Behavioral of gbt is

    signal from_gbt_raw     : std_logic_vector(15 downto 0) := (others => '0');
    signal from_gbt         : std_logic_vector(15 downto 0) := (others => '0');

    signal to_gbt           : std_logic_vector(15 downto 0) := (others => '0');
    signal to_gbt_raw       : std_logic_vector(15 downto 0) := (others => '0');

    signal io_reset         : std_logic := '0';

    signal from_gbt_s1      : std_logic_vector(15 downto 0) := (others => '0');
    signal from_gbt_s2      : std_logic_vector(15 downto 0) := (others => '0');

    signal   to_gbt_s1      : std_logic_vector(15 downto 0) := (others => '0');
    signal   to_gbt_s2      : std_logic_vector(15 downto 0) := (others => '0');

    signal data_clk_inv : std_logic;

begin

    data_clk_inv <= not data_clk_i;

    --================--
    --==    RESET   ==--
    --================--

    -- power-on reset - this must be a clock synchronous pulse of a minimum of 2 and max 32 clock cycles (ISERDES spec)

    process(clock)
        variable pulse_length : unsigned (3 downto 0) := to_unsigned(15,4);
    begin
        if (falling_edge(clock)) then
            if (sync_reset_i = '1') then
                pulse_length := to_unsigned(15,4);
            end if;

            if (pulse_length > 0) then
                io_reset <= '1';
                pulse_length := pulse_length - to_unsigned(1,4);
            else
                io_reset <= '0';
            end if;
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
        clk_in              => data_clk_i,
        clk_div_in          => frame_clk_i,
        io_reset            => io_reset
    );

    -- remap to account for how the Xilinx IPcore assigns the output pins
    from_gbt <= not from_gbt_raw(1) & not from_gbt_raw(3) & not from_gbt_raw(5) & not from_gbt_raw(7) & not from_gbt_raw(9) & not from_gbt_raw(11) & not from_gbt_raw(13) & not from_gbt_raw(15)  &
                not from_gbt_raw(0) & not from_gbt_raw(2) & not from_gbt_raw(4) & not from_gbt_raw(6) & not from_gbt_raw(8) & not from_gbt_raw(10) & not from_gbt_raw(12) & not from_gbt_raw(14);

    --=================--
    --== OUTPUT DATA ==--
    --=================--

    -- Bitslip and format the output to serializer
    -- Static bitslip count = 3

    i_gbt_tx_bitslip : entity work.gbt_tx_bitslip
    port map(
        fabric_clk  => frame_clk_i,
        reset       => io_reset,
        bitslip_cnt => 7,
        din         => to_gbt, -- 16 bit data input, synchronized to frame-clock
        dout        => to_gbt_raw
    );

    -- Output serializer
    i_to_gbt_ser : entity work.to_gbt_ser
    port map(
        data_out_from_device    => to_gbt_raw,
        data_out_to_pins_p      => elink_o_p,
        data_out_to_pins_n      => elink_o_n,
        clk_in                  => data_clk_inv,
        clk_div_in              => frame_clk_i,
        io_reset                => io_reset
    );

    valid_o <= not io_reset;

    --=====================--
    --== DOMAIN CROSSING ==--
    --=====================--

    -- transition data from sampling clock to fabric clock
    -- and vice versa

    process(clock)
    begin
        if (rising_edge(clock)) then
            from_gbt_s1 <= from_gbt;
            from_gbt_s2 <= from_gbt_s1;
        end if;
    end process;

    process(frame_clk_i)
    begin
        if (rising_edge(frame_clk_i)) then
            to_gbt_s1 <= data_i;
            to_gbt_s2 <= to_gbt_s1;
        end if;
    end process;


    data_o <= from_gbt_s2; -- synchronized from "from_gbt"
    to_gbt <= to_gbt_s2; -- synchronized from data_i

end Behavioral;
