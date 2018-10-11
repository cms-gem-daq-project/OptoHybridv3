----------------------------------------------------------------------------------
-- CMS Muon Endcap
-- GEM Collaboration
-- Optohybrid v3 Firmware -- GBT Tx Bitslip
-- T. Lenzi, A. Peck
----------------------------------------------------------------------------------
-- Description:
--   This module slips bits to accomodate different tx frame alignments
----------------------------------------------------------------------------------
-- 2017/07/27 -- Adaptation from v2 electronics
-- 2018/10/11 -- Change integer input to std_logic_vector for verilog compatibility
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity bitslip is
generic (
    g_WORD_SIZE : integer := 8
);
port(
    fabric_clk  : in  std_logic;
    reset       : in  std_logic;
    bitslip_cnt : in  std_logic_vector(2 downto 0);
    din         : in  std_logic_vector(g_WORD_SIZE-1 downto 0);
    dout        : out std_logic_vector(g_WORD_SIZE-1 downto 0)
);
end bitslip;

architecture behavioral of bitslip is

    signal buf : std_logic_vector(g_WORD_SIZE*2-1 downto 0) := (others => '0');
    signal data : std_logic_vector(g_WORD_SIZE-1 downto 0)   := (others => '0');

begin

    process(fabric_clk)
    begin
        if (rising_edge(fabric_clk)) then
            buf  <= buf(g_WORD_SIZE-1 downto 0) & din(g_WORD_SIZE-1 downto 0);
            data <= buf(g_WORD_SIZE-1 + to_integer(unsigned(bitslip_cnt)) downto to_integer(unsigned(bitslip_cnt)));
        end if;
    end process;

    dout <= data;

end behavioral;
