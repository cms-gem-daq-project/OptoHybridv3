------------------------------------------------------------------------------------------------------------------------------------------------------
-- Company: TAMU
-- Engineer: Evaldas Juska (evaldas.juska@cern.ch, evka85@gmail.com)
--
-- Create Date:    12:22 2017-11-20
-- Module Name:    sbit_monitor
-- Description:    This module monitors the sbits cluster inputs and freezes a selected link whenever a valid sbit is detected there
------------------------------------------------------------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;

entity sbit_monitor is
  generic(
    g_NUM_OF_OHs : integer := 1
    );
  port(
    -- reset
    reset_i : in std_logic;

    -- TTC
    ttc_clk_i : in std_logic;
    l1a_i     : in std_logic;

    -- Sbit cluster inputs
    sbit_cluster_0 : in std_logic_vector (13 downto 0);
    sbit_cluster_1 : in std_logic_vector (13 downto 0);
    sbit_cluster_2 : in std_logic_vector (13 downto 0);
    sbit_cluster_3 : in std_logic_vector (13 downto 0);
    sbit_cluster_4 : in std_logic_vector (13 downto 0);
    sbit_cluster_5 : in std_logic_vector (13 downto 0);
    sbit_cluster_6 : in std_logic_vector (13 downto 0);
    sbit_cluster_7 : in std_logic_vector (13 downto 0);
    sbit_cluster_8 : in std_logic_vector (13 downto 0);
    sbit_cluster_9 : in std_logic_vector (13 downto 0);

    -- output
    frozen_cluster_0 : out std_logic_vector (13 downto 0);
    frozen_cluster_1 : out std_logic_vector (13 downto 0);
    frozen_cluster_2 : out std_logic_vector (13 downto 0);
    frozen_cluster_3 : out std_logic_vector (13 downto 0);
    frozen_cluster_4 : out std_logic_vector (13 downto 0);
    frozen_cluster_5 : out std_logic_vector (13 downto 0);
    frozen_cluster_6 : out std_logic_vector (13 downto 0);
    frozen_cluster_7 : out std_logic_vector (13 downto 0);
    frozen_cluster_8 : out std_logic_vector (13 downto 0);
    frozen_cluster_9 : out std_logic_vector (13 downto 0);

    l1a_delay_o : out std_logic_vector(31 downto 0)

    );
end sbit_monitor;

architecture sbit_monitor_arch of sbit_monitor is

  constant ZERO_SBITS : std_logic_vector (13 downto 0) := ("000" & "111" & x"FA");

  signal cluster_valid : std_logic_vector (9 downto 0);
  signal armed         : std_logic := '1';
  signal link_trigger  : std_logic;

  signal l1a_delay_run : std_logic := '0';
  signal l1a_delay     : unsigned(31 downto 0);

begin

  l1a_delay_o <= std_logic_vector(l1a_delay);

  cluster_valid (0) <= '0' when sbit_cluster_0 (10 downto 9) = "11" else '1';
  cluster_valid (1) <= '0' when sbit_cluster_1 (10 downto 9) = "11" else '1';
  cluster_valid (2) <= '0' when sbit_cluster_2 (10 downto 9) = "11" else '1';
  cluster_valid (3) <= '0' when sbit_cluster_3 (10 downto 9) = "11" else '1';
  cluster_valid (4) <= '0' when sbit_cluster_4 (10 downto 9) = "11" else '1';
  cluster_valid (5) <= '0' when sbit_cluster_5 (10 downto 9) = "11" else '1';
  cluster_valid (6) <= '0' when sbit_cluster_6 (10 downto 9) = "11" else '1';
  cluster_valid (7) <= '0' when sbit_cluster_7 (10 downto 9) = "11" else '1';
  cluster_valid (8) <= '0' when sbit_cluster_8 (10 downto 9) = "11" else '1';
  cluster_valid (9) <= '0' when sbit_cluster_9 (10 downto 9) = "11" else '1';

  link_trigger <= or_reduce(cluster_valid);

  -- freeze the sbits on the output when a trigger comes
  process(ttc_clk_i)
  begin
    if (rising_edge(ttc_clk_i)) then
      if (reset_i = '1') then
        frozen_cluster_0 <= ZERO_SBITS;
        frozen_cluster_1 <= ZERO_SBITS;
        frozen_cluster_2 <= ZERO_SBITS;
        frozen_cluster_3 <= ZERO_SBITS;
        frozen_cluster_4 <= ZERO_SBITS;
        frozen_cluster_5 <= ZERO_SBITS;
        frozen_cluster_6 <= ZERO_SBITS;
        frozen_cluster_7 <= ZERO_SBITS;
        frozen_cluster_8 <= ZERO_SBITS;
        frozen_cluster_9 <= ZERO_SBITS;
        armed            <= '1';
      else
        if (link_trigger = '1' and armed = '1') then
          frozen_cluster_0 <= sbit_cluster_0;
          frozen_cluster_1 <= sbit_cluster_1;
          frozen_cluster_2 <= sbit_cluster_2;
          frozen_cluster_3 <= sbit_cluster_3;
          frozen_cluster_4 <= sbit_cluster_4;
          frozen_cluster_5 <= sbit_cluster_5;
          frozen_cluster_6 <= sbit_cluster_6;
          frozen_cluster_7 <= sbit_cluster_7;
          frozen_cluster_8 <= sbit_cluster_8;
          frozen_cluster_9 <= sbit_cluster_9;
          armed            <= '0';
        end if;
      end if;
    end if;
  end process;

  -- count the gap between this sbit cluster and the following L1A
  process(ttc_clk_i)
  begin
    if (rising_edge(ttc_clk_i)) then
      if (reset_i = '1') then
        l1a_delay     <= (others => '0');
        l1a_delay_run <= '0';
      else

        if (link_trigger = '1' and armed = '1' and l1a_delay_run = '0') then
          l1a_delay_run <= '1';
        end if;

        if (l1a_delay_run = '1' and l1a_i = '1') then
          l1a_delay_run <= '0';
        end if;

        if (l1a_delay_run = '1') then
          l1a_delay <= l1a_delay + 1;
        end if;

      end if;
    end if;
  end process;


end sbit_monitor_arch;

