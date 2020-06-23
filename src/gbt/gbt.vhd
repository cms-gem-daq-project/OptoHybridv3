----------------------------------------------------------------------------------
-- CMS Muon Endcap
-- GEM Collaboration
-- Optohybrid v3 Firmware -- GBT
-- A. Peck
----------------------------------------------------------------------------------
-- Description:
--   This module implements all functionality required for communicating with GBTx
----------------------------------------------------------------------------------
-- 2017/07/24 -- Initial. Wrapper around GBT components to simplify top-level
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library unisim;
use unisim.vcomponents.all;

library work;
use work.types_pkg.all;
use work.ipbus_pkg.all;
use work.hardware_pkg.all;
use work.registers.all;

entity gbt is
  port(

    reset_i : in std_logic;

    clocks : in clocks_t;

    elink_i_p : in std_logic;
    elink_i_n : in std_logic;

    elink_o_p : out std_logic;
    elink_o_n : out std_logic;

    gbt_link_error_o : out std_logic;
    gbt_link_ready_o : out std_logic;

    ttc_o    : out ttc_t;

    cnt_snap : in std_logic;

    -- GBTx

    gbt_rxready_i : in std_logic;
    gbt_rxvalid_i : in std_logic;
    gbt_txready_i : in std_logic;

    -- wishbone master
    ipb_mosi_o : out ipb_wbus;
    ipb_miso_i : in  ipb_rbus;

    -- wishbone slave
    ipb_mosi_i  : in  ipb_wbus;
    ipb_miso_o  : out ipb_rbus;
    ipb_reset_i : in  std_logic
    );

end gbt;

architecture Behavioral of gbt is

  signal gbt_tx_data : std_logic_vector(7 downto 0) := (others => '0');
  signal gbt_rx_data : std_logic_vector(7 downto 0) := (others => '0');

  signal gbt_link_error    : std_logic;
  signal gbt_link_unstable : std_logic;
  signal gbt_link_ready    : std_logic;

  signal gbt_link_err_ready : std_logic;

  signal l1a_force    : std_logic;
  signal bc0_force    : std_logic;
  signal resync_force : std_logic;

  signal l1a_gbt    : std_logic;
  signal bc0_gbt    : std_logic;
  signal resync_gbt : std_logic;

  signal cnt_reset : std_logic;

  signal tx_delay : std_logic_vector (4 downto 0);

  -- wishbone master
  signal ipb_mosi : ipb_wbus;
  signal ipb_miso : ipb_rbus;

  ------ Register signals begin (this section is generated by <optohybrid_top>/tools/generate_registers.py -- do not edit)
    signal regs_read_arr        : t_std32_array(REG_GBT_NUM_REGS - 1 downto 0) := (others => (others => '0'));
    signal regs_write_arr       : t_std32_array(REG_GBT_NUM_REGS - 1 downto 0) := (others => (others => '0'));
    signal regs_addresses       : t_std32_array(REG_GBT_NUM_REGS - 1 downto 0) := (others => (others => '0'));
    signal regs_defaults        : t_std32_array(REG_GBT_NUM_REGS - 1 downto 0) := (others => (others => '0'));
    signal regs_read_pulse_arr  : std_logic_vector(REG_GBT_NUM_REGS - 1 downto 0) := (others => '0');
    signal regs_write_pulse_arr : std_logic_vector(REG_GBT_NUM_REGS - 1 downto 0) := (others => '0');
    signal regs_read_ready_arr  : std_logic_vector(REG_GBT_NUM_REGS - 1 downto 0) := (others => '1');
    signal regs_write_done_arr  : std_logic_vector(REG_GBT_NUM_REGS - 1 downto 0) := (others => '1');
    signal regs_writable_arr    : std_logic_vector(REG_GBT_NUM_REGS - 1 downto 0) := (others => '0');
    -- Connect counter signal declarations
    signal cnt_ipb_response : std_logic_vector (23 downto 0) := (others => '0');
    signal cnt_ipb_request : std_logic_vector (23 downto 0) := (others => '0');
    signal cnt_link_err : std_logic_vector (23 downto 0) := (others => '0');
  ------ Register signals end ----------------------------------------------

begin

  -- wishbone master

  ipb_mosi_o <= ipb_mosi;
  ipb_miso   <= ipb_miso_i;

  process (clocks.clk40)
  begin
    if (rising_edge(clocks.clk40)) then
      cnt_reset <= (reset_i or resync_gbt or resync_force);
    end if;
  end process;

  process (clocks.clk40)
  begin
    if (rising_edge(clocks.clk40)) then
      ttc_o.l1a    <= l1a_force or l1a_gbt;
      ttc_o.bc0    <= bc0_force or bc0_gbt;
      ttc_o.resync <= resync_force or resync_gbt;
    end if;
  end process;

  --------------------------------------------------------------------------------------------------------------------
  -- GBT Serdes
  --------------------------------------------------------------------------------------------------------------------

  -- at 320 MHz performs ser-des on incoming
  gbt_serdes : entity work.gbt_serdes
    port map(
      -- clocks and reset
      rst_i => reset_i,
      clk_1x    => clocks.clk40,  -- 40 MHz phase shiftable frame clock from GBT
      clk_4x    => clocks.clk160_0,        --
      clk_4x_90 => clocks.clk160_90,       --

      -- serial data
      elink_o_p => elink_o_p,           -- output e-links
      elink_o_n => elink_o_n,           -- output e-links

      elink_i_p => elink_i_p,           -- input e-links
      elink_i_n => elink_i_n,           -- input e-links

      gbt_link_err_i => gbt_link_error,
      gbt_link_rdy_i => gbt_link_ready,

      -- parallel data
      data_o => gbt_rx_data,            -- Parallel data out
      data_i => gbt_tx_data             -- Parallel data in
      );

  --------------------------------------------------------------------------------------------------------------------
  -- GBT Link
  --------------------------------------------------------------------------------------------------------------------

  gbt_link : entity work.gbt_link_tmr
    generic map (g_ENABLE_TMR => EN_TMR_GBT_LINK)
    port map(
      -- clock and reset
      clock => clocks.clk40,                 -- 40 MHz ttc fabric clock
      reset_i => reset_i,

      -- parallel data
      data_i => gbt_rx_data,
      data_o => gbt_tx_data,

      -- wishbone master
      ipb_mosi_o => ipb_mosi,
      ipb_miso_i => ipb_miso,

      -- decoded TTC
      resync_o => resync_gbt,
      l1a_o    => l1a_gbt,
      bc0_o    => bc0_gbt,

      -- outputs
      unstable_o => gbt_link_unstable,
      ready_o    => gbt_link_ready,
      error_o    => gbt_link_error

      );

  gbt_link_err_ready <= gbt_link_ready and gbt_link_error;

  gbt_link_ready_o <= gbt_link_ready;
  gbt_link_error_o <= gbt_link_error;

  --===============================================================================================
  -- (this section is generated by <optohybrid_top>/tools/generate_registers.py -- do not edit)
  --==== Registers begin ==========================================================================

    -- IPbus slave instanciation
    ipbus_slave_inst : entity work.ipbus_slave_tmr
        generic map(
           g_ENABLE_TMR           => EN_TMR_IPB_SLAVE_GBT,
           g_NUM_REGS             => REG_GBT_NUM_REGS,
           g_ADDR_HIGH_BIT        => REG_GBT_ADDRESS_MSB,
           g_ADDR_LOW_BIT         => REG_GBT_ADDRESS_LSB,
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
    regs_addresses(0)(REG_GBT_ADDRESS_MSB downto REG_GBT_ADDRESS_LSB) <= x"0";
    regs_addresses(1)(REG_GBT_ADDRESS_MSB downto REG_GBT_ADDRESS_LSB) <= x"1";
    regs_addresses(2)(REG_GBT_ADDRESS_MSB downto REG_GBT_ADDRESS_LSB) <= x"4";
    regs_addresses(3)(REG_GBT_ADDRESS_MSB downto REG_GBT_ADDRESS_LSB) <= x"5";
    regs_addresses(4)(REG_GBT_ADDRESS_MSB downto REG_GBT_ADDRESS_LSB) <= x"6";
    regs_addresses(5)(REG_GBT_ADDRESS_MSB downto REG_GBT_ADDRESS_LSB) <= x"7";

    -- Connect read signals
    regs_read_arr(0)(REG_GBT_TX_CNT_RESPONSE_SENT_MSB downto REG_GBT_TX_CNT_RESPONSE_SENT_LSB) <= cnt_ipb_response;
    regs_read_arr(1)(REG_GBT_TX_TX_READY_BIT) <= gbt_txready_i;
    regs_read_arr(2)(REG_GBT_RX_RX_READY_BIT) <= gbt_rxready_i;
    regs_read_arr(2)(REG_GBT_RX_RX_VALID_BIT) <= gbt_rxvalid_i;
    regs_read_arr(2)(REG_GBT_RX_CNT_REQUEST_RECEIVED_MSB downto REG_GBT_RX_CNT_REQUEST_RECEIVED_LSB) <= cnt_ipb_request;
    regs_read_arr(3)(REG_GBT_RX_CNT_LINK_ERR_MSB downto REG_GBT_RX_CNT_LINK_ERR_LSB) <= cnt_link_err;

    -- Connect write signals

    -- Connect write pulse signals
    l1a_force <= regs_write_pulse_arr(3);
    bc0_force <= regs_write_pulse_arr(4);
    resync_force <= regs_write_pulse_arr(5);

    -- Connect write done signals

    -- Connect read pulse signals

    -- Connect counter instances

    COUNTER_GBT_TX_CNT_RESPONSE_SENT : entity work.counter_snap
    generic map (
        g_COUNTER_WIDTH  => 24
    )
    port map (
        ref_clk_i => clocks.clk40,
        reset_i   => cnt_reset,
        en_i      => ipb_miso.ipb_ack,
        snap_i    => cnt_snap,
        count_o   => cnt_ipb_response
    );


    COUNTER_GBT_RX_CNT_REQUEST_RECEIVED : entity work.counter_snap
    generic map (
        g_COUNTER_WIDTH  => 24
    )
    port map (
        ref_clk_i => clocks.clk40,
        reset_i   => cnt_reset,
        en_i      => ipb_mosi.ipb_strobe,
        snap_i    => cnt_snap,
        count_o   => cnt_ipb_request
    );


    COUNTER_GBT_RX_CNT_LINK_ERR : entity work.counter_snap
    generic map (
        g_COUNTER_WIDTH  => 24
    )
    port map (
        ref_clk_i => clocks.clk40,
        reset_i   => cnt_reset,
        en_i      => gbt_link_err_ready,
        snap_i    => cnt_snap,
        count_o   => cnt_link_err
    );


    -- Connect rate instances

    -- Connect read ready signals

    -- Defaults

    -- Define writable regs

--==== Registers end ============================================================================
end Behavioral;
