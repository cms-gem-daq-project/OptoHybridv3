---------------------------------------------------------------------------------
-- CMS Muon Endcap
-- GEM Collaboration
-- Optohybrid v3 Firmware -- Top Logic
-- T. Lenzi, E. Juska, A. Peck
----------------------------------------------------------------------------------
-- 2017/07/21 -- Initial port to version 3 electronics
-- 2017/07/22 -- Additional MMCM added to monitor and dejitter the eport clock
-- 2017/07/25 -- Restructure top level module to improve organization
-- 2018/04/18 -- Mods for for OH lite compatibility
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;

library work;
use work.types_pkg.all;
use work.ipbus_pkg.all;
use work.trig_pkg.all;
use work.param_pkg.all;
library unisim;
use unisim.vcomponents.all;


entity top_optohybrid is
  generic (
    -- these generics get set by hog at synthesis
    GLOBAL_FWDATE       : std_logic_vector (31 downto 0) := x"00000000";
    GLOBAL_FWTIME       : std_logic_vector (31 downto 0) := x"00000000";
    OFFICIAL            : std_logic_vector (31 downto 0) := x"00000000";
    GLOBAL_FWHASH       : std_logic_vector (31 downto 0) := x"00000000";
    TOP_FWHASH          : std_logic_vector (31 downto 0) := x"00000000";
    XML_HASH            : std_logic_vector (31 downto 0) := x"00000000";
    GLOBAL_FWVERSION    : std_logic_vector (31 downto 0) := x"00000000";
    TOP_FWVERSION       : std_logic_vector (31 downto 0) := x"00000000";
    XML_VERSION         : std_logic_vector (31 downto 0) := x"00000000";
    HOG_FWHASH          : std_logic_vector (31 downto 0) := x"00000000";
    FRAMEWORK_FWVERSION : std_logic_vector (31 downto 0) := x"00000000";
    FRAMEWORK_FWHASH    : std_logic_vector (31 downto 0) := x"00000000"
    );
  port(

    --== Clocking ==--

    clock_p : in std_logic;
    clock_n : in std_logic;

    --== Elinks ==--

    elink_i_p : in std_logic;
    elink_i_n : in std_logic;

    elink_o_p : out std_logic;
    elink_o_n : out std_logic;

    --== GBT ==--

    -- only 1 connected in GE11, 2 in GE21
    gbt_txready_i : in std_logic_vector (MXREADY-1 downto 0);
    gbt_rxvalid_i : in std_logic_vector (MXREADY-1 downto 0);
    gbt_rxready_i : in std_logic_vector (MXREADY-1 downto 0);

    -- GE11
    ext_sbits_o : out  std_logic_vector (8*FPGA_TYPE_IS_VIRTEX6-1 downto 0);
    ext_reset_o : out  std_logic_vector (MXRESET*FPGA_TYPE_IS_VIRTEX6-1 downto 0);
    adc_vp : in  std_logic_vector (1*FPGA_TYPE_IS_VIRTEX6-1 downto 0);
    adc_vn : in  std_logic_vector (1*FPGA_TYPE_IS_VIRTEX6-1 downto 0);

    -- GE21
    gbt_txvalid_o  : out    std_logic_vector (MXREADY*FPGA_TYPE_IS_ARTIX7-1 downto 0);
    master_slave   : in     std_logic_vector (1*FPGA_TYPE_IS_ARTIX7-1 downto 0);
    master_slave_p : inout  std_logic_vector (12*FPGA_TYPE_IS_ARTIX7-1 downto 0);
    master_slave_n : inout  std_logic_vector (12*FPGA_TYPE_IS_ARTIX7-1 downto 0);
    vtrx_mabs_i    : in    std_logic_vector (1*FPGA_TYPE_IS_ARTIX7 downto 0);

    --== LEDs ==--

    led_o : out std_logic_vector (MXLED-1 downto 0);

    --== GTX ==--

    mgt_clk_p_i : in std_logic_vector (1 downto 0);
    mgt_clk_n_i : in std_logic_vector (1 downto 0);

    mgt_tx_p_o : out std_logic_vector(3 downto 0);
    mgt_tx_n_o : out std_logic_vector(3 downto 0);

    --== VFAT Trigger Data ==--

    vfat_sot_p : in std_logic_vector (MXVFATS-1 downto 0);
    vfat_sot_n : in std_logic_vector (MXVFATS-1 downto 0);

    vfat_sbits_p : in std_logic_vector ((MXVFATS*8)-1 downto 0);
    vfat_sbits_n : in std_logic_vector ((MXVFATS*8)-1 downto 0)

    );
end top_optohybrid;

architecture Behavioral of top_optohybrid is

  --== SBit cluster packer ==--

  signal sbit_overflow : std_logic;
  signal cluster_count : std_logic_vector (10 downto 0);
  signal active_vfats  : std_logic_vector (MXVFATS-1 downto 0);

  --== Global signals ==--

  signal idlyrdy           : std_logic;
  signal mmcm_locked       : std_logic;
  signal logic_mmcm_locked : std_logic;
  signal logic_mmcm_reset  : std_logic;
  signal eprt_mmcm_locked  : std_logic;

  signal clk40     : std_logic;
  signal clk160_0  : std_logic;
  signal clk160_90 : std_logic;
  signal clk200    : std_logic;

  signal vtrx_mabs : std_logic_vector (1 downto 0);

  signal gbt_txvalid : std_logic_vector (MXREADY-1 downto 0);
  signal gbt_txready : std_logic_vector (MXREADY-1 downto 0);
  signal gbt_rxvalid : std_logic_vector (MXREADY-1 downto 0);
  signal gbt_rxready : std_logic_vector (MXREADY-1 downto 0);

  signal gbt_link_ready       : std_logic;
  signal gbt_link_error       : std_logic;
  signal gbt_request_received : std_logic;

  signal mgts_ready : std_logic;
  signal pll_lock   : std_logic;
  signal txfsm_done : std_logic;

  signal trigger_reset : std_logic;
  signal core_reset    : std_logic;
  signal cnt_snap      : std_logic;

  signal ctrl_reset_vfats : std_logic_vector (11 downto 0);
  signal ttc_resync       : std_logic;
  signal ttc_l1a          : std_logic;
  signal ttc_bc0          : std_logic;

  --== Wishbone ==--

  -- Master
  signal ipb_mosi_gbt : ipb_wbus;
  signal ipb_miso_gbt : ipb_rbus;

  -- Master
  signal ipb_mosi_masters : ipb_wbus_array (WB_MASTERS-1 downto 0);
  signal ipb_miso_masters : ipb_rbus_array (WB_MASTERS-1 downto 0);

  -- Slaves
  signal ipb_mosi_slaves : ipb_wbus_array (WB_SLAVES-1 downto 0);
  signal ipb_miso_slaves : ipb_rbus_array (WB_SLAVES-1 downto 0);

  --== TTC ==--

  signal bxn_counter : std_logic_vector(11 downto 0);
  signal trig_stop   : std_logic;

  --== IOB Constraints for Outputs ==--

  attribute IOB  : string;
  attribute KEEP : string;

  signal ext_sbits  : std_logic_vector (7 downto 0);
  signal soft_reset : std_logic;

  signal led : std_logic_vector (15 downto 0);

  signal adc_vp_int : std_logic;
  signal adc_vn_int : std_logic;

  component reset port (

    clock_i : in std_logic;

    soft_reset : in std_logic;

    mmcms_locked_i : in std_logic;
    idlyrdy_i      : in std_logic;
    gbt_rxready_i  : in std_logic;
    gbt_rxvalid_i  : in std_logic;
    gbt_txready_i  : in std_logic;

    core_reset_o : out std_logic;
    reset_o      : out std_logic
    );
  end component;

begin

  -- internal wiring

  gbt_request_received <= ipb_mosi_gbt.ipb_strobe;


  --=============--
  --== Common  ==--
  --=============--

  led_o (MXLED-1 downto 0) <= led (MXLED-1 downto 0);

  gbt_rxready <= gbt_rxready_i;
  gbt_rxvalid <= gbt_rxvalid_i;
  gbt_txready <= gbt_txready_i;

  ge11_out_assign : if (FPGA_TYPE_IS_VIRTEX6='1') generate
    ext_reset_o  <= ctrl_reset_vfats;
    ext_sbits_o  <= ext_sbits;
  end generate;

  --==============--
  --== Clocking ==--
  --==============--

  clocking_inst : entity work.clocking
    port map(

      clock_p => clock_p,               -- phase shiftable 40MHz ttc clocks
      clock_n => clock_n,               --

      ipb_mosi_i  => ipb_mosi_slaves (IPB_SLAVE.CLOCKING),
      ipb_miso_o  => ipb_miso_slaves (IPB_SLAVE.CLOCKING),
      ipb_reset_i => core_reset,

      cnt_snap => cnt_snap,

      mmcm_locked_o => mmcm_locked,

      clk40_o     => clk40,             -- 40  MHz e-port aligned GBT clock
      clk160_0_o  => clk160_0,          -- 160  MHz e-port aligned GBT clock
      clk160_90_o => clk160_90,         -- 160  MHz e-port aligned GBT clock
      clk200_o    => clk200             -- 200  MHz e-port aligned GBT clock
      );

  reset_inst : reset
    port map (
      clock_i        => clk40,
      soft_reset     => soft_reset,
      mmcms_locked_i => mmcm_locked,
      gbt_rxready_i  => gbt_rxready(0),
      gbt_rxvalid_i  => gbt_rxvalid(0),
      gbt_txready_i  => gbt_txready(0),
      idlyrdy_i      => idlyrdy,
      core_reset_o   => core_reset,
      reset_o        => trigger_reset
      );

  --=========--
  --== GBT ==--
  --=========--

  gbt_inst : entity work.gbt
    port map(

      -- reset
      reset_i => core_reset,

      -- GBT

      gbt_rxready_i => gbt_rxready(0),
      gbt_rxvalid_i => gbt_rxvalid(0),
      gbt_txready_i => gbt_txready(0),

      -- input clocks

      gbt_clk40     => clk40,           -- 40 MHz frame clock
      gbt_clk160_0  => clk160_0,        --
      gbt_clk160_90 => clk160_90,       --

      clock_i => clk40,                 -- 320 MHz sampling clock

      -- elinks
      elink_i_p => elink_i_p,
      elink_i_n => elink_i_n,

      elink_o_p => elink_o_p,
      elink_o_n => elink_o_n,

      gbt_link_error_o => gbt_link_error,
      gbt_link_ready_o => gbt_link_ready,

      -- wishbone master
      ipb_mosi_o => ipb_mosi_gbt,
      ipb_miso_i => ipb_miso_gbt,

      -- wishbone slave

      ipb_mosi_i  => ipb_mosi_slaves (IPB_SLAVE.GBT),
      ipb_miso_o  => ipb_miso_slaves (IPB_SLAVE.GBT),
      ipb_reset_i => core_reset,

      cnt_snap => cnt_snap,

      -- decoded TTC
      resync_o => ttc_resync,
      l1a_o    => ttc_l1a,
      bc0_o    => ttc_bc0

      );

  --=====================--
  --== Wishbone switch ==--
  --=====================--

  -- This module is the Wishbone switch which redirects requests from the masters to the slaves.

  ipb_mosi_masters(0) <= ipb_mosi_gbt;
  ipb_miso_gbt        <= ipb_miso_masters(0);

  ipb_switch_inst : entity work.ipb_switch
    port map(
      clock_i => clk40,
      reset_i => core_reset,

      -- connect to master
      mosi_masters => ipb_mosi_masters,
      miso_masters => ipb_miso_masters,

      -- connect to slaves
      mosi_slaves => ipb_mosi_slaves,
      miso_slaves => ipb_miso_slaves
      );

  --====================--
  --== System Monitor ==--
  --====================--

  adc_v6 : if (FPGA_TYPE_IS_VIRTEX6='1') generate
    adc_vp_int <= adc_vp(0);
    adc_vn_int <= adc_vn(0);
  end generate;
  adc_a7 : if (FPGA_TYPE_IS_ARTIX7='1') generate
    adc_vp_int <= '1';
    adc_vn_int <= '0';
  end generate;

  adc_inst : entity work.adc port map(
    clock_i => clk40,
    reset_i => core_reset,

    cnt_snap => cnt_snap,

    ipb_mosi_i  => ipb_mosi_slaves (IPB_SLAVE.ADC),
    ipb_miso_o  => ipb_miso_slaves (IPB_SLAVE.ADC),
    ipb_reset_i => core_reset,
    ipb_clk_i   => clk40,

    adc_vp => adc_vp_int,
    adc_vn => adc_vn_int
    );

  --=============--
  --== Control ==--
  --=============--

  control_inst : entity work.control
    port map (

      mgts_ready => mgts_ready,         -- to drive LED controller only
      pll_lock   => pll_lock,
      txfsm_done => txfsm_done,

      --== TTC ==--

      clock_i     => clk40,
      gbt_clock_i => clk40,
      reset_i     => core_reset,

      ttc_l1a    => ttc_l1a,
      ttc_bc0    => ttc_bc0,
      ttc_resync => ttc_resync,

      ipb_mosi_i => ipb_mosi_slaves (IPB_SLAVE.CONTROL),
      ipb_miso_o => ipb_miso_slaves (IPB_SLAVE.CONTROL),

      -------------------
      -- status inputs --
      -------------------

      -- MMCM
      mmcms_locked_i     => mmcm_locked,
      dskw_mmcm_locked_i => mmcm_locked,
      eprt_mmcm_locked_i => '1',

      -- GBT

      gbt_link_ready_i => gbt_link_ready,

      gbt_rxready_i => gbt_rxready(0),
      gbt_rxvalid_i => gbt_rxvalid(0),
      gbt_txready_i => gbt_txready(0),

      gbt_request_received_i => gbt_request_received,

      -- Trigger

      active_vfats_i  => active_vfats,
      sbit_overflow_i => sbit_overflow,
      cluster_count_i => cluster_count,

      -- GBT
      gbt_link_error_i => gbt_link_error,

      ---------
      -- TTC --
      ---------

      bxn_counter_o => bxn_counter,

      trig_stop_o => trig_stop,

      --------------------
      -- config outputs --
      --------------------

      -- VFAT
      vfat_reset_o => ctrl_reset_vfats,
      ext_sbits_o  => ext_sbits,

      -- LEDs
      led_o => led,

      soft_reset_o => soft_reset,

      cnt_snap_o => cnt_snap

      );

  --==================--
  --== Trigger Data ==--
  --==================--

  trigger_inst : entity work.trigger
    port map (

      -- wishbone

      ipb_mosi_i => ipb_mosi_slaves(IPB_SLAVE.TRIG),
      ipb_miso_o => ipb_miso_slaves(IPB_SLAVE.TRIG),

      mgts_ready   => mgts_ready,
      pll_lock_o   => pll_lock,
      txfsm_done_o => txfsm_done,

      -- reset
      trigger_reset_i => trigger_reset,
      core_reset_i    => core_reset,
      cnt_snap        => cnt_snap,
      ttc_resync      => ttc_resync,

      -- clocks
      mgt_clk_p => mgt_clk_p_i,
      mgt_clk_n => mgt_clk_n_i,

      logic_mmcm_lock_i  => logic_mmcm_locked,
      logic_mmcm_reset_o => logic_mmcm_reset,

      clk_40  => clk40,
      clk_160 => clk160_0,

      clk_40_sbit     => clk40,
      clk_160_sbit    => clk160_0,
      clk_160_90_sbit => clk160_90,
      clk_200_sbit    => clk200,

      -- mgt pairs
      mgt_tx_p => mgt_tx_p_o,
      mgt_tx_n => mgt_tx_n_o,

      -- config
      cluster_count_o => cluster_count,
      overflow_o      => sbit_overflow,
      bxn_counter_i   => bxn_counter,
      ttc_bx0_i       => ttc_bc0,
      ttc_l1a_i       => ttc_l1a,

      -- sbit_ors

      active_vfats_o => active_vfats,

      -- trig stop from fmm

      trig_stop_i => trig_stop,

      -- sbits follow

      vfat_sbits_p => vfat_sbits_p,
      vfat_sbits_n => vfat_sbits_n,

      vfat_sot_p => vfat_sot_p,
      vfat_sot_n => vfat_sot_n

      );


-- IDELAYCTRL is needed for calibration
  delayctrl_inst : IDELAYCTRL
    port map (
      RDY    => idlyrdy,
      REFCLK => clk200,
      RST    => not mmcm_locked
      );

end Behavioral;
