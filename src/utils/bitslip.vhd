----------------------------------------------------------------------------------
-- CMS Muon Endcap
-- GEM Collaboration
-- Optohybrid v3 Firmware -- GBT Tx Bitslip
-- T. Lenzi, A. Peck
----------------------------------------------------------------------------------
-- Description:
--   This module slips bits to accomodate different tx frame alignments
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.types_pkg.all;

entity bitslip is
  generic (
    g_WORD_SIZE : integer := 8;
    g_EN_TMR    : integer := 0
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

  type buf_array_t is array(integer range <>) of std_logic_vector(g_WORD_SIZE*2-1 downto 0);
  type data_array_t is array(integer range <>) of std_logic_vector(g_WORD_SIZE-1 downto 0);

  signal buf : buf_array_t (2*g_EN_TMR downto 0);

  signal data     : data_array_t (2*g_EN_TMR downto 0);
  signal dout_tmr : data_array_t (2*g_EN_TMR downto 0);

  signal cnt : integer;

begin

  cnt <= to_integer(unsigned(bitslip_cnt));

  cluster_packer_loop : for I in 0 to 2*g_EN_TMR generate
  begin
    process(fabric_clk)
    begin
      if (rising_edge(fabric_clk)) then

        buf(I) <= buf(I)(g_WORD_SIZE-1 downto 0) & din(g_WORD_SIZE-1 downto 0);

        if (reset = '1') then
          data(I) <= (others => '0');
        else
          data(I) <= buf(I)(g_WORD_SIZE-1 + cnt downto cnt);
        end if;

      end if;
    end process;

  end generate;

  dout <= majority (data(0), data(1), data(2));

end behavioral;
