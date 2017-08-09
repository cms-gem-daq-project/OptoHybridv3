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
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity gbt_tx_bitslip is
port(
    fabric_clk  : in std_logic;
    reset       : in std_logic;
    bitslip_cnt : in integer range 0 to 7;
    din         : in std_logic_vector(15 downto 0);
    dout        : out std_logic_vector(15 downto 0)
);
end gbt_tx_bitslip;

architecture behavioral of gbt_tx_bitslip is

    signal buf1     : std_logic_vector(15 downto 0); -- buffer for elink 1
    signal buf2     : std_logic_vector(15 downto 0); -- buffer for elink 2

    signal data     : std_logic_vector(15 downto 0);

begin

    process(fabric_clk)
    begin
        if (rising_edge(fabric_clk)) then
            if (reset = '1') then
                buf1 <= (others => '0');
                buf2 <= (others => '0');
                data <= (others => '0');
            else
                buf1 <= buf1(7 downto 0) & din(7 downto 0);
                buf2 <= buf2(7 downto 0) & din(15 downto 8);

                data <= buf2((7 + bitslip_cnt) downto bitslip_cnt) &
                        buf1((7 + bitslip_cnt) downto bitslip_cnt);
            end if;
        end if;
    end process;

    dout <= data;

end behavioral;
