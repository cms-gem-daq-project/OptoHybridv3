library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;

library unisim;
use unisim.vcomponents.all;

library work;
use work.types_pkg.all;
use work.ipbus_pkg.all;
use work.hardware_pkg.all;
use work.registers.all;

entity trigger_data_phy is
  port(
    ----------------------------------------------------------------------------------------------------------------------
    -- Core
    ----------------------------------------------------------------------------------------------------------------------

    clocks           : in  clocks_t;
    reset_i          : in  std_logic;
    mgt_mmcm_reset_o : out std_logic_vector (3 downto 0);

    -- ipbus

    ipb_mosi_i  : in  ipb_wbus;
    ipb_miso_o  : out ipb_rbus;
    ipb_reset_i : in  std_logic;

    ----------------------------------------------------------------------------------------------------------------------
    -- Legacy Ports
    ----------------------------------------------------------------------------------------------------------------------

    clusters_i    : in sbit_cluster_array_t (NUM_FOUND_CLUSTERS-1 downto 0);
    overflow_i    : in std_logic;                       -- 1 bit gem has more than 8 clusters
    bxn_counter_i : in std_logic_vector (11 downto 0);  -- 12 bit bxn counter
    bc0_i         : in std_logic;                       -- 1  bit bx0 flag
    resync_i      : in std_logic;                       -- 1  bit bx0 flag

    ----------------------------------------------------------------------------------------------------------------------
    -- Physical
    ----------------------------------------------------------------------------------------------------------------------

    -- gtp/gtx
    trg_tx_n : out std_logic_vector(NUM_GT_TX-1 downto 0);
    trg_tx_p : out std_logic_vector(NUM_GT_TX-1 downto 0);

    -- refclk
    refclk_p : in std_logic_vector(NUM_GT_REFCLK-1 downto 0);
    refclk_n : in std_logic_vector(NUM_GT_REFCLK-1 downto 0);

    -- gbtx trigger data (ge21)
    gbt_trig_p : out std_logic_vector(MXELINKS-1 downto 0);
    gbt_trig_n : out std_logic_vector(MXELINKS-1 downto 0);

    ----------------------------------------------------------------------------------------------------------------------
    -- Data
    ----------------------------------------------------------------------------------------------------------------------

    fiber_kchars_i  : in t_std10_array (NUM_OPTICAL_PACKETS-1 downto 0);
    fiber_packets_i : in t_fiber_packet_array (NUM_OPTICAL_PACKETS-1 downto 0);
    elink_packets_i : in t_elink_packet_array (NUM_ELINK_PACKETS-1 downto 0)

    );
end trigger_data_phy;

architecture Behavioral of trigger_data_phy is

  constant NUM_GTS : integer := 4;

  signal strobe    : std_logic;         -- 200MHz strobe
  signal tx_usrclk : std_logic;         -- 200MHz userclk
  signal is_kchar  : t_std2_array (NUM_OPTICAL_PACKETS-1 downto 0);
  signal mgt_words : t_std16_array (NUM_OPTICAL_PACKETS-1 downto 0);

  constant c_LINK_FRAME_CNT_MAX : integer                                 := 4;
  signal link_frame_cnt         : integer range 0 to c_LINK_FRAME_CNT_MAX := 0;

  signal soft_reset_tx : std_logic                := '0';
  signal pll_lock      : std_logic;
  signal status        : mgt_status_array (3 downto 0);
  signal control       : mgt_control_array (3 downto 0);
  signal drp_i         : drp_i_array (3 downto 0) := (others => drp_i_null);
  signal drp_o         : drp_o_array (3 downto 0);

  ------ Register signals begin (this section is generated by <optohybrid_top>/tools/generate_registers.py -- do not edit)
  ------ Register signals end ----------------------------------------------

begin

  --------------------------------------------------------------------------------
  -- GE2/1 Copper Output
  --------------------------------------------------------------------------------

  ge21_elink_gen : if (GE21 = 1) and HAS_ELINK_OUTPUTS generate
    signal elink_packets : t_elink_packet_array (NUM_ELINK_PACKETS-1 downto 0);
  begin

    -- copy onto 40MHz clock, make sure it is stable... there might be a better (lower latency way to do this but at
    -- least this is safe)
    process (clocks.clk40)
    begin
      if (rising_edge(clocks.clk40)) then
        elink_packets <= elink_packets_i;
      end if;
    end process;

    elink_outputs : for I in 0 to (MXELINKS-1) generate
    begin
      to_gbt_ser_inst : entity work.to_gbt_ser
        port map (
          data_out_from_device  => elink_packets_i(0)(8*(I+1)-1 downto 8*I),
          data_out_to_pins_p(0) => gbt_trig_p(I),
          data_out_to_pins_n(0) => gbt_trig_n(I),
          clk_in                => clocks.clk160_0,
          clk_div_in            => clocks.clk40,
          io_reset              => reset_i
          );
    end generate;
  end generate;

  --------------------------------------------------------------------------------
  -- Optical Data Frames
  --------------------------------------------------------------------------------

  -- Create a 1 of n high signal synced to the slow clock, e.g.
  --             ______________                ____________
  -- clk40    __|              |______________|
  --             _____________________________
  -- r        __|                             |_____________
  --                ______________________________
  -- r_dly    ______|                             |_____________
  --             ___                           ___
  -- valid    __|   |_________________________|   |______
  --
  -- cnt        < 0 >< 1 >< 2 >< 3 >< 4 >< 5 >< 0>

  tx_usrclk <= clocks.clk200;

  clock_strobe_200_inst : entity work.clock_strobe
    port map (
      fast_clk_i => tx_usrclk,
      slow_clk_i => clocks.clk40,
      strobe_o   => strobe
      );

  process (tx_usrclk)
  begin
    if (rising_edge(tx_usrclk)) then
      if (strobe = '1') then
        link_frame_cnt <= 1;
      elsif (link_frame_cnt = c_LINK_FRAME_CNT_MAX) then
        link_frame_cnt <= 0;
      else
        link_frame_cnt <= link_frame_cnt + 1;
      end if;
    end if;
  end process;

  optical_outputs : for I in 0 to (NUM_OPTICAL_PACKETS-1) generate
    signal cnt : integer;
  begin
    cnt <= link_frame_cnt;
    process (tx_usrclk)
    begin
      if (rising_edge(tx_usrclk)) then
        mgt_words (I) <= fiber_packets_i(I)((cnt+1)*16-1 downto cnt*16);
        is_kchar (I)  <= fiber_kchars_i (I)((cnt+1)*2 -1 downto cnt*2);
      end if;
    end process;
  end generate;

  --------------------------------------------------------------------------------
  -- A7 MGT
  --------------------------------------------------------------------------------

  optics_gen : if (NUM_OPTICAL_PACKETS > 0 and not USE_LEGACY_OPTICS) generate
    signal common_drp_i : drp_i_t;
    signal common_drp_o : drp_o_t;
  begin

    mgt_wrapper_inst : entity work.mgt_wrapper
      port map (

        refclk_in_p => refclk_p,
        refclk_in_n => refclk_n,

        sysclk_in => clocks.clk40,

        soft_reset_tx_in => '0',

        pll_lock_out => pll_lock,

        status_o  => status,
        control_i => control,

        txusrclk_in => clocks.clk200,

        txp_out => trg_tx_p,
        txn_out => trg_tx_n,

        drp_i => drp_i,
        drp_o => drp_o,

        common_drp_i => common_drp_i,
        common_drp_o => common_drp_o,

        mmcm_lock_i => clocks.locked,

        txcharisk_i(0) => is_kchar(0),
        txcharisk_i(1) => is_kchar(0),
        txcharisk_i(2) => is_kchar(NUM_OPTICAL_PACKETS-1),
        txcharisk_i(3) => is_kchar(NUM_OPTICAL_PACKETS-1),

        txdata_i(0) => mgt_words(0),
        txdata_i(1) => mgt_words(0),
        txdata_i(2) => mgt_words(NUM_OPTICAL_PACKETS-1),
        txdata_i(3) => mgt_words(NUM_OPTICAL_PACKETS-1)
        );

  end generate;

  legacy_optics_gen : if (NUM_OPTICAL_PACKETS > 0 and USE_LEGACY_OPTICS) generate

    component gem_data_out
      generic (
        FPGA_TYPE_IS_VIRTEX6 : integer := 0;
        FPGA_TYPE_IS_ARTIX7  : integer := 1
        );
      port (
        trg_tx_n : out std_logic_vector (3 downto 0);
        trg_tx_p : out std_logic_vector (3 downto 0);

        refclk_n : in std_logic_vector (1 downto 0);
        refclk_p : in std_logic_vector (1 downto 0);

        tx_prbs_mode : in std_logic_vector (2 downto 0);

        gem_data      : in std_logic_vector (111 downto 0);  -- 56 bit gem data
        overflow_i    : in std_logic;                        -- 1 bit gem has more than 8 clusters
        bxn_counter_i : in std_logic_vector (11 downto 0);   -- 12 bit bxn counter
        bc0_i         : in std_logic;                        -- 1  bit bx0 flag
        resync_i      : in std_logic;                        -- 1  bit bx0 flag

        force_not_ready    : in std_logic;
        pll_reset_i        : in std_logic;
        mgt_reset_i        : in std_logic_vector(3 downto 0);
        gtxtest_start_i    : in std_logic;
        txreset_i          : in std_logic;
        mgt_realign_i      : in std_logic;
        txpowerdown_i      : in std_logic;
        txpowerdown_mode_i : in std_logic_vector (1 downto 0);
        txpllpowerdown_i   : in std_logic;

        clock_40  : in std_logic;
        clock_160 : in std_logic;

        ready_o      : out std_logic;
        pll_lock_o   : out std_logic;
        txfsm_done_o : out std_logic;

        reset_i : in std_logic
        );
    end component;

    function get_adr (partition : in std_logic_vector; strip : in std_logic_vector)
      return std_logic_vector is
      variable s : integer;
      variable p : integer;
    begin
      s := to_integer(unsigned(strip));
      p := to_integer(unsigned(partition));
      if (GE21 = 1) then
        return std_logic_vector(to_unsigned(p*384+s, 11));
      elsif (GE11 = 1) then
        return std_logic_vector(to_unsigned(p*192+s, 11));
      end if;
    end;

    signal legacy_clusters : t_std14_array (7 downto 0);

  begin


    cluster_loop : for I in 0 to 7 generate
      process (clocks.clk40)
      begin
        if (rising_edge(clocks.clk40)) then
          if (clusters_i(I).vpf = '1') then
            legacy_clusters(I) <= clusters_i(I).cnt & get_adr(clusters_i(I).adr, clusters_i(I).prt);
          else
            legacy_clusters(I) <= (others => '1');
          end if;
        end if;
      end process;
    end generate;

    gem_data_out_inst : gem_data_out
      generic map (
        FPGA_TYPE_IS_VIRTEX6 => GE11,
        FPGA_TYPE_IS_ARTIX7  => GE21
        )
      port map (

        refclk_p => refclk_p,           -- 160 MHz Reference Clock Positive
        refclk_n => refclk_n,           -- 160 MHz Reference Clock Negative

        clock_40  => clocks.clk40,      -- 40 MHz  Logic Clock
        clock_160 => clocks.clk160_0,   -- 160 MHz  Logic Clock

        bxn_counter_i => bxn_counter_i,
        bc0_i         => bc0_i,
        resync_i      => resync_i,

        reset_i => reset_i,

        force_not_ready => '0',

        ready_o      => open,
        pll_lock_o   => open,
        txfsm_done_o => open,
        tx_prbs_mode => (others => '0'),


        pll_reset_i        => '0',
        mgt_reset_i        => (others => '0'),
        gtxtest_start_i    => '0',
        txreset_i          => '0',
        mgt_realign_i      => '0',
        txpowerdown_i      => '0',
        txpowerdown_mode_i => (others => '0'),
        txpllpowerdown_i   => '0',

        trg_tx_p => trg_tx_p (3 downto 0),
        trg_tx_n => trg_tx_n (3 downto 0),

        gem_data => legacy_clusters(7) & legacy_clusters(6) & legacy_clusters(5) & legacy_clusters(4) & legacy_clusters(3) & legacy_clusters(2) & legacy_clusters(1) & legacy_clusters(0),

        overflow_i => overflow_i
        );

  end generate;

  --===============================================================================================
  -- (this section is generated by <optohybrid_top>/tools/generate_registers.py -- do not edit)
  --==== Registers begin ==========================================================================
  --==== Registers end ============================================================================

end Behavioral;
