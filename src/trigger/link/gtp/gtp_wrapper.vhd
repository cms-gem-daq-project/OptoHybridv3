library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;

library unisim;
use unisim.vcomponents.all;

library work;
use work.types_pkg.all;
use work.hardware_pkg.all;

--***********************************Entity Declaration************************

entity gtp_wrapper is
  generic
    (
      NUM_GTS                     : integer := 4;
      WRAPPER_SIM_GTRESET_SPEEDUP : string  := "TRUE";  -- simulation setting for GT SecureIP model
      WRAPPER_SIMULATION          : integer := 0;       -- Set to 1 for simulation
      STABLE_CLOCK_PERIOD         : integer := 25
      );
  port
    (
      refclk_in_p : in std_logic_vector(1 downto 0);
      refclk_in_n : in std_logic_vector(1 downto 0);

      -- gtp/gtx
      gtptxn_out : out std_logic_vector(NUM_GTS-1 downto 0);
      gtptxp_out : out std_logic_vector(NUM_GTS-1 downto 0);

      sysclk_in        : in  std_logic;
      soft_reset_tx_in : in  std_logic;
      pll_lock_out     : out std_logic;

      status_o  : out mgt_status_array (NUM_GTS-1 downto 0);
      control_i : in  mgt_control_array (NUM_GTS-1 downto 0);

      drp_i : in  drp_i_array (NUM_GTS-1 downto 0);
      drp_o : out drp_o_array (NUM_GTS-1 downto 0);

      common_drp_i : in  drp_i_t ;
      common_drp_o : out drp_o_t ;

      mmcm_lock_i  : in  std_logic;
      mmcm_reset_o : out std_logic_vector(NUM_GTS-1 downto 0);

      txusrclk_in : in std_logic;
      txcharisk_i : in t_std2_array (NUM_GTS-1 downto 0);
      txdata_i    : in t_std16_array (NUM_GTS-1 downto 0)
      );

end gtp_wrapper;

architecture RTL of gtp_wrapper is

  constant zero : std_logic := '0';
  constant one  : std_logic := '1';

  signal refclk       : std_logic;

  signal common_reset : std_logic;
  signal cpll_pd      : std_logic;
  signal cpll_reset   : std_logic;
  signal gttxreset   : std_logic_vector(3 downto 0);

  signal txresetdone : std_logic_vector(3 downto 0);
  signal txuserrdy   : std_logic_vector(3 downto 0);

  --------------------------- TX Buffer Bypass Signals --------------------

  signal rst_tx_phalignment       : std_logic;
  signal rst_tx_phalignment_array : std_logic_vector(3 downto 0);
  signal run_tx_phalignment       : std_logic;
  signal run_tx_phalignment_array : std_logic_vector(3 downto 0);

  signal tx_phalignment_done : std_logic;
  signal txdlyen             : std_logic_vector(3 downto 0);
  signal txdlysreset         : std_logic_vector(3 downto 0);
  signal txdlysresetdone     : std_logic_vector(3 downto 0);
  signal txphalign           : std_logic_vector(3 downto 0);
  signal txphaligndone       : std_logic_vector(3 downto 0);
  signal txphalignen         : std_logic_vector(3 downto 0) := (others => '1');
  signal txphdlyreset        : std_logic_vector(3 downto 0) := (others => '0');
  signal txphinit            : std_logic_vector(3 downto 0);
  signal txphinitdone        : std_logic_vector(3 downto 0);

  signal pll0_clk         : std_logic;
  signal pll0_lock        : std_logic;
  signal pll0_refclk      : std_logic;
  signal pll0_refclklost  : std_logic;
  signal pll0_reset       : std_logic;
  signal pll0_reset_array : std_logic_vector(3 downto 0);
  signal pll1_clk         : std_logic;
  signal pll1_refclk      : std_logic;

begin

  gtp_gt_gen : for I in 0 to 3 generate
  begin

    gtp_GT_inst : entity work.gtp_GT
      generic map (
        -- Simulation attributes
        GT_SIM_GTRESET_SPEEDUP => WRAPPER_SIM_GTRESET_SPEEDUP,
        EXAMPLE_SIMULATION     => WRAPPER_SIMULATION,
        TXSYNC_OVRD_IN         => ('1'),
        TXSYNC_MULTILANE_IN    => ('0')
        )
      port map (
        drpclk_in  => sysclk_in,
        drpaddr_in => drp_i(I).addr (8 downto 0),
        drpdi_in   => drp_i(I).di,
        drpen_in   => drp_i(I).en,
        drpwe_in   => drp_i(I).we,
        drpdo_out  => drp_o(I).do,
        drprdy_out => drp_o(I).rdy,

        pll0clk_in    => pll0_clk,
        pll0refclk_in => pll0_refclk,
        pll1clk_in    => pll1_clk,
        pll1refclk_in => pll1_refclk,

        -- eyescan
        eyescanreset_in      => zero,
        eyescandataerror_out => open,
        eyescantrigger_in    => zero,
        dmonitorout_out      => open,

        gtrxreset_in => one,            -- rx disabled

        txdata_in    => txdata_i(I),
        txcharisk_in => txcharisk_i(I),

        rxlpmreset_in => zero,

        txusrclk_in  => txusrclk_in,
        txusrclk2_in => txusrclk_in,
        txdlyen_in   => txdlyen(I),

        txdlysreset_in      => txdlysreset(I),      --
        txdlysresetdone_out => txdlysresetdone(I),  --
        txphalign_in        => txphalign(I),        --
        txphaligndone_out   => txphaligndone(I),
        txphalignen_in      => txphalignen(I),
        txphdlyreset_in     => txphdlyreset(I),
        txphinit_in         => txphinit(I),
        txphinitdone_out    => txphinitdone(I),

        gtptxn_out => gtptxn_out(I),
        gtptxp_out => gtptxp_out(I),


        txprbsforceerr_in => control_i(I).txprbsforceerr,

        txuserrdy_in      => txuserrdy(I),
        txprbssel_in      => control_i(I).txprbssel,
        txpcsreset_in     => control_i(I).txpcsreset,
        txpmareset_in     => control_i(I).txpmareset,
        gttxreset_in      => gttxreset(I),
        loopback_in       => control_i(I).txloopback,
        rxprbscntreset_in => control_i(I).rxprbscntreset,
        rxprbssel_in      => control_i(I).rxprbssel,
        txdiffctrl_in     => control_i(I).txdiffctrl,

        rxprbserr_out   => status_o(I).rxprbserr,
        txpmaresetdone  => status_o(I).txpmaresetdone,
        txresetdone_out => txresetdone(I),


        txoutclk_out       => open,
        txoutclkfabric_out => open,
        txoutclkpcs_out    => open
        );

    status_o(I).txreset_done <= txresetdone(I);

  end generate;

  startup_fsm_gen : for I in 0 to 3 generate
  begin
    txresetfsm_i : entity work.gtp_tx_startup_fsm

      generic map (
        EXAMPLE_SIMULATION     => WRAPPER_SIMULATION,
        STABLE_CLOCK_PERIOD    => STABLE_CLOCK_PERIOD,  -- period of the stable clock driving this state-machine, unit is [ns]
        retry_counter_bitwidth => 8,
        tx_pll0_used           => true,                 -- the tx and rx reset fsms must
        rx_pll0_used           => false,                -- share these two generic values
        phase_alignment_manual => true                  -- decision if a manual phase-alignment is necessary or the automatic
                                                        -- is enough. for single-lane applications the automatic alignment is
                                                        -- sufficient
        )
      port map (

        stable_clock => sysclk_in,
        txuserclk    => txusrclk_in,
        soft_reset   => soft_reset_tx_in,

        pll0refclklost => pll0_refclklost,
        pll0lock       => pll0_lock,

        pll0_reset        => pll0_reset_array(I),
        txuserrdy         => txuserrdy(I),
        txresetdone       => txresetdone(I),
        mmcm_lock         => mmcm_lock_i,
        mmcm_reset        => mmcm_reset_o(I),
        gttxreset         => gttxreset(I),
        tx_fsm_reset_done => status_o(I).txfsm_reset_done,
        run_phalignment   => run_tx_phalignment_array(I),
        reset_phalignment => rst_tx_phalignment_array(I),
        phalignment_done  => tx_phalignment_done,

        pll1refclklost => zero,
        pll1lock       => one,
        pll1_reset     => open,
        retry_counter  => open
        );
  end generate;

  cpll_reset_inst : entity work.gtp_cpll_railing
    generic map(USE_BUFG => 0)
    port map (
      cpll_reset_out => cpll_reset,
      cpll_pd_out    => cpll_pd,
      refclk_out     => open,
      refclk_in      => refclk
      );

  --IBUFDS_GTE2
  refclk_ibufds : IBUFDS_GTE2
    port map (
      O     => refclk,
      ODIV2 => open,
      CEB   => zero,
      I     => refclk_in_p(0),
      IB    => refclk_in_n(0)
      );

  gtp_common_inst : entity work.gtp_common
    generic map
    (
      wrapper_sim_gtreset_speedup => WRAPPER_SIM_GTRESET_SPEEDUP,
      sim_pll0refclk_sel          => "001",
      sim_pll1refclk_sel          => "001"
      )
    port map
    (
      drpclk_common_in  => sysclk_in,
      drpaddr_common_in => common_drp_i.addr (7 downto 0),
      drpdi_common_in   => common_drp_i.di,
      drpen_common_in   => common_drp_i.en,
      drpwe_common_in   => common_drp_i.we,
      drpdo_common_out  => common_drp_o.do,
      drprdy_common_out => common_drp_o.rdy,

      pll0outclk_out    => pll0_clk,
      pll0outrefclk_out => pll0_refclk,
      pll1outclk_out    => pll1_clk,
      pll1outrefclk_out => pll1_refclk,

      pll0lockdetclk_in  => sysclk_in,
      pll0lock_out       => pll0_lock,
      pll0refclklost_out => pll0_refclklost,
      pll0reset_in       => pll0_reset,

      pll0refclksel_in => "001",

      pll0pd_in => cpll_pd,

      gtrefclk0_in => refclk,
      gtrefclk1_in => zero
      );

  pll_lock_out <= pll0_lock;
  pll0_reset   <= common_reset or pll0_reset_array(0) or cpll_reset;

  common_reset_inst : entity work.gtp_common_reset
    generic map (
      STABLE_CLOCK_PERIOD => STABLE_CLOCK_PERIOD  -- Period of the stable clock driving this state-machine, unit is [ns]
      )
    port map (
      STABLE_CLOCK => sysclk_in,                  --Stable Clock, either a stable clock from the PCB
      SOFT_RESET   => soft_reset_tx_in,           --User Reset, can be pulled any time
      COMMON_RESET => common_reset                --Reset QPLL
      );

  --------------------------- TX Buffer Bypass Logic --------------------
  -- The TX SYNC Module drives the ports needed to Bypass the TX Buffer.
  -- Include the TX SYNC module in your own design if TX Buffer is bypassed.

  run_tx_phalignment <= and_reduce(run_tx_phalignment_array);
  rst_tx_phalignment <= and_reduce(rst_tx_phalignment_array);

  tx_manual_phase_inst : entity work.gtp_tx_manual_phase_align
    generic map (
      number_of_lanes => 4,
      master_lane_id  => 0
      )
    port map (
      stable_clock         => sysclk_in,
      reset_phalignment    => rst_tx_phalignment,
      run_phalignment      => run_tx_phalignment,
      phase_alignment_done => tx_phalignment_done,
      txdlysreset          => txdlysreset,
      txdlysresetdone      => txdlysresetdone,
      txphinit             => txphinit,
      txphinitdone         => txphinitdone,
      txphalign            => txphalign,
      txphaligndone        => txphaligndone,
      txdlyen              => txdlyen
      );

end RTL;
