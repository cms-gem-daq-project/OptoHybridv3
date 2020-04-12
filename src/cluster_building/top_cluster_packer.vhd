library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;

library work;
use work.types_pkg.all;
use work.hardware_pkg.all;

entity cluster_builder is
  port(
    clocks        : in  clocks_t;
    reset         : in  std_logic;
    cluster_count : out std_logic_vector (10 downto 0);
    deadtime      : in  std_logic_vector (3 downto 0);
    trig_stop     : in  std_logic;

    sbits_i : in sbits_array_t;

    clusters_o : out sbit_cluster_array_t (g_NUM_CLUSTERS-1 downto 0);

    overflow_o : out std_logic

    );
end cluster_builder;

architecture behavioral of cluster_builder is
  signal reset          : std_logic;
  signal latch_pulse_s0 : std_logic;
  signal latch_pulse_s1 : std_logic;

  signal overflow_out       : std_logic;
  signal overflow_dly       : std_logic;
  constant OVERFLOW_LATENCY : std_logic_vector (3 downto 0) := x"7";

  signal cluster_latch : std_logic;

  signal clusters : sbit_cluster_array_t (g_NUM_CLUSTERS-1 downto 0);

begin

  process (clocks.clk40)
  begin
    if (rising_edge(clocks.clk40)) then
      reset <= reset_i;
    end if;
  end process;

  --------------------------------------------------------------------------------
  -- Valid
  --------------------------------------------------------------------------------

  -- Create a 1 of 4 high signal synced to the 40MHZ clock
  --            ________________              _____________
  -- clk40    __|              |______________|
  --            _______________________________
  -- r80      __|                             |_____________
  --                     _______________________________
  -- r80_dly  ___________|                             |_____________
  --            __________                    __________
  -- valid    __|        |____________________|        |______

  process (clocks.clock320, clocks.clock40)
    variable r80     : std_logic := '0';
    variable r80_dly : std_logic;
  begin
    if (rising_edge(clocks.clock40)) then
      r80 := not r80;
    end if;

    if (rising_edge(clocks.clock160_0)) then
      r80_dly        := r80;
      latch_pulse_s1 <= latch_pulse_s0;
    end if;
  end process;

  latch_pulse_s0 <= r80_dly xor r80;

  --------------------------------------------------------------------------------
  -- Oneshot
  --------------------------------------------------------------------------------

  os_vfatloop : for os_vfat in 0 to (MXVFATS - 1) generate
    os_sbitloop : for os_sbit in 0 to (MXSBITS - 1) generate

      os_gen : if (ONESHOT) generate

        sbit_oneshot : entity work.x_oneshot
          port map (
            d          => vfat_s0(os_vfat)(os_sbit),
            q          => vfat_s1(os_vfat)(os_sbit),
            deadtime_i => deadtime,
            clock      => cluster_clock,
            slowclk    => clock1x
            );
      end generate;

      nos_gen : if (not ONESHOT) generate

        ----------------------------------------------------------------------------------------------------------------
        -- without the oneshot we can save 6.25 ns latency and make this transparent
        ----------------------------------------------------------------------------------------------------------------

        vfat_s1(os_vfat)(os_sbit) <= vfat_s0(os_vfat)(os_sbit);

      end generate;


    end generate;
  end generate;


  ------------------------------------------------------------------------------------------------------------------------
  -- remap vfats into partitions
  ------------------------------------------------------------------------------------------------------------------------

  ge21_partition_map_gen : if (GE21) generate
    invert_gen : if (INVERT_PARTITIONS) generate
      partition(0) <= vfat_s1(0) & vfat_s1(1) & vfat_s1(2) & vfat_s1(3) & vfat_s1(4) & vfat_s1(5);
      partition(1) <= vfat_s1(6) & vfat_s1(7) & vfat_s1(8) & vfat_s1(9) & vfat_s1(10) & vfat_s1(11);
    end generate;
    noninvert_gen : if (not INVERT_PARTITIONS) generate
      partition(1) <= vfat_s1(0) & vfat_s1(1) & vfat_s1(2) & vfat_s1(3) & vfat_s1(4) & vfat_s1(5);
      partition(0) <= vfat_s1(6) & vfat_s1(7) & vfat_s1(8) & vfat_s1(9) & vfat_s1(10) & vfat_s1(11);
    end generate;
  end generate;

  ge11_partition_map_gen : if (GE11) generate
    invert_gen : if (INVERT_PARTITIONS) generate
      partition(0) <= vfat_s1(23) & vfat_s1(15) & vfat_s1(7);
      partition(1) <= vfat_s1(22) & vfat_s1(14) & vfat_s1(6);
      partition(2) <= vfat_s1(21) & vfat_s1(13) & vfat_s1(5);
      partition(3) <= vfat_s1(20) & vfat_s1(12) & vfat_s1(4);
      partition(4) <= vfat_s1(19) & vfat_s1(11) & vfat_s1(3);
      partition(5) <= vfat_s1(18) & vfat_s1(10) & vfat_s1(2);
      partition(6) <= vfat_s1(17) & vfat_s1(9) & vfat_s1(1);
      partition(7) <= vfat_s1(16) & vfat_s1(8) & vfat_s1(0);
    end generate;
    invert_gen : if (not INVERT_PARTITIONS) generate
      partition(0) <= vfat_s1(16) & vfat_s1(8) & vfat_s1(0);
      partition(1) <= vfat_s1(17) & vfat_s1(9) & vfat_s1(1);
      partition(2) <= vfat_s1(18) & vfat_s1(10) & vfat_s1(2);
      partition(3) <= vfat_s1(19) & vfat_s1(11) & vfat_s1(3);
      partition(4) <= vfat_s1(20) & vfat_s1(12) & vfat_s1(4);
      partition(5) <= vfat_s1(21) & vfat_s1(13) & vfat_s1(5);
      partition(6) <= vfat_s1(22) & vfat_s1(14) & vfat_s1(6);
      partition(7) <= vfat_s1(23) & vfat_s1(15) & vfat_s1(7);
    end generate;
  end generate;

  ----------------------------------------------------------------------------------
  -- assign valid pattern flags
  ----------------------------------------------------------------------------------

  find_cluster_primaries : entity work.find_cluster_primaries
    generic map (
      MXPADS         => MXPADS,
      MXROWS         => MXROWS,
      MXKEYS         => MXKEYS,
      SPLIT_CLUSTERS => SPLIT_CLUSTERS  -- 1=long clusters will be split in two (0=the tails are dropped)
      )
    port map (
      clock => cluster_clock,
      sbits => sbits_s0,
      vpfs  => vpfs,
      cnts  => cnts
      );


  -- We count the number of cluster primaries. If it is greater than 8,
  -- generate an overflow flag. This can be used to change the fiber's frame
  -- separator to flag this to the receiving devices

  ----------------------------------------------------------------------------------
  -- count cluster sizes
  ----------------------------------------------------------------------------------

  count_clusters_inst : entity work.count_clusters
    port map (
      clock4x    => cluster_clock,
      reset      => reset,
      vpfs_i     => vpfs,
      cnt_o      => cluster_count,
      overflow_o => overflow_out
      );

  -- FIXME: need to align overflow and cluster count to data
  -- the output of the overflow flag should be delayed to lineup with the outputs from the priority encoding modules

  overflow_delay_inst : SRL16E
    port map (
      CLK => cluster_clock,
      CE  => '1',
      D   => overflow_out,
      Q   => overflow_dly,
      A0  => OVERFLOW_LATENCY(0),
      A1  => OVERFLOW_LATENCY(1),
      A2  => OVERFLOW_LATENCY(2),
      A3  => OVERFLOW_LATENCY(3)
      );

  ------------------------------------------------------------------------------------------------------------------------
  -- priority encoding
  ------------------------------------------------------------------------------------------------------------------------

  cluster_finder_inst : entity work.cluster_finder
    port map (

      vpfs_in => vpfs,
      cnts_in => cnts,

      latch_pulse => latch_pulse_s1,
      latch_out   => cluster_latch,

      adr0 => clusters.adr (0),
      adr1 => clusters.adr (1),
      adr2 => clusters.adr (2),
      adr3 => clusters.adr (3),
      adr4 => clusters.adr (4),
      adr5 => clusters.adr (5),
      adr6 => clusters.adr (6),
      adr7 => clusters.adr (7),

      prt0 => clusters.prt (0),
      prt1 => clusters.prt (1),
      prt2 => clusters.prt (2),
      prt3 => clusters.prt (3),
      prt4 => clusters.prt (4),
      prt5 => clusters.prt (5),
      prt6 => clusters.prt (6),
      prt7 => clusters.prt (7),

      cnt0 => clusters.cnt (0),
      cnt1 => clusters.cnt (1),
      cnt2 => clusters.cnt (2),
      cnt3 => clusters.cnt (3),
      cnt4 => clusters.cnt (4),
      cnt5 => clusters.cnt (5),
      cnt6 => clusters.cnt (6),
      cnt7 => clusters.cnt (7),

      vpf0 => clusters.vpf (0),
      vpf1 => clusters.vpf (1),
      vpf2 => clusters.vpf (2),
      vpf3 => clusters.vpf (3),
      vpf4 => clusters.vpf (4),
      vpf5 => clusters.vpf (5),
      vpf6 => clusters.vpf (6),
      vpf7 => clusters.vpf (7),

      clock => cluster_clock
      );

------------------------------------------------------------------------------------------------------------------------
-- Assign cluster outputs
------------------------------------------------------------------------------------------------------------------------

  cluster_assign : for I in 0 to (MXCLUSTERS-1) generate

    process (clocks.clk160_0)
    begin
      if (rising_edge(clocks.clk160_0)) then
        if (trig_stop = '1' or reset = '1') then
          overflow_o <= '0';
          clusters_o(I) <= (vpf => '0',
                            adr => (others => '1'),
                            cnt => (others => '1'),
                            prt => (others => '1')
                            );
        elsif (cluster_latch = '1') then
          overflow_o <= overflow_dly;
          clusters_o(I) <= (vpf => vpf(I),
                            adr => adr(I) or (others => not vpf(I)),
                            cnt => cnt(I),
                            prt => prt(I)
                            );
        end if;

      end if;
    end process;
  end generate;

end behavioral;
