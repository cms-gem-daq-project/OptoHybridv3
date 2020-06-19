library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library UNISIM;
use UNISIM.VCOMPONENTS.all;

--***********************************Entity Declaration************************

entity gtp_wrapper is
  generic (
    NUM_GTS : integer := 4
    );
  port
    (
      refclk_in_p : in std_logic_vector(1 downto 0);
      refclk_in_n : in std_logic_vector(1 downto 0);

      sysclk_in        : in  std_logic;
      soft_reset_tx_in : in  std_logic;
      pll_lock_out     : out std_logic;

      status_o  : in mgt_status_array (NUM_GTS-1 downto 0);
      control_i : out mgt_control_array (NUM_GTS-1 downto 0);

      tx_usrclk_out : out std_logic_vector (NUM_GTS-1 downto 0);
      txcharisk_i   : in  t_std2_array (NUM_GTS-1 downto 0);
      txdata_i      : in  t_std16_array (NUM_GTS-1 downto 0)
      );

end gtp_wrapper;

architecture RTL of gtp_wrapper is

  signal std_logic0 : std_logic := '0';
  signal std_logic1 : std_logic := '1';

  component gtp
    port
      (
        soft_reset_tx_in            : in std_logic;
        dont_reset_on_data_error_in : in std_logic;
        q0_clk0_gtrefclk_pad_n_in   : in std_logic;
        q0_clk0_gtrefclk_pad_p_in   : in std_logic;
        q0_clk1_gtrefclk_pad_n_in   : in std_logic;
        q0_clk1_gtrefclk_pad_p_in   : in std_logic;

        gt0_tx_fsm_reset_done_out : out std_logic;
        gt0_rx_fsm_reset_done_out : out std_logic;
        gt0_data_valid_in         : in  std_logic;
        gt0_tx_mmcm_lock_out      : out std_logic;
        gt1_tx_fsm_reset_done_out : out std_logic;
        gt1_rx_fsm_reset_done_out : out std_logic;
        gt1_data_valid_in         : in  std_logic;
        gt1_tx_mmcm_lock_out      : out std_logic;
        gt2_tx_fsm_reset_done_out : out std_logic;
        gt2_rx_fsm_reset_done_out : out std_logic;
        gt2_data_valid_in         : in  std_logic;
        gt2_tx_mmcm_lock_out      : out std_logic;
        gt3_tx_fsm_reset_done_out : out std_logic;
        gt3_rx_fsm_reset_done_out : out std_logic;
        gt3_data_valid_in         : in  std_logic;
        gt3_tx_mmcm_lock_out      : out std_logic;

        gt0_txusrclk_out  : out std_logic;
        gt0_txusrclk2_out : out std_logic;

        gt1_txusrclk_out  : out std_logic;
        gt1_txusrclk2_out : out std_logic;

        gt2_txusrclk_out  : out std_logic;
        gt2_txusrclk2_out : out std_logic;

        gt3_txusrclk_out  : out std_logic;
        gt3_txusrclk2_out : out std_logic;

        --_________________________________________________________________________
        --gt0  (x0y0)
        --____________________________channel ports________________________________
        ---------------------------- channel - drp ports  --------------------------
        gt0_drpaddr_in           : in  std_logic_vector(8 downto 0);
        gt0_drpdi_in             : in  std_logic_vector(15 downto 0);
        gt0_drpdo_out            : out std_logic_vector(15 downto 0);
        gt0_drpen_in             : in  std_logic;
        gt0_drprdy_out           : out std_logic;
        gt0_drpwe_in             : in  std_logic;
        ------------------------------- loopback ports -----------------------------
        gt0_loopback_in          : in  std_logic_vector(2 downto 0);
        --------------------- rx initialization and reset ports --------------------
        gt0_eyescanreset_in      : in  std_logic;
        -------------------------- rx margin analysis ports ------------------------
        gt0_eyescandataerror_out : out std_logic;
        gt0_eyescantrigger_in    : in  std_logic;
        ------------------- receive ports - pattern checker ports ------------------
        gt0_rxprbserr_out        : out std_logic;
        gt0_rxprbssel_in         : in  std_logic_vector(2 downto 0);
        ------------------- receive ports - pattern checker ports ------------------
        gt0_rxprbscntreset_in    : in  std_logic;
        ------------------- receive ports - rx buffer bypass ports -----------------
        gt0_rxphmonitor_out      : out std_logic_vector(4 downto 0);
        gt0_rxphslipmonitor_out  : out std_logic_vector(4 downto 0);
        ------------ receive ports - rx decision feedback equalizer(dfe) -----------
        gt0_dmonitorout_out      : out std_logic_vector(14 downto 0);
        ------------- receive ports - rx initialization and reset ports ------------
        gt0_gtrxreset_in         : in  std_logic;
        gt0_rxlpmreset_in        : in  std_logic;
        --------------------- tx initialization and reset ports --------------------
        gt0_gttxreset_in         : in  std_logic;
        gt0_txuserrdy_in         : in  std_logic;
        ------------------ transmit ports - fpga tx interface ports ----------------
        gt0_txdata_in            : in  std_logic_vector(15 downto 0);
        ------------------ transmit ports - tx 8b/10b encoder ports ----------------
        gt0_txcharisk_in         : in  std_logic_vector(1 downto 0);
        --------------- transmit ports - tx configurable driver ports --------------
        gt0_gtptxn_out           : out std_logic;
        gt0_gtptxp_out           : out std_logic;
        gt0_txdiffctrl_in        : in  std_logic_vector(3 downto 0);
        ----------- transmit ports - tx fabric clock output control ports ----------
        gt0_txoutclkfabric_out   : out std_logic;
        gt0_txoutclkpcs_out      : out std_logic;
        ------------- transmit ports - tx initialization and reset ports -----------
        gt0_txpcsreset_in        : in  std_logic;
        gt0_txpmareset_in        : in  std_logic;
        gt0_txresetdone_out      : out std_logic;
        ------------------ transmit ports - pattern generator ports ----------------
        gt0_txprbssel_in         : in  std_logic_vector(2 downto 0);

        --gt1  (x0y1)
        --____________________________channel ports________________________________
        ---------------------------- channel - drp ports  --------------------------
        gt1_drpaddr_in           : in  std_logic_vector(8 downto 0);
        gt1_drpdi_in             : in  std_logic_vector(15 downto 0);
        gt1_drpdo_out            : out std_logic_vector(15 downto 0);
        gt1_drpen_in             : in  std_logic;
        gt1_drprdy_out           : out std_logic;
        gt1_drpwe_in             : in  std_logic;
        ------------------------------- loopback ports -----------------------------
        gt1_loopback_in          : in  std_logic_vector(2 downto 0);
        --------------------- rx initialization and reset ports --------------------
        gt1_eyescanreset_in      : in  std_logic;
        -------------------------- rx margin analysis ports ------------------------
        gt1_eyescandataerror_out : out std_logic;
        gt1_eyescantrigger_in    : in  std_logic;
        ------------------- receive ports - pattern checker ports ------------------
        gt1_rxprbserr_out        : out std_logic;
        gt1_rxprbssel_in         : in  std_logic_vector(2 downto 0);
        ------------------- receive ports - pattern checker ports ------------------
        gt1_rxprbscntreset_in    : in  std_logic;
        ------------------- receive ports - rx buffer bypass ports -----------------
        gt1_rxphmonitor_out      : out std_logic_vector(4 downto 0);
        gt1_rxphslipmonitor_out  : out std_logic_vector(4 downto 0);
        ------------ receive ports - rx decision feedback equalizer(dfe) -----------
        gt1_dmonitorout_out      : out std_logic_vector(14 downto 0);
        ------------- receive ports - rx initialization and reset ports ------------
        gt1_gtrxreset_in         : in  std_logic;
        gt1_rxlpmreset_in        : in  std_logic;
        --------------------- tx initialization and reset ports --------------------
        gt1_gttxreset_in         : in  std_logic;
        gt1_txuserrdy_in         : in  std_logic;
        ------------------ transmit ports - fpga tx interface ports ----------------
        gt1_txdata_in            : in  std_logic_vector(15 downto 0);
        ------------------ transmit ports - tx 8b/10b encoder ports ----------------
        gt1_txcharisk_in         : in  std_logic_vector(1 downto 0);
        --------------- transmit ports - tx configurable driver ports --------------
        gt1_gtptxn_out           : out std_logic;
        gt1_gtptxp_out           : out std_logic;
        gt1_txdiffctrl_in        : in  std_logic_vector(3 downto 0);
        ----------- transmit ports - tx fabric clock output control ports ----------
        gt1_txoutclkfabric_out   : out std_logic;
        gt1_txoutclkpcs_out      : out std_logic;
        ------------- transmit ports - tx initialization and reset ports -----------
        gt1_txpcsreset_in        : in  std_logic;
        gt1_txpmareset_in        : in  std_logic;
        gt1_txresetdone_out      : out std_logic;
        ------------------ transmit ports - pattern generator ports ----------------
        gt1_txprbssel_in         : in  std_logic_vector(2 downto 0);

        --gt2  (x0y2)
        --____________________________channel ports________________________________
        ---------------------------- channel - drp ports  --------------------------
        gt2_drpaddr_in           : in  std_logic_vector(8 downto 0);
        gt2_drpdi_in             : in  std_logic_vector(15 downto 0);
        gt2_drpdo_out            : out std_logic_vector(15 downto 0);
        gt2_drpen_in             : in  std_logic;
        gt2_drprdy_out           : out std_logic;
        gt2_drpwe_in             : in  std_logic;
        ------------------------------- loopback ports -----------------------------
        gt2_loopback_in          : in  std_logic_vector(2 downto 0);
        --------------------- rx initialization and reset ports --------------------
        gt2_eyescanreset_in      : in  std_logic;
        -------------------------- rx margin analysis ports ------------------------
        gt2_eyescandataerror_out : out std_logic;
        gt2_eyescantrigger_in    : in  std_logic;
        ------------------- receive ports - pattern checker ports ------------------
        gt2_rxprbserr_out        : out std_logic;
        gt2_rxprbssel_in         : in  std_logic_vector(2 downto 0);
        ------------------- receive ports - pattern checker ports ------------------
        gt2_rxprbscntreset_in    : in  std_logic;
        ------------------- receive ports - rx buffer bypass ports -----------------
        gt2_rxphmonitor_out      : out std_logic_vector(4 downto 0);
        gt2_rxphslipmonitor_out  : out std_logic_vector(4 downto 0);
        ------------ receive ports - rx decision feedback equalizer(dfe) -----------
        gt2_dmonitorout_out      : out std_logic_vector(14 downto 0);
        ------------- receive ports - rx initialization and reset ports ------------
        gt2_gtrxreset_in         : in  std_logic;
        gt2_rxlpmreset_in        : in  std_logic;
        --------------------- tx initialization and reset ports --------------------
        gt2_gttxreset_in         : in  std_logic;
        gt2_txuserrdy_in         : in  std_logic;
        ------------------ transmit ports - fpga tx interface ports ----------------
        gt2_txdata_in            : in  std_logic_vector(15 downto 0);
        ------------------ transmit ports - tx 8b/10b encoder ports ----------------
        gt2_txcharisk_in         : in  std_logic_vector(1 downto 0);
        --------------- transmit ports - tx configurable driver ports --------------
        gt2_gtptxn_out           : out std_logic;
        gt2_gtptxp_out           : out std_logic;
        gt2_txdiffctrl_in        : in  std_logic_vector(3 downto 0);
        ----------- transmit ports - tx fabric clock output control ports ----------
        gt2_txoutclkfabric_out   : out std_logic;
        gt2_txoutclkpcs_out      : out std_logic;
        ------------- transmit ports - tx initialization and reset ports -----------
        gt2_txpcsreset_in        : in  std_logic;
        gt2_txpmareset_in        : in  std_logic;
        gt2_txresetdone_out      : out std_logic;
        ------------------ transmit ports - pattern generator ports ----------------
        gt2_txprbssel_in         : in  std_logic_vector(2 downto 0);

        --gt3  (x0y3)
        --____________________________channel ports________________________________
        ---------------------------- channel - drp ports  --------------------------
        gt3_drpaddr_in           : in  std_logic_vector(8 downto 0);
        gt3_drpdi_in             : in  std_logic_vector(15 downto 0);
        gt3_drpdo_out            : out std_logic_vector(15 downto 0);
        gt3_drpen_in             : in  std_logic;
        gt3_drprdy_out           : out std_logic;
        gt3_drpwe_in             : in  std_logic;
        ------------------------------- loopback ports -----------------------------
        gt3_loopback_in          : in  std_logic_vector(2 downto 0);
        --------------------- rx initialization and reset ports --------------------
        gt3_eyescanreset_in      : in  std_logic;
        -------------------------- rx margin analysis ports ------------------------
        gt3_eyescandataerror_out : out std_logic;
        gt3_eyescantrigger_in    : in  std_logic;
        ------------------- receive ports - pattern checker ports ------------------
        gt3_rxprbserr_out        : out std_logic;
        gt3_rxprbssel_in         : in  std_logic_vector(2 downto 0);
        ------------------- receive ports - pattern checker ports ------------------
        gt3_rxprbscntreset_in    : in  std_logic;
        ------------------- receive ports - rx buffer bypass ports -----------------
        gt3_rxphmonitor_out      : out std_logic_vector(4 downto 0);
        gt3_rxphslipmonitor_out  : out std_logic_vector(4 downto 0);
        ------------ receive ports - rx decision feedback equalizer(dfe) -----------
        gt3_dmonitorout_out      : out std_logic_vector(14 downto 0);
        ------------- receive ports - rx initialization and reset ports ------------
        gt3_gtrxreset_in         : in  std_logic;
        gt3_rxlpmreset_in        : in  std_logic;
        --------------------- tx initialization and reset ports --------------------
        gt3_gttxreset_in         : in  std_logic;
        gt3_txuserrdy_in         : in  std_logic;
        ------------------ transmit ports - fpga tx interface ports ----------------
        gt3_txdata_in            : in  std_logic_vector(15 downto 0);
        ------------------ transmit ports - tx 8b/10b encoder ports ----------------
        gt3_txcharisk_in         : in  std_logic_vector(1 downto 0);
        --------------- transmit ports - tx configurable driver ports --------------
        gt3_gtptxn_out           : out std_logic;
        gt3_gtptxp_out           : out std_logic;
        gt3_txdiffctrl_in        : in  std_logic_vector(3 downto 0);
        ----------- transmit ports - tx fabric clock output control ports ----------
        gt3_txoutclkfabric_out   : out std_logic;
        gt3_txoutclkpcs_out      : out std_logic;
        ------------- transmit ports - tx initialization and reset ports -----------
        gt3_txpcsreset_in        : in  std_logic;
        gt3_txpmareset_in        : in  std_logic;
        gt3_txresetdone_out      : out std_logic;
        ------------------ transmit ports - pattern generator ports ----------------
        gt3_txprbssel_in         : in  std_logic_vector(2 downto 0);

        gt0_pll0pd_in          : in  std_logic;
        gt0_drpaddr_common_in  : in  std_logic_vector(7 downto 0);
        gt0_drpdi_common_in    : in  std_logic_vector(15 downto 0);
        gt0_drpdo_common_out   : out std_logic_vector(15 downto 0);
        gt0_drpen_common_in    : in  std_logic;
        gt0_drprdy_common_out  : out std_logic;
        gt0_drpwe_common_in    : in  std_logic;
        --____________________________common ports________________________________
        gt0_pll0outclk_out     : out std_logic;
        gt0_pll0outrefclk_out  : out std_logic;
        gt0_pll0lock_out       : out std_logic;
        gt0_pll0refclklost_out : out std_logic;
        gt0_pll1outclk_out     : out std_logic;
        gt0_pll1outrefclk_out  : out std_logic;

        sysclk_in : in std_logic

        );

  end component;

begin

  ------------ optional Ports assignments --------------
  --gt0_txdiffctrl_i <= "1100";
  ------------------------------------------------------

  ----------------------------- The GT Wrapper -----------------------------

  -- Use the instantiation template in the example directory to add the GT wrapper to your design.
  -- In this example, the wrapper is wired up for basic operation with a frame generator and frame
  -- checker. The GTs will reset, then attempt to align and transmit data. If channel bonding is
  -- enabled, bonding should occur after alignment
  -- While connecting the GT TX/RX Reset ports below, please add a delay of
  -- minimum 500ns as mentioned in AR 43482.

  gtp_inst : gtp
    port map (

      soft_reset_tx_in => soft_reset_tx_in,

      DONT_RESET_ON_DATA_ERROR_IN => std_logic0,

      Q0_CLK0_GTREFCLK_PAD_N_IN => refclk_in_n(0),
      Q0_CLK0_GTREFCLK_PAD_P_IN => refclk_in_p(0),
      --Q0_CLK1_GTREFCLK_PAD_N_IN   => refclk_in_n(1),
      --Q0_CLK1_GTREFCLK_PAD_P_IN   => refclk_in_p(1),

      GT0_TX_FSM_RESET_DONE_OUT => status_o(0).txfsm_reset_done,
      GT1_TX_FSM_RESET_DONE_OUT => status_o(0).txfsm_reset_done,
      GT2_TX_FSM_RESET_DONE_OUT => status_o(0).txfsm_reset_done,
      GT3_TX_FSM_RESET_DONE_OUT => status_o(0).txfsm_reset_done,

      GT0_DATA_VALID_IN => std_logic1,
      GT1_DATA_VALID_IN => std_logic1,
      GT2_DATA_VALID_IN => std_logic1,
      GT3_DATA_VALID_IN => std_logic1,

      GT0_RX_FSM_RESET_DONE_OUT => open,
      GT1_RX_FSM_RESET_DONE_OUT => open,
      GT2_RX_FSM_RESET_DONE_OUT => open,
      GT3_RX_FSM_RESET_DONE_OUT => open,

      GT0_TXUSRCLK_OUT => tx_usrclk_out(0),
      GT1_TXUSRCLK_OUT => tx_usrclk_out(1),
      GT2_TXUSRCLK_OUT => tx_usrclk_out(2),
      GT3_TXUSRCLK_OUT => tx_usrclk_out(3),

      --------------------------------------------------------------------------------
      -- Common ports
      --------------------------------------------------------------------------------

      gt0_pll0outclk_out     => open,
      gt0_pll0outrefclk_out  => open,
      gt0_pll0lock_out       => pll_lock_out,
      gt0_pll0refclklost_out => open,
      gt0_pll1outclk_out     => open,
      gt0_pll1outrefclk_out  => open,
      sysclk_in              => sysclk_in,

      --------------------------------------------------------------------------------
      -- DRP
      --------------------------------------------------------------------------------
      gt0_drpaddr_in => drp_i(0).addr,
      gt0_drpdi_in   => drp_i(0).di,
      gt0_drpen_in   => drp_i(0).en,
      gt0_drpwe_in   => drp_i(0).we,
      gt0_drpdo_out  => drp_o(0).do,
      gt0_drprdy_out => drp_o(0).rdy,

      ---------------------------- Channel - DRP Ports  --------------------------
      gt1_drpaddr_in => drp_i(1).addr,
      gt1_drpdi_in   => drp_i(1).di,
      gt1_drpen_in   => drp_i(1).en,
      gt1_drpwe_in   => drp_i(1).we,
      gt1_drpdo_out  => drp_o(1).do,
      gt1_drprdy_out => drp_o(1).rdy,

      ---------------------------- Channel - DRP Ports  --------------------------
      gt2_drpaddr_in => drp_i(2).addr,
      gt2_drpdi_in   => drp_i(2).di,
      gt2_drpen_in   => drp_i(2).en,
      gt2_drpwe_in   => drp_i(2).we,
      gt2_drpdo_out  => drp_o(2).do,
      gt2_drprdy_out => drp_o(2).rdy,

      ---------------------------- Channel - DRP Ports  --------------------------
      gt3_drpaddr_in => drp_i(3).addr,
      gt3_drpdi_in   => drp_i(3).di,
      gt3_drpen_in   => drp_i(3).en,
      gt3_drpwe_in   => drp_i(3).we,
      gt3_drpdo_out  => drp_o(3).do,
      gt3_drprdy_out => drp_o(3).rdy,


      -- The user should drive TXUSERRDY High after these conditions are met:
      --   (1) The user interface is ready to transmit data to the GTX/GTH transceiver.
      --   (2) All clocks used by the application including TXUSRCLK/TXUSRCLK2 are shown as stable or locked when the
      --       PLL or MMCM is use
      gt0_txuserrdy_in => control_i(0).txuserrdy,
      gt1_txuserrdy_in => control_i(1).txuserrdy,
      gt2_txuserrdy_in => control_i(2).txuserrdy,
      gt3_txuserrdy_in => control_i(3).txuserrdy,

      gt0_txprbssel_in => control_i(0).txprbssel,
      gt1_txprbssel_in => control_i(1).txprbssel,
      gt2_txprbssel_in => control_i(2).txprbssel,
      gt3_txprbssel_in => control_i(3).txprbssel,

      gt0_txpcsreset_in => control_i(0).txpcsreset,
      gt1_txpcsreset_in => control_i(1).txpcsreset,
      gt2_txpcsreset_in => control_i(2).txpcsreset,
      gt3_txpcsreset_in => control_i(3).txpcsreset,

      gt0_txpmareset_in => control_i(0).txpmareset,
      gt1_txpmareset_in => control_i(1).txpmareset,
      gt2_txpmareset_in => control_i(2).txpmareset,
      gt3_txpmareset_in => control_i(3).txpmareset,

      gt0_gttxreset_in => control_i(0).gttxreset,
      gt1_gttxreset_in => control_i(1).gttxreset,
      gt2_gttxreset_in => control_i(2).gttxreset,
      gt3_gttxreset_in => control_i(3).gttxreset,

      gt0_loopback_in => control_i(0).loopback,
      gt1_loopback_in => control_i(1).loopback,
      gt2_loopback_in => control_i(2).loopback,
      gt3_loopback_in => control_i(3).loopback,

      gt0_rxprbscntreset_in => control_i(0).rxprbscntreset,
      gt1_rxprbscntreset_in => control_i(1).rxprbscntreset,
      gt2_rxprbscntreset_in => control_i(2).rxprbscntreset,
      gt3_rxprbscntreset_in => control_i(3).rxprbscntreset,

      gt0_rxprbsprbssel_in => control_i(0).rxprbsprbssel,
      gt1_rxprbsprbssel_in => control_i(1).rxprbsprbssel,
      gt2_rxprbsprbssel_in => control_i(2).rxprbsprbssel,
      gt3_rxprbsprbssel_in => control_i(3).rxprbsprbssel,

      gt0_rxprbsprbserr_in => status_o(0).rxprbsprbserr,
      gt1_rxprbsprbserr_in => status_o(1).rxprbsprbserr,
      gt2_rxprbsprbserr_in => status_o(2).rxprbsprbserr,
      gt3_rxprbsprbserr_in => status_o(3).rxprbsprbserr,

      gt0_rxphmonitor_out => open,
      gt1_rxphmonitor_out => open,
      gt2_rxphmonitor_out => open,
      gt3_rxphmonitor_out => open,

      gt0_rxphslipmonitor_out => open,
      gt1_rxphslipmonitor_out => open,
      gt2_rxphslipmonitor_out => open,
      gt3_rxphslipmonitor_out => open,


      --------------------------------------------------------------------------------
      --
      --------------------------------------------------------------------------------

      gt0_txdata_in => txdata_i (0),
      gt1_txdata_in => txdata_i (1),
      gt3_txdata_in => txdata_i (3),
      gt2_txdata_in => txdata_i (2),

      gt0_txcharisk_in => txcharisk_i(0),
      gt1_txcharisk_in => txcharisk_i(1),
      gt3_txcharisk_in => txcharisk_i(3),
      gt2_txcharisk_in => txcharisk_i(2),

      gt0_gtptxn_out => open,
      gt0_gtptxp_out => open,
      gt1_gtptxn_out => open,
      gt1_gtptxp_out => open,
      gt2_gtptxn_out => open,
      gt2_gtptxp_out => open,
      gt3_gtptxn_out => open,
      gt3_gtptxp_out => open,

      gt0_txdiffctrl_in => control_i(0).txdiffctrl,
      gt1_txdiffctrl_in => control_i(1).txdiffctrl,
      gt2_txdiffctrl_in => control_i(2).txdiffctrl,
      gt3_txdiffctrl_in => control_i(3).txdiffctrl,

      gt0_txresetdone_out => status_o(0).txreset_done,
      gt1_txresetdone_out => status_o(1).txreset_done,
      gt2_txresetdone_out => status_o(2).txreset_done,
      gt3_txresetdone_out => status_o(3).txreset_done,

      gt0_txoutclkpcs_out => open,
      gt1_txoutclkpcs_out => open,
      gt2_txoutclkpcs_out => open,
      gt3_txoutclkpcs_out => open,

      gt0_txoutclkfabric_out => open,
      gt1_txoutclkfabric_out => open,
      gt2_txoutclkfabric_out => open,
      gt3_txoutclkfabric_out => open,

      gt0_rxlpmreset_in => std_logic0,  -- TX Initialization and Reset Ports
      gt1_rxlpmreset_in => std_logic0,  -- TX Initialization and Reset Ports
      gt2_rxlpmreset_in => std_logic0,  -- TX Initialization and Reset Ports
      gt3_rxlpmreset_in => std_logic0,  -- TX Initialization and Reset Ports

      -- unused eyescan ports
      gt0_eyescanreset_in      => std_logic0,  -- RX Initialization and Reset Ports
      gt0_eyescandataerror_out => open,        -- RX Margin Analysis Ports
      gt0_eyescantrigger_in    => std_logic0,  -- RX Margin Analysis Ports
      gt0_dmonitorout_out      => open,        -- Receive Ports
      gt0_gtrxreset_in         => std_logic0,  -- Receive Ports - RX Initialization and Reset Ports

      gt1_eyescanreset_in      => std_logic0,  -- RX Initialization and Reset Ports
      gt1_eyescandataerror_out => open,        -- RX Margin Analysis Ports
      gt1_eyescantrigger_in    => std_logic0,  -- RX Margin Analysis Ports
      gt1_dmonitorout_out      => open,        -- Receive Ports
      gt1_gtrxreset_in         => std_logic0,  -- Receive Ports - RX Initialization and Reset Ports

      gt2_eyescanreset_in      => std_logic0,  -- RX Initialization and Reset Ports
      gt2_eyescandataerror_out => open,        -- RX Margin Analysis Ports
      gt2_eyescantrigger_in    => std_logic0,  -- RX Margin Analysis Ports
      gt2_dmonitorout_out      => open,        -- Receive Ports
      gt2_gtrxreset_in         => std_logic0,  -- Receive Ports - RX Initialization and Reset Ports

      gt3_eyescanreset_in      => std_logic0,  -- RX Initialization and Reset Ports
      gt3_eyescandataerror_out => open,        -- RX Margin Analysis Ports
      gt3_eyescantrigger_in    => std_logic0,  -- RX Margin Analysis Ports
      gt3_dmonitorout_out      => open,        -- Receive Ports
      gt3_gtrxreset_in         => std_logic0   -- Receive Ports - RX Initialization and Reset Ports

      );


end RTL;
