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

  signal strobe    : std_logic;         -- 200MHz strobe
  signal tx_usrclk : std_logic;         -- 200MHz userclk
  signal is_kchar  : t_std2_array (NUM_OPTICAL_PACKETS-1 downto 0);
  signal mgt_words : t_std16_array (NUM_OPTICAL_PACKETS-1 downto 0);

  constant c_LINK_FRAME_CNT_MAX : integer := 4;
  signal link_frame_cnt         : integer range 0 to c_LINK_FRAME_CNT_MAX := 0;

  signal tx_prbs_mode : std_logic_vector (1 downto 0);

  --signal pll_reset            : std_logic;
  --signal mgt_reset            : std_logic_vector(3 downto 0);
  --signal gtxtest_start        : std_logic;
  --signal txreset              : std_logic;
  --signal mgt_realign          : std_logic;
  --signal txpowerdown          : std_logic;
  --signal txpowerdown_mode     : std_logic_vector (1 downto 0);
  --signal txpllpowerdown       : std_logic;

  ------ Register signals begin (this section is generated by <optohybrid_top>/tools/generate_registers.py -- do not edit)
    signal regs_read_arr        : t_std32_array(REG_MGT_NUM_REGS - 1 downto 0) := (others => (others => '0'));
    signal regs_write_arr       : t_std32_array(REG_MGT_NUM_REGS - 1 downto 0) := (others => (others => '0'));
    signal regs_addresses       : t_std32_array(REG_MGT_NUM_REGS - 1 downto 0) := (others => (others => '0'));
    signal regs_defaults        : t_std32_array(REG_MGT_NUM_REGS - 1 downto 0) := (others => (others => '0'));
    signal regs_read_pulse_arr  : std_logic_vector(REG_MGT_NUM_REGS - 1 downto 0) := (others => '0');
    signal regs_write_pulse_arr : std_logic_vector(REG_MGT_NUM_REGS - 1 downto 0) := (others => '0');
    signal regs_read_ready_arr  : std_logic_vector(REG_MGT_NUM_REGS - 1 downto 0) := (others => '1');
    signal regs_write_done_arr  : std_logic_vector(REG_MGT_NUM_REGS - 1 downto 0) := (others => '1');
    signal regs_writable_arr    : std_logic_vector(REG_MGT_NUM_REGS - 1 downto 0) := (others => '0');
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
        is_kchar  (I) <= fiber_kchars_i (I)((cnt+1)*2 -1 downto cnt*2);
      end if;
    end process;
  end generate;

  --------------------------------------------------------------------------------
  -- A7 MGT
  --------------------------------------------------------------------------------

  optics_gen : if (NUM_OPTICAL_PACKETS>0) generate
    constant NUM_GTS     : integer   := 4;
    signal soft_reset_tx : std_logic := '0';
    signal pll_lock      : std_logic;
    signal status        : mgt_status_array (3 downto 0);
    signal control       : mgt_control_array (3 downto 0);
    signal drp_i         : drp_i_array (NUM_GTS-1 downto 0) := (others => drp_i_null);
    signal drp_o         : drp_o_array (NUM_GTS-1 downto 0);
    signal common_drp_i  : drp_i_t;
    signal common_drp_o  : drp_o_t;
  begin

    mgt_wrapper_inst : entity work.mgt_wrapper
      port map (

        refclk_in_p => refclk_p,
        refclk_in_n => refclk_n,

        sysclk_in => clocks.sysclk,

        soft_reset_tx_in => soft_reset_tx,

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

        mmcm_lock_i  => clocks.locked,
        mmcm_reset_o => mgt_mmcm_reset_o,

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

  --===============================================================================================
  -- (this section is generated by <optohybrid_top>/tools/generate_registers.py -- do not edit)
  --==== Registers begin ==========================================================================

    -- IPbus slave instanciation
    ipbus_slave_inst : entity work.ipbus_slave_tmr
        generic map(
           g_ENABLE_TMR           => EN_TMR_IPB_SLAVE_MGT,
           g_NUM_REGS             => REG_MGT_NUM_REGS,
           g_ADDR_HIGH_BIT        => REG_MGT_ADDRESS_MSB,
           g_ADDR_LOW_BIT         => REG_MGT_ADDRESS_LSB,
           g_USE_INDIVIDUAL_ADDRS => true
       )
       port map(
           ipb_reset_i            => ipb_reset_i,
           ipb_clk_i              => clocks.clk40,
           ipb_mosi_i             => ipb_mosi_i,
           ipb_miso_o             => ipb_miso_o,
           usr_clk_i              => clocks.clk40,
           regs_read_arr_i        => regs_read_arr,
           regs_write_arr_o       => regs_write_arr,
           read_pulse_arr_o       => regs_read_pulse_arr,
           write_pulse_arr_o      => regs_write_pulse_arr,
           regs_read_ready_arr_i  => regs_read_ready_arr,
           regs_write_done_arr_i  => regs_write_done_arr,
           individual_addrs_arr_i => regs_addresses,
           regs_defaults_arr_i    => regs_defaults,
           writable_regs_i        => regs_writable_arr
      );

    -- Addresses
    regs_addresses(0)(REG_MGT_ADDRESS_MSB downto REG_MGT_ADDRESS_LSB) <= x"0";

    -- Connect read signals
    regs_read_arr(0)(REG_MGT_TX_PRBS_MODE_MSB downto REG_MGT_TX_PRBS_MODE_LSB) <= tx_prbs_mode;

    -- Connect write signals
    tx_prbs_mode <= regs_write_arr(0)(REG_MGT_TX_PRBS_MODE_MSB downto REG_MGT_TX_PRBS_MODE_LSB);

    -- Connect write pulse signals

    -- Connect write done signals

    -- Connect read pulse signals

    -- Connect counter instances

    -- Connect rate instances

    -- Connect read ready signals

    -- Defaults
    regs_defaults(0)(REG_MGT_TX_PRBS_MODE_MSB downto REG_MGT_TX_PRBS_MODE_LSB) <= REG_MGT_TX_PRBS_MODE_DEFAULT;

    -- Define writable regs
    regs_writable_arr(0) <= '1';

--==== Registers end ============================================================================
end Behavioral;
