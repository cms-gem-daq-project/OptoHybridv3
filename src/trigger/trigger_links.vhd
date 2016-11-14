library ieee;
use ieee.std_logic_1164.all;

library work;
use work.types_pkg.all;

entity trigger_links is
port(
    mgt_refclk : in  std_logic;

    clk_40     : in  std_logic;
    clk_80     : in  std_logic;
    clk_160    : in  std_logic;

    reset      : in  std_logic;

    trg_tx_p   : out std_logic_vector (3 downto 0);
    trg_tx_n   : out std_logic_vector (3 downto 0);

    cluster0   : in  std_logic_vector (13 downto 0);
    cluster1   : in  std_logic_vector (13 downto 0);
    cluster2   : in  std_logic_vector (13 downto 0);
    cluster3   : in  std_logic_vector (13 downto 0);
    cluster4   : in  std_logic_vector (13 downto 0);
    cluster5   : in  std_logic_vector (13 downto 0);
    cluster6   : in  std_logic_vector (13 downto 0);
    cluster7   : in  std_logic_vector (13 downto 0);

    overflow   : in  std_logic
);
end trigger_links;

architecture Behavioral of trigger_links is
    signal this_signal : std_logic;
begin

Inst_trigger_links: entity work.trigger_links_v
port map(
    mgt_refclk => mgt_refclk,
    clk_40     => clk_40,  -- 40 MHz Clock Derived from QPLL
    clk_80     => clk_80,  -- 80 MHz Clock Derived from QPLL
    clk_160    => clk_160, -- 160 MHz Clock Derived from QPLL
    reset      => reset,
    trg_tx_p   => trg_tx_p,
    trg_tx_n   => trg_tx_n,
    cluster0   => cluster0,
    cluster1   => cluster1,
    cluster2   => cluster2,
    cluster3   => cluster3,
    cluster4   => cluster4,
    cluster5   => cluster5,
    cluster6   => cluster6,
    cluster7   => cluster7,
    overflow   => overflow
);

end Behavioral;
