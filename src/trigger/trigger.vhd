----------------------------------------------------------------------------------
-- CMS Muon Endcap
-- GEM Collaboration
-- Optohybrid v3 Firmware -- Trigger
-- A. Peck
----------------------------------------------------------------------------------
-- Description:
--   This module holds all the required functionality for the trigger S-bit alignment
--   and cluster building
----------------------------------------------------------------------------------
-- 2017/07/24 -- Initial
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_misc.all;


library work;
use work.types_pkg.all;
use work.ipbus_pkg.all;
use work.param_pkg.all;
use work.trig_pkg.all;
use work.registers.all;

entity trigger is
port(

    -- ipbus wishbone

    ipb_mosi_i        : in  ipb_wbus;
    ipb_miso_o        : out ipb_rbus;

    -- links
    mgt_clk_p         : in std_logic_vector(1 downto 0); -- 160 MHz Reference Clock
    mgt_clk_n         : in std_logic_vector(1 downto 0); -- 160 MHz Reference Clock

    logic_mmcm_lock_i  : in std_logic;
    logic_mmcm_reset_o : out std_logic;

    clk_40            : in std_logic;
    clk_160           : in std_logic;

    clk_40_sbit       : in std_logic;
    clk_160_sbit      : in std_logic;
    clk_160_90_sbit   : in std_logic;
    clk_200_sbit      : in std_logic;

    trigger_reset_i : in std_logic;
    core_reset_i    : in std_logic;
    ttc_resync      : in std_logic;

    mgt_tx_p          : out std_logic_vector(3 downto 0);
    mgt_tx_n          : out std_logic_vector(3 downto 0);

    mgts_ready        : out std_logic;
    pll_lock_o        : out std_logic;
    txfsm_done_o      : out std_logic;

    -- ttc

    trig_stop_i       : in std_logic;
    bxn_counter_i     : in std_logic_vector(11 downto 0);
    ttc_bx0_i         : in std_logic;
    ttc_l1a_i         : in std_logic;

    -- cluster packer

    cluster_count_o   : out std_logic_vector (10 downto 0);
    overflow_o        : out std_logic;

    active_vfats_o    : out std_logic_vector (MXVFATS-1 downto 0);

    -- sbits
    vfat_sot_p        : in std_logic_vector (MXVFATS-1 downto 0);
    vfat_sot_n        : in std_logic_vector (MXVFATS-1 downto 0);

    vfat_sbits_p      : in std_logic_vector ((MXVFATS*8)-1 downto 0);
    vfat_sbits_n      : in std_logic_vector ((MXVFATS*8)-1 downto 0);

    -- sbits

    master_slave_p    : inout  std_logic_vector (11 downto 0);
    master_slave_n    : inout  std_logic_vector (11 downto 0);

    cnt_snap          : in std_logic

);
end trigger;

architecture Behavioral of trigger is


    signal cluster0 : std_logic_vector (13 downto 0);
    signal cluster1 : std_logic_vector (13 downto 0);
    signal cluster2 : std_logic_vector (13 downto 0);
    signal cluster3 : std_logic_vector (13 downto 0);
    signal cluster4 : std_logic_vector (13 downto 0);
    signal cluster5 : std_logic_vector (13 downto 0);
    signal cluster6 : std_logic_vector (13 downto 0);
    signal cluster7 : std_logic_vector (13 downto 0);

    signal frozen_cluster_0 : std_logic_vector (13 downto 0);
    signal frozen_cluster_1 : std_logic_vector (13 downto 0);
    signal frozen_cluster_2 : std_logic_vector (13 downto 0);
    signal frozen_cluster_3 : std_logic_vector (13 downto 0);
    signal frozen_cluster_4 : std_logic_vector (13 downto 0);
    signal frozen_cluster_5 : std_logic_vector (13 downto 0);
    signal frozen_cluster_6 : std_logic_vector (13 downto 0);
    signal frozen_cluster_7 : std_logic_vector (13 downto 0);

    signal sbitmon_l1a_delay : std_logic_vector (31 downto 0);

    signal sbit_overflow     : std_logic;
    signal sbit_clusters     : sbit_cluster_array_t (7  downto 0);
    signal valid_clusters_or : std_logic;
    signal valid_clusters    : std_logic_vector (7 downto 0);

    signal cluster_count   : std_logic_vector (10 downto 0);

    signal active_vfats : std_logic_vector (MXVFATS-1 downto 0);

    signal vfat_mask : std_logic_vector (MXVFATS-1 downto 0);
    signal trig_deadtime : std_logic_vector (3 downto 0);

    signal sbits_comparator_over_threshold : std_logic_vector (MXVFATS-1 downto 0);

    signal sot_invert : std_logic_vector (MXVFATS-1 downto 0);     -- 24 or 12
    signal  tu_invert : std_logic_vector ((MXVFATS*8)-1 downto 0); -- 192 or 96
    signal  tu_mask   : std_logic_vector ((MXVFATS*8)-1 downto 0); -- 192 or 96

    signal aligned_count_to_ready : std_logic_vector (11 downto 0);

    signal tx_prbs_mode : std_logic_vector (2 downto 0);

    signal pll_reset        : std_logic;
    signal mgt_reset        : std_logic_vector(3 downto 0);
    signal gtxtest_start    : std_logic;
    signal txreset          : std_logic;
    signal mgt_realign      : std_logic;
    signal txpowerdown      : std_logic;
    signal txpowerdown_mode : std_logic_vector (1 downto 0);
    signal txpllpowerdown   : std_logic;

    signal pll_lock    : std_logic;
    signal txfsm_done  : std_logic;

    signal trigger_reset     : std_logic;
    signal reset_monitor     : std_logic;
    signal ipb_reset : std_logic;

    attribute EQUIVALENT_REGISTER_REMOVAL : string;
    attribute EQUIVALENT_REGISTER_REMOVAL of trigger_reset : signal is "NO";
    attribute EQUIVALENT_REGISTER_REMOVAL of ipb_reset : signal is "NO";

    signal sot_is_aligned       : std_logic_vector (MXVFATS-1 downto 0);
    signal sot_unstable         : std_logic_vector (MXVFATS-1 downto 0);
    signal sot_invalid_bitskip  : std_logic_vector (MXVFATS-1 downto 0);

    signal sot_tap_delay       : t_std5_array (MXVFATS-1 downto 0);
    signal trig_tap_delay      : t_std5_array ((MXVFATS*8)-1 downto 0);

    signal sbits_mux_sel        : std_logic_vector  (4 downto 0);
    signal sbits_mux            : std_logic_vector (63 downto 0);

    signal hitmap_reset     : std_logic;
    signal hitmap_acquire   : std_logic;
    signal hitmap_sbits     : sbits_array_t(MXVFATS-1  downto 0);

    -- control signals from gbt (verb, object)
    signal reset_counters       : std_logic;
    signal sbit_cnt_persist     : std_logic;
    signal sbit_cnt_time_max    : std_logic_vector (31 downto 0);

    signal sbit_cnt_snap        : std_logic;
    signal sbit_timer_snap      : std_logic;
    signal sbit_timer_reset     : std_logic;

    signal sbit_time_counter    : unsigned (31 downto 0);

    signal reset_links          : std_logic;

    signal cnt_pulse            : std_logic;

    -- reset signal (ORed with global reset)
    signal cnt_reset            : std_logic;
    signal cnt_reset_strobed    : std_logic;
    signal tx_link_reset        : std_logic;
    signal force_mgts_not_ready : std_logic;
    signal tx_reset_done        : std_logic;
    signal tx_pll_locked        : std_logic;

    COMPONENT   gem_data_out
    GENERIC (
        FPGA_TYPE_IS_VIRTEX6 : integer := 0;
        FPGA_TYPE_IS_ARTIX7  : integer := 1
    );
    PORT (
        trg_tx_n : OUT std_logic_vector (3 downto 0);
        trg_tx_p : OUT std_logic_vector (3 downto 0);

        refclk_n: IN std_logic_vector (1 downto 0);
        refclk_p: IN std_logic_vector (1 downto 0);

        tx_prbs_mode : IN std_logic_vector (2 downto 0);

        gem_data           : IN std_logic_vector (111 downto 0); -- 56 bit gem data
        overflow_i         : IN std_logic;                       -- 1 bit gem has more than 8 clusters
        bxn_counter_i      : IN std_logic_vector (11 downto 0);  -- 12 bit bxn counter
        bc0_i              : IN std_logic;                       -- 1  bit bx0 flag
        resync_i           : IN std_logic;                       -- 1  bit bx0 flag

        force_not_ready    : IN std_logic;
        pll_reset_i        : IN std_logic;
        mgt_reset_i        : IN std_logic_vector(3 downto 0);
        gtxtest_start_i    : IN std_logic;
        txreset_i          : IN std_logic;
        mgt_realign_i      : IN std_logic;
        txpowerdown_i      : IN std_logic;
        txpowerdown_mode_i : IN std_logic_vector (1 downto 0);
        txpllpowerdown_i   : IN std_logic;

        clock_40  : IN std_logic;
        clock_160 : IN std_logic;

        ready_o      : OUT std_logic;
        pll_lock_o   : OUT std_logic;
        txfsm_done_o : OUT std_logic;

        reset_i : IN std_logic
    );
    END COMPONENT;

    ------ Register signals begin (this section is generated by <optohybrid_top>/tools/generate_registers.py -- do not edit)
    signal regs_read_arr        : t_std32_array(REG_TRIG_NUM_REGS - 1 downto 0) := (others => (others => '0'));
    signal regs_write_arr       : t_std32_array(REG_TRIG_NUM_REGS - 1 downto 0) := (others => (others => '0'));
    signal regs_addresses       : t_std32_array(REG_TRIG_NUM_REGS - 1 downto 0) := (others => (others => '0'));
    signal regs_defaults        : t_std32_array(REG_TRIG_NUM_REGS - 1 downto 0) := (others => (others => '0'));
    signal regs_read_pulse_arr  : std_logic_vector(REG_TRIG_NUM_REGS - 1 downto 0) := (others => '0');
    signal regs_write_pulse_arr : std_logic_vector(REG_TRIG_NUM_REGS - 1 downto 0) := (others => '0');
    signal regs_read_ready_arr  : std_logic_vector(REG_TRIG_NUM_REGS - 1 downto 0) := (others => '1');
    signal regs_write_done_arr  : std_logic_vector(REG_TRIG_NUM_REGS - 1 downto 0) := (others => '1');
    signal regs_writable_arr    : std_logic_vector(REG_TRIG_NUM_REGS - 1 downto 0) := (others => '0');
    -- Connect counter signal declarations
    signal cnt_sbit_overflow : std_logic_vector (15 downto 0) := (others => '0');
    signal cnt_vfat0 : std_logic_vector (31 downto 0) := (others => '0');
    signal cnt_vfat1 : std_logic_vector (31 downto 0) := (others => '0');
    signal cnt_vfat2 : std_logic_vector (31 downto 0) := (others => '0');
    signal cnt_vfat3 : std_logic_vector (31 downto 0) := (others => '0');
    signal cnt_vfat4 : std_logic_vector (31 downto 0) := (others => '0');
    signal cnt_vfat5 : std_logic_vector (31 downto 0) := (others => '0');
    signal cnt_vfat6 : std_logic_vector (31 downto 0) := (others => '0');
    signal cnt_vfat7 : std_logic_vector (31 downto 0) := (others => '0');
    signal cnt_vfat8 : std_logic_vector (31 downto 0) := (others => '0');
    signal cnt_vfat9 : std_logic_vector (31 downto 0) := (others => '0');
    signal cnt_vfat10 : std_logic_vector (31 downto 0) := (others => '0');
    signal cnt_vfat11 : std_logic_vector (31 downto 0) := (others => '0');
    signal cnt_clusters : std_logic_vector (31 downto 0) := (others => '0');
    signal cnt_over_threshold0 : std_logic_vector (15 downto 0) := (others => '0');
    signal cnt_over_threshold1 : std_logic_vector (15 downto 0) := (others => '0');
    signal cnt_over_threshold2 : std_logic_vector (15 downto 0) := (others => '0');
    signal cnt_over_threshold3 : std_logic_vector (15 downto 0) := (others => '0');
    signal cnt_over_threshold4 : std_logic_vector (15 downto 0) := (others => '0');
    signal cnt_over_threshold5 : std_logic_vector (15 downto 0) := (others => '0');
    signal cnt_over_threshold6 : std_logic_vector (15 downto 0) := (others => '0');
    signal cnt_over_threshold7 : std_logic_vector (15 downto 0) := (others => '0');
    signal cnt_over_threshold8 : std_logic_vector (15 downto 0) := (others => '0');
    signal cnt_over_threshold9 : std_logic_vector (15 downto 0) := (others => '0');
    signal cnt_over_threshold10 : std_logic_vector (15 downto 0) := (others => '0');
    signal cnt_over_threshold11 : std_logic_vector (15 downto 0) := (others => '0');
    ------ Register signals end ----------------------------------------------

begin

    --------------------------------------------------------------------------------------------------------------------
    -- Resets
    --------------------------------------------------------------------------------------------------------------------

    process (clk_40) begin
        if (rising_edge(clk_40)) then
            trigger_reset <= trigger_reset_i;
            ipb_reset <= core_reset_i;
        end if;
    end process;

    process (clk_40) begin
        if (rising_edge(clk_40)) then
            cnt_reset         <= trigger_reset or ttc_resync or reset_counters;
            cnt_reset_strobed <= trigger_reset or ttc_resync or reset_counters or (sbit_timer_reset and not sbit_cnt_persist);
        end if;
    end process;

    process (clk_40) begin
        if (rising_edge(clk_40)) then
            tx_link_reset <= reset_links;
        end if;
    end process;

    --------------------------------------------------------------------------------------------------------------------
    -- Outputs
    --------------------------------------------------------------------------------------------------------------------

    overflow_o <= sbit_overflow;
    active_vfats_o <= active_vfats;
    cluster_count_o <= cluster_count;

    --------------------------------------------------------------------------------------------------------------------
    -- Counter Snap
    --------------------------------------------------------------------------------------------------------------------

    process (clk_40_sbit) begin
        if (rising_edge(clk_40_sbit)) then

            sbit_cnt_snap <= (sbit_timer_snap or sbit_cnt_persist);

            if (trigger_reset = '1' or reset_counters = '1') then
                sbit_time_counter <= (others => '0');
                sbit_timer_reset <= '1';
                sbit_timer_snap  <= '1';
            else
                if (sbit_time_counter = unsigned(sbit_cnt_time_max)) then
                    sbit_time_counter <= (others => '0');
                    sbit_timer_reset  <= '1';
                    sbit_timer_snap   <= '1';
                else
                    sbit_time_counter <= sbit_time_counter + 1;
                    sbit_timer_reset  <= '0';
                    sbit_timer_snap   <= '0';
                end if;
            end if;

        end if;
    end process;

    --------------------------------------------------------------------------------------------------------------------
    -- S-bit overflow comparator
    --------------------------------------------------------------------------------------------------------------------

    process (clk_40_sbit) begin
        if (rising_edge(clk_40_sbit)) then

            if (unsigned(cluster_count) > 0)  then sbits_comparator_over_threshold(0) <= '1';
            else sbits_comparator_over_threshold(0) <= '0';
            end if;
        end if;
    end process;

    clusters_over_threshold_loop : for I in 1 to (MXVFATS-1) generate
    begin

    process (clk_40_sbit) begin
        if (rising_edge(clk_40_sbit)) then
                if (unsigned(cluster_count) > 63*I)  then sbits_comparator_over_threshold(I) <= '1';
                else sbits_comparator_over_threshold(I) <= '0';
                end if;
        end if;
    end process;

    end generate;

    --------------------------------------------------------------------------------------------------------------------
    -- S-bit deserilization and cluster building
    --------------------------------------------------------------------------------------------------------------------

    sbits : entity work.sbits
    port map (

        trig_stop_i             => trig_stop_i,

        clk40_i                 => clk_40_sbit,
        clk160_i                => clk_160_sbit,
        clk160_90_i             => clk_160_90_sbit,
        clk200_i                => clk_200_sbit,

        sbits_mux_sel_i         => sbits_mux_sel,
        sbits_mux_o             => sbits_mux,


        aligned_count_to_ready   => aligned_count_to_ready,

        reset_i                 => trigger_reset,

        sbits_p                  => vfat_sbits_p,
        sbits_n                  => vfat_sbits_n,

        start_of_frame_p         => vfat_sot_p,
        start_of_frame_n         => vfat_sot_n,

        vfat_mask_i  => vfat_mask (MXVFATS -1 downto 0),
        sot_invert_i => sot_invert (MXVFATS-1 downto 0),
        tu_invert_i  => tu_invert,
        tu_mask_i    => tu_mask,

        active_vfats_o          => active_vfats,

        vfat_sbit_clusters_o    => sbit_clusters,
        trigger_deadtime_i      => trig_deadtime,
        cluster_count_o         => cluster_count,
        overflow_o              => sbit_overflow,

        sot_tap_delay           => sot_tap_delay,
        trig_tap_delay          => trig_tap_delay,

        sot_is_aligned_o        => sot_is_aligned,
        sot_unstable_o          => sot_unstable,
        sot_invalid_bitskip_o   => sot_invalid_bitskip,

        hitmap_reset_i    => hitmap_reset,
        hitmap_acquire_i  => hitmap_acquire,
        hitmap_sbits_o    => hitmap_sbits

    );

    --------------------------------------------------------------------------------------------------------------------
    -- Sbit Monitor
    --------------------------------------------------------------------------------------------------------------------

    sbit_monitor_inst : entity work.sbit_monitor
    generic map (
        g_NUM_OF_OHs => 1
    )
    port map (
        reset_i          => (trigger_reset or reset_monitor),
        ttc_clk_i        => clk_40_sbit,
        l1a_i            => ttc_l1a_i,
        sbit_cluster_0   => sbit_clusters(0),
        sbit_cluster_1   => sbit_clusters(1),
        sbit_cluster_2   => sbit_clusters(2),
        sbit_cluster_3   => sbit_clusters(3),
        sbit_cluster_4   => sbit_clusters(4),
        sbit_cluster_5   => sbit_clusters(5),
        sbit_cluster_6   => sbit_clusters(6),
        sbit_cluster_7   => sbit_clusters(7),
        sbit_cluster_8   => ("000" & "111" & x"FA"),
        sbit_cluster_9   => ("000" & "111" & x"FA"),
        frozen_cluster_0 => frozen_cluster_0,
        frozen_cluster_1 => frozen_cluster_1,
        frozen_cluster_2 => frozen_cluster_2,
        frozen_cluster_3 => frozen_cluster_3,
        frozen_cluster_4 => frozen_cluster_4,
        frozen_cluster_5 => frozen_cluster_5,
        frozen_cluster_6 => frozen_cluster_6,
        frozen_cluster_7 => frozen_cluster_7,
        frozen_cluster_8 => open,
        frozen_cluster_9 => open,
        l1a_delay_o      => sbitmon_l1a_delay
    );


    --------------------------------------------------------------------------------------------------------------------
    -- Fixed latency trigger links
    --------------------------------------------------------------------------------------------------------------------

    valid_clusters(0) <= '0' when sbit_clusters(0)(10 downto 9) = "11" else '1';
    valid_clusters(1) <= '0' when sbit_clusters(1)(10 downto 9) = "11" else '1';
    valid_clusters(2) <= '0' when sbit_clusters(2)(10 downto 9) = "11" else '1';
    valid_clusters(3) <= '0' when sbit_clusters(3)(10 downto 9) = "11" else '1';
    valid_clusters(4) <= '0' when sbit_clusters(4)(10 downto 9) = "11" else '1';
    valid_clusters(5) <= '0' when sbit_clusters(5)(10 downto 9) = "11" else '1';
    valid_clusters(6) <= '0' when sbit_clusters(6)(10 downto 9) = "11" else '1';
    valid_clusters(7) <= '0' when sbit_clusters(7)(10 downto 9) = "11" else '1';

    valid_clusters_or <= or_reduce (valid_clusters(7 downto 0));

    gem_data_out_inst : gem_data_out
    generic map (
        FPGA_TYPE_IS_VIRTEX6  => FPGA_TYPE_IS_VIRTEX6,
        FPGA_TYPE_IS_ARTIX7   => FPGA_TYPE_IS_ARTIX7
    )
    port map (

        refclk_p  => mgt_clk_p, -- 160 MHz Reference Clock Positive
        refclk_n  => mgt_clk_n, -- 160 MHz Reference Clock Negative

        clock_40  => clk_40,  -- 40 MHz  Logic Clock
        clock_160 => clk_160, -- 160 MHz  Logic Clock

        bxn_counter_i => bxn_counter_i,
        bc0_i         => ttc_bx0_i,
        resync_i      => ttc_resync,

        reset_i       => tx_link_reset ,

        force_not_ready => force_mgts_not_ready,

        ready_o      => mgts_ready,
        pll_lock_o   => pll_lock,
        txfsm_done_o => txfsm_done,
        tx_prbs_mode => tx_prbs_mode,


        pll_reset_i        => pll_reset,
        mgt_reset_i        => mgt_reset,
        gtxtest_start_i    => gtxtest_start,
        txreset_i          => txreset,
        mgt_realign_i      => mgt_realign,
        txpowerdown_i      => txpowerdown,
        txpowerdown_mode_i => txpowerdown_mode,
        txpllpowerdown_i   => txpllpowerdown,

        trg_tx_p   => mgt_tx_p (3 downto 0),
        trg_tx_n   => mgt_tx_n (3 downto 0),

        gem_data => sbit_clusters(7) & sbit_clusters(6) & sbit_clusters(5) & sbit_clusters(4) & sbit_clusters(3) & sbit_clusters(2) & sbit_clusters(1) & sbit_clusters(0),

        overflow_i => sbit_overflow
    );

    pll_lock_o <= pll_lock;
    txfsm_done_o <= txfsm_done;

    tx_pll_locked <= pll_lock;
    tx_reset_done <= txfsm_done;

    --===============================================================================================
    -- (this section is generated by <optohybrid_top>/tools/generate_registers.py -- do not edit)
    --==== Registers begin ==========================================================================

    -- IPbus slave instanciation
    ipbus_slave_inst : entity work.ipbus_slave
        generic map(
           g_NUM_REGS             => REG_TRIG_NUM_REGS,
           g_ADDR_HIGH_BIT        => REG_TRIG_ADDRESS_MSB,
           g_ADDR_LOW_BIT         => REG_TRIG_ADDRESS_LSB,
           g_USE_INDIVIDUAL_ADDRS => true
       )
       port map(
           ipb_reset_i            => ipb_reset,
           ipb_clk_i              => clk_40,
           ipb_mosi_i             => ipb_mosi_i,
           ipb_miso_o             => ipb_miso_o,
           usr_clk_i              => clk_40,
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
    regs_addresses(0)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"00";
    regs_addresses(1)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"01";
    regs_addresses(2)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"02";
    regs_addresses(3)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"03";
    regs_addresses(4)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"04";
    regs_addresses(5)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"05";
    regs_addresses(6)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"06";
    regs_addresses(7)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"07";
    regs_addresses(8)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"08";
    regs_addresses(9)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"0e";
    regs_addresses(10)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"0f";
    regs_addresses(11)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"10";
    regs_addresses(12)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"11";
    regs_addresses(13)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"12";
    regs_addresses(14)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"13";
    regs_addresses(15)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"17";
    regs_addresses(16)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"18";
    regs_addresses(17)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"19";
    regs_addresses(18)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"1a";
    regs_addresses(19)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"1b";
    regs_addresses(20)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"1c";
    regs_addresses(21)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"1d";
    regs_addresses(22)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"1e";
    regs_addresses(23)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"1f";
    regs_addresses(24)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"20";
    regs_addresses(25)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"21";
    regs_addresses(26)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"22";
    regs_addresses(27)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"2f";
    regs_addresses(28)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"30";
    regs_addresses(29)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"31";
    regs_addresses(30)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"32";
    regs_addresses(31)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"36";
    regs_addresses(32)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"37";
    regs_addresses(33)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"38";
    regs_addresses(34)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"39";
    regs_addresses(35)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"3a";
    regs_addresses(36)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"3b";
    regs_addresses(37)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"3c";
    regs_addresses(38)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"3d";
    regs_addresses(39)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"3e";
    regs_addresses(40)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"3f";
    regs_addresses(41)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"40";
    regs_addresses(42)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"41";
    regs_addresses(43)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"53";
    regs_addresses(44)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"54";
    regs_addresses(45)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"55";
    regs_addresses(46)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"56";
    regs_addresses(47)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"57";
    regs_addresses(48)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"58";
    regs_addresses(49)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"59";
    regs_addresses(50)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"5a";
    regs_addresses(51)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"5b";
    regs_addresses(52)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"5c";
    regs_addresses(53)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"5d";
    regs_addresses(54)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"5e";
    regs_addresses(55)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"5f";
    regs_addresses(56)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"60";
    regs_addresses(57)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"61";
    regs_addresses(58)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"62";
    regs_addresses(59)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"63";
    regs_addresses(60)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"64";
    regs_addresses(61)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"80";
    regs_addresses(62)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"81";
    regs_addresses(63)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"90";
    regs_addresses(64)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"91";
    regs_addresses(65)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"92";
    regs_addresses(66)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"93";
    regs_addresses(67)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"94";
    regs_addresses(68)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"95";
    regs_addresses(69)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"96";
    regs_addresses(70)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"97";
    regs_addresses(71)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"98";
    regs_addresses(72)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"a0";
    regs_addresses(73)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"b0";
    regs_addresses(74)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"b1";
    regs_addresses(75)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"b2";
    regs_addresses(76)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"b3";
    regs_addresses(77)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"b4";
    regs_addresses(78)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"b5";
    regs_addresses(79)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"b6";
    regs_addresses(80)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"b7";
    regs_addresses(81)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"b8";
    regs_addresses(82)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"b9";
    regs_addresses(83)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"ba";
    regs_addresses(84)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"bb";
    regs_addresses(85)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"bc";
    regs_addresses(86)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"bd";
    regs_addresses(87)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"be";
    regs_addresses(88)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"bf";
    regs_addresses(89)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"c0";
    regs_addresses(90)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"c1";
    regs_addresses(91)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"c2";
    regs_addresses(92)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"c3";
    regs_addresses(93)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"c4";
    regs_addresses(94)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"c5";
    regs_addresses(95)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"c6";
    regs_addresses(96)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"c7";
    regs_addresses(97)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"c8";
    regs_addresses(98)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"c9";
    regs_addresses(99)(REG_TRIG_ADDRESS_MSB downto REG_TRIG_ADDRESS_LSB) <= x"e2";

    -- Connect read signals
    regs_read_arr(0)(REG_TRIG_CTRL_VFAT_MASK_MSB downto REG_TRIG_CTRL_VFAT_MASK_LSB) <= vfat_mask;
    regs_read_arr(0)(REG_TRIG_CTRL_SBIT_DEADTIME_MSB downto REG_TRIG_CTRL_SBIT_DEADTIME_LSB) <= trig_deadtime;
    regs_read_arr(1)(REG_TRIG_CTRL_ACTIVE_VFATS_MSB downto REG_TRIG_CTRL_ACTIVE_VFATS_LSB) <= active_vfats;
    regs_read_arr(2)(REG_TRIG_CTRL_CNT_OVERFLOW_MSB downto REG_TRIG_CTRL_CNT_OVERFLOW_LSB) <= cnt_sbit_overflow;
    regs_read_arr(2)(REG_TRIG_CTRL_ALIGNED_COUNT_TO_READY_MSB downto REG_TRIG_CTRL_ALIGNED_COUNT_TO_READY_LSB) <= aligned_count_to_ready;
    regs_read_arr(3)(REG_TRIG_CTRL_SBIT_SOT_READY_MSB downto REG_TRIG_CTRL_SBIT_SOT_READY_LSB) <= sot_is_aligned;
    regs_read_arr(4)(REG_TRIG_CTRL_SBIT_SOT_UNSTABLE_MSB downto REG_TRIG_CTRL_SBIT_SOT_UNSTABLE_LSB) <= sot_unstable;
    regs_read_arr(5)(REG_TRIG_CTRL_INVERT_SOT_INVERT_MSB downto REG_TRIG_CTRL_INVERT_SOT_INVERT_LSB) <= sot_invert;
    regs_read_arr(6)(REG_TRIG_CTRL_INVERT_VFAT0_TU_INVERT_MSB downto REG_TRIG_CTRL_INVERT_VFAT0_TU_INVERT_LSB) <= TU_INVERT (7 downto 0);
    regs_read_arr(6)(REG_TRIG_CTRL_INVERT_VFAT1_TU_INVERT_MSB downto REG_TRIG_CTRL_INVERT_VFAT1_TU_INVERT_LSB) <= TU_INVERT (15 downto 8);
    regs_read_arr(6)(REG_TRIG_CTRL_INVERT_VFAT2_TU_INVERT_MSB downto REG_TRIG_CTRL_INVERT_VFAT2_TU_INVERT_LSB) <= TU_INVERT (23 downto 16);
    regs_read_arr(6)(REG_TRIG_CTRL_INVERT_VFAT3_TU_INVERT_MSB downto REG_TRIG_CTRL_INVERT_VFAT3_TU_INVERT_LSB) <= TU_INVERT (31 downto 24);
    regs_read_arr(7)(REG_TRIG_CTRL_INVERT_VFAT4_TU_INVERT_MSB downto REG_TRIG_CTRL_INVERT_VFAT4_TU_INVERT_LSB) <= TU_INVERT (39 downto 32);
    regs_read_arr(7)(REG_TRIG_CTRL_INVERT_VFAT5_TU_INVERT_MSB downto REG_TRIG_CTRL_INVERT_VFAT5_TU_INVERT_LSB) <= TU_INVERT (47 downto 40);
    regs_read_arr(7)(REG_TRIG_CTRL_INVERT_VFAT6_TU_INVERT_MSB downto REG_TRIG_CTRL_INVERT_VFAT6_TU_INVERT_LSB) <= TU_INVERT (55 downto 48);
    regs_read_arr(7)(REG_TRIG_CTRL_INVERT_VFAT7_TU_INVERT_MSB downto REG_TRIG_CTRL_INVERT_VFAT7_TU_INVERT_LSB) <= TU_INVERT (63 downto 56);
    regs_read_arr(8)(REG_TRIG_CTRL_INVERT_VFAT8_TU_INVERT_MSB downto REG_TRIG_CTRL_INVERT_VFAT8_TU_INVERT_LSB) <= TU_INVERT (71 downto 64);
    regs_read_arr(8)(REG_TRIG_CTRL_INVERT_VFAT9_TU_INVERT_MSB downto REG_TRIG_CTRL_INVERT_VFAT9_TU_INVERT_LSB) <= TU_INVERT (79 downto 72);
    regs_read_arr(8)(REG_TRIG_CTRL_INVERT_VFAT10_TU_INVERT_MSB downto REG_TRIG_CTRL_INVERT_VFAT10_TU_INVERT_LSB) <= TU_INVERT (87 downto 80);
    regs_read_arr(8)(REG_TRIG_CTRL_INVERT_VFAT11_TU_INVERT_MSB downto REG_TRIG_CTRL_INVERT_VFAT11_TU_INVERT_LSB) <= TU_INVERT (95 downto 88);
    regs_read_arr(9)(REG_TRIG_CTRL_SBITS_MUX_SBIT_MUX_SEL_MSB downto REG_TRIG_CTRL_SBITS_MUX_SBIT_MUX_SEL_LSB) <= sbits_mux_sel;
    regs_read_arr(10)(REG_TRIG_CTRL_SBITS_MUX_SBITS_MUX_LSB_MSB downto REG_TRIG_CTRL_SBITS_MUX_SBITS_MUX_LSB_LSB) <= sbits_mux(31 downto 0);
    regs_read_arr(11)(REG_TRIG_CTRL_SBITS_MUX_SBITS_MUX_MSB_MSB downto REG_TRIG_CTRL_SBITS_MUX_SBITS_MUX_MSB_LSB) <= sbits_mux(63 downto 32);
    regs_read_arr(12)(REG_TRIG_CTRL_TU_MASK_VFAT0_TU_MASK_MSB downto REG_TRIG_CTRL_TU_MASK_VFAT0_TU_MASK_LSB) <= TU_MASK (7 downto 0);
    regs_read_arr(12)(REG_TRIG_CTRL_TU_MASK_VFAT1_TU_MASK_MSB downto REG_TRIG_CTRL_TU_MASK_VFAT1_TU_MASK_LSB) <= TU_MASK (15 downto 8);
    regs_read_arr(12)(REG_TRIG_CTRL_TU_MASK_VFAT2_TU_MASK_MSB downto REG_TRIG_CTRL_TU_MASK_VFAT2_TU_MASK_LSB) <= TU_MASK (23 downto 16);
    regs_read_arr(12)(REG_TRIG_CTRL_TU_MASK_VFAT3_TU_MASK_MSB downto REG_TRIG_CTRL_TU_MASK_VFAT3_TU_MASK_LSB) <= TU_MASK (31 downto 24);
    regs_read_arr(13)(REG_TRIG_CTRL_TU_MASK_VFAT4_TU_MASK_MSB downto REG_TRIG_CTRL_TU_MASK_VFAT4_TU_MASK_LSB) <= TU_MASK (39 downto 32);
    regs_read_arr(13)(REG_TRIG_CTRL_TU_MASK_VFAT5_TU_MASK_MSB downto REG_TRIG_CTRL_TU_MASK_VFAT5_TU_MASK_LSB) <= TU_MASK (47 downto 40);
    regs_read_arr(13)(REG_TRIG_CTRL_TU_MASK_VFAT6_TU_MASK_MSB downto REG_TRIG_CTRL_TU_MASK_VFAT6_TU_MASK_LSB) <= TU_MASK (55 downto 48);
    regs_read_arr(13)(REG_TRIG_CTRL_TU_MASK_VFAT7_TU_MASK_MSB downto REG_TRIG_CTRL_TU_MASK_VFAT7_TU_MASK_LSB) <= TU_MASK (63 downto 56);
    regs_read_arr(14)(REG_TRIG_CTRL_TU_MASK_VFAT8_TU_MASK_MSB downto REG_TRIG_CTRL_TU_MASK_VFAT8_TU_MASK_LSB) <= TU_MASK (71 downto 64);
    regs_read_arr(14)(REG_TRIG_CTRL_TU_MASK_VFAT9_TU_MASK_MSB downto REG_TRIG_CTRL_TU_MASK_VFAT9_TU_MASK_LSB) <= TU_MASK (79 downto 72);
    regs_read_arr(14)(REG_TRIG_CTRL_TU_MASK_VFAT10_TU_MASK_MSB downto REG_TRIG_CTRL_TU_MASK_VFAT10_TU_MASK_LSB) <= TU_MASK (87 downto 80);
    regs_read_arr(14)(REG_TRIG_CTRL_TU_MASK_VFAT11_TU_MASK_MSB downto REG_TRIG_CTRL_TU_MASK_VFAT11_TU_MASK_LSB) <= TU_MASK (95 downto 88);
    regs_read_arr(15)(REG_TRIG_CNT_VFAT0_SBITS_MSB downto REG_TRIG_CNT_VFAT0_SBITS_LSB) <= cnt_vfat0;
    regs_read_arr(16)(REG_TRIG_CNT_VFAT1_SBITS_MSB downto REG_TRIG_CNT_VFAT1_SBITS_LSB) <= cnt_vfat1;
    regs_read_arr(17)(REG_TRIG_CNT_VFAT2_SBITS_MSB downto REG_TRIG_CNT_VFAT2_SBITS_LSB) <= cnt_vfat2;
    regs_read_arr(18)(REG_TRIG_CNT_VFAT3_SBITS_MSB downto REG_TRIG_CNT_VFAT3_SBITS_LSB) <= cnt_vfat3;
    regs_read_arr(19)(REG_TRIG_CNT_VFAT4_SBITS_MSB downto REG_TRIG_CNT_VFAT4_SBITS_LSB) <= cnt_vfat4;
    regs_read_arr(20)(REG_TRIG_CNT_VFAT5_SBITS_MSB downto REG_TRIG_CNT_VFAT5_SBITS_LSB) <= cnt_vfat5;
    regs_read_arr(21)(REG_TRIG_CNT_VFAT6_SBITS_MSB downto REG_TRIG_CNT_VFAT6_SBITS_LSB) <= cnt_vfat6;
    regs_read_arr(22)(REG_TRIG_CNT_VFAT7_SBITS_MSB downto REG_TRIG_CNT_VFAT7_SBITS_LSB) <= cnt_vfat7;
    regs_read_arr(23)(REG_TRIG_CNT_VFAT8_SBITS_MSB downto REG_TRIG_CNT_VFAT8_SBITS_LSB) <= cnt_vfat8;
    regs_read_arr(24)(REG_TRIG_CNT_VFAT9_SBITS_MSB downto REG_TRIG_CNT_VFAT9_SBITS_LSB) <= cnt_vfat9;
    regs_read_arr(25)(REG_TRIG_CNT_VFAT10_SBITS_MSB downto REG_TRIG_CNT_VFAT10_SBITS_LSB) <= cnt_vfat10;
    regs_read_arr(26)(REG_TRIG_CNT_VFAT11_SBITS_MSB downto REG_TRIG_CNT_VFAT11_SBITS_LSB) <= cnt_vfat11;
    regs_read_arr(28)(REG_TRIG_CNT_SBIT_CNT_PERSIST_BIT) <= sbit_cnt_persist;
    regs_read_arr(29)(REG_TRIG_CNT_SBIT_CNT_TIME_MAX_MSB downto REG_TRIG_CNT_SBIT_CNT_TIME_MAX_LSB) <= sbit_cnt_time_max;
    regs_read_arr(30)(REG_TRIG_CNT_CLUSTER_COUNT_MSB downto REG_TRIG_CNT_CLUSTER_COUNT_LSB) <= cnt_clusters;
    regs_read_arr(31)(REG_TRIG_CNT_SBITS_OVER_64x0_MSB downto REG_TRIG_CNT_SBITS_OVER_64x0_LSB) <= cnt_over_threshold0;
    regs_read_arr(32)(REG_TRIG_CNT_SBITS_OVER_64x1_MSB downto REG_TRIG_CNT_SBITS_OVER_64x1_LSB) <= cnt_over_threshold1;
    regs_read_arr(33)(REG_TRIG_CNT_SBITS_OVER_64x2_MSB downto REG_TRIG_CNT_SBITS_OVER_64x2_LSB) <= cnt_over_threshold2;
    regs_read_arr(34)(REG_TRIG_CNT_SBITS_OVER_64x3_MSB downto REG_TRIG_CNT_SBITS_OVER_64x3_LSB) <= cnt_over_threshold3;
    regs_read_arr(35)(REG_TRIG_CNT_SBITS_OVER_64x4_MSB downto REG_TRIG_CNT_SBITS_OVER_64x4_LSB) <= cnt_over_threshold4;
    regs_read_arr(36)(REG_TRIG_CNT_SBITS_OVER_64x5_MSB downto REG_TRIG_CNT_SBITS_OVER_64x5_LSB) <= cnt_over_threshold5;
    regs_read_arr(37)(REG_TRIG_CNT_SBITS_OVER_64x6_MSB downto REG_TRIG_CNT_SBITS_OVER_64x6_LSB) <= cnt_over_threshold6;
    regs_read_arr(38)(REG_TRIG_CNT_SBITS_OVER_64x7_MSB downto REG_TRIG_CNT_SBITS_OVER_64x7_LSB) <= cnt_over_threshold7;
    regs_read_arr(39)(REG_TRIG_CNT_SBITS_OVER_64x8_MSB downto REG_TRIG_CNT_SBITS_OVER_64x8_LSB) <= cnt_over_threshold8;
    regs_read_arr(40)(REG_TRIG_CNT_SBITS_OVER_64x9_MSB downto REG_TRIG_CNT_SBITS_OVER_64x9_LSB) <= cnt_over_threshold9;
    regs_read_arr(41)(REG_TRIG_CNT_SBITS_OVER_64x10_MSB downto REG_TRIG_CNT_SBITS_OVER_64x10_LSB) <= cnt_over_threshold10;
    regs_read_arr(42)(REG_TRIG_CNT_SBITS_OVER_64x11_MSB downto REG_TRIG_CNT_SBITS_OVER_64x11_LSB) <= cnt_over_threshold11;
    regs_read_arr(43)(REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT0_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT0_LSB) <= trig_tap_delay(0);
    regs_read_arr(43)(REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT1_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT1_LSB) <= trig_tap_delay(1);
    regs_read_arr(43)(REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT2_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT2_LSB) <= trig_tap_delay(2);
    regs_read_arr(43)(REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT3_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT3_LSB) <= trig_tap_delay(3);
    regs_read_arr(43)(REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT4_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT4_LSB) <= trig_tap_delay(4);
    regs_read_arr(43)(REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT5_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT5_LSB) <= trig_tap_delay(5);
    regs_read_arr(44)(REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT6_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT6_LSB) <= trig_tap_delay(6);
    regs_read_arr(44)(REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT7_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT7_LSB) <= trig_tap_delay(7);
    regs_read_arr(44)(REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT0_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT0_LSB) <= trig_tap_delay(8);
    regs_read_arr(44)(REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT1_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT1_LSB) <= trig_tap_delay(9);
    regs_read_arr(44)(REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT2_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT2_LSB) <= trig_tap_delay(10);
    regs_read_arr(44)(REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT3_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT3_LSB) <= trig_tap_delay(11);
    regs_read_arr(45)(REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT4_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT4_LSB) <= trig_tap_delay(12);
    regs_read_arr(45)(REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT5_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT5_LSB) <= trig_tap_delay(13);
    regs_read_arr(45)(REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT6_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT6_LSB) <= trig_tap_delay(14);
    regs_read_arr(45)(REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT7_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT7_LSB) <= trig_tap_delay(15);
    regs_read_arr(45)(REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT0_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT0_LSB) <= trig_tap_delay(16);
    regs_read_arr(45)(REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT1_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT1_LSB) <= trig_tap_delay(17);
    regs_read_arr(46)(REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT2_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT2_LSB) <= trig_tap_delay(18);
    regs_read_arr(46)(REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT3_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT3_LSB) <= trig_tap_delay(19);
    regs_read_arr(46)(REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT4_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT4_LSB) <= trig_tap_delay(20);
    regs_read_arr(46)(REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT5_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT5_LSB) <= trig_tap_delay(21);
    regs_read_arr(46)(REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT6_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT6_LSB) <= trig_tap_delay(22);
    regs_read_arr(46)(REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT7_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT7_LSB) <= trig_tap_delay(23);
    regs_read_arr(47)(REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT0_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT0_LSB) <= trig_tap_delay(24);
    regs_read_arr(47)(REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT1_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT1_LSB) <= trig_tap_delay(25);
    regs_read_arr(47)(REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT2_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT2_LSB) <= trig_tap_delay(26);
    regs_read_arr(47)(REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT3_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT3_LSB) <= trig_tap_delay(27);
    regs_read_arr(47)(REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT4_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT4_LSB) <= trig_tap_delay(28);
    regs_read_arr(47)(REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT5_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT5_LSB) <= trig_tap_delay(29);
    regs_read_arr(48)(REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT6_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT6_LSB) <= trig_tap_delay(30);
    regs_read_arr(48)(REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT7_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT7_LSB) <= trig_tap_delay(31);
    regs_read_arr(48)(REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT0_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT0_LSB) <= trig_tap_delay(32);
    regs_read_arr(48)(REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT1_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT1_LSB) <= trig_tap_delay(33);
    regs_read_arr(48)(REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT2_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT2_LSB) <= trig_tap_delay(34);
    regs_read_arr(48)(REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT3_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT3_LSB) <= trig_tap_delay(35);
    regs_read_arr(49)(REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT4_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT4_LSB) <= trig_tap_delay(36);
    regs_read_arr(49)(REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT5_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT5_LSB) <= trig_tap_delay(37);
    regs_read_arr(49)(REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT6_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT6_LSB) <= trig_tap_delay(38);
    regs_read_arr(49)(REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT7_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT7_LSB) <= trig_tap_delay(39);
    regs_read_arr(49)(REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT0_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT0_LSB) <= trig_tap_delay(40);
    regs_read_arr(49)(REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT1_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT1_LSB) <= trig_tap_delay(41);
    regs_read_arr(50)(REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT2_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT2_LSB) <= trig_tap_delay(42);
    regs_read_arr(50)(REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT3_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT3_LSB) <= trig_tap_delay(43);
    regs_read_arr(50)(REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT4_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT4_LSB) <= trig_tap_delay(44);
    regs_read_arr(50)(REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT5_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT5_LSB) <= trig_tap_delay(45);
    regs_read_arr(50)(REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT6_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT6_LSB) <= trig_tap_delay(46);
    regs_read_arr(50)(REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT7_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT7_LSB) <= trig_tap_delay(47);
    regs_read_arr(51)(REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT0_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT0_LSB) <= trig_tap_delay(48);
    regs_read_arr(51)(REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT1_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT1_LSB) <= trig_tap_delay(49);
    regs_read_arr(51)(REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT2_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT2_LSB) <= trig_tap_delay(50);
    regs_read_arr(51)(REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT3_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT3_LSB) <= trig_tap_delay(51);
    regs_read_arr(51)(REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT4_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT4_LSB) <= trig_tap_delay(52);
    regs_read_arr(51)(REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT5_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT5_LSB) <= trig_tap_delay(53);
    regs_read_arr(52)(REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT6_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT6_LSB) <= trig_tap_delay(54);
    regs_read_arr(52)(REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT7_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT7_LSB) <= trig_tap_delay(55);
    regs_read_arr(52)(REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT0_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT0_LSB) <= trig_tap_delay(56);
    regs_read_arr(52)(REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT1_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT1_LSB) <= trig_tap_delay(57);
    regs_read_arr(52)(REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT2_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT2_LSB) <= trig_tap_delay(58);
    regs_read_arr(52)(REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT3_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT3_LSB) <= trig_tap_delay(59);
    regs_read_arr(53)(REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT4_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT4_LSB) <= trig_tap_delay(60);
    regs_read_arr(53)(REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT5_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT5_LSB) <= trig_tap_delay(61);
    regs_read_arr(53)(REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT6_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT6_LSB) <= trig_tap_delay(62);
    regs_read_arr(53)(REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT7_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT7_LSB) <= trig_tap_delay(63);
    regs_read_arr(53)(REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT0_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT0_LSB) <= trig_tap_delay(64);
    regs_read_arr(53)(REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT1_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT1_LSB) <= trig_tap_delay(65);
    regs_read_arr(54)(REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT2_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT2_LSB) <= trig_tap_delay(66);
    regs_read_arr(54)(REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT3_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT3_LSB) <= trig_tap_delay(67);
    regs_read_arr(54)(REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT4_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT4_LSB) <= trig_tap_delay(68);
    regs_read_arr(54)(REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT5_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT5_LSB) <= trig_tap_delay(69);
    regs_read_arr(54)(REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT6_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT6_LSB) <= trig_tap_delay(70);
    regs_read_arr(54)(REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT7_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT7_LSB) <= trig_tap_delay(71);
    regs_read_arr(55)(REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT0_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT0_LSB) <= trig_tap_delay(72);
    regs_read_arr(55)(REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT1_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT1_LSB) <= trig_tap_delay(73);
    regs_read_arr(55)(REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT2_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT2_LSB) <= trig_tap_delay(74);
    regs_read_arr(55)(REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT3_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT3_LSB) <= trig_tap_delay(75);
    regs_read_arr(55)(REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT4_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT4_LSB) <= trig_tap_delay(76);
    regs_read_arr(55)(REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT5_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT5_LSB) <= trig_tap_delay(77);
    regs_read_arr(56)(REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT6_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT6_LSB) <= trig_tap_delay(78);
    regs_read_arr(56)(REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT7_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT7_LSB) <= trig_tap_delay(79);
    regs_read_arr(56)(REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT0_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT0_LSB) <= trig_tap_delay(80);
    regs_read_arr(56)(REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT1_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT1_LSB) <= trig_tap_delay(81);
    regs_read_arr(56)(REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT2_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT2_LSB) <= trig_tap_delay(82);
    regs_read_arr(56)(REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT3_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT3_LSB) <= trig_tap_delay(83);
    regs_read_arr(57)(REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT4_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT4_LSB) <= trig_tap_delay(84);
    regs_read_arr(57)(REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT5_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT5_LSB) <= trig_tap_delay(85);
    regs_read_arr(57)(REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT6_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT6_LSB) <= trig_tap_delay(86);
    regs_read_arr(57)(REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT7_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT7_LSB) <= trig_tap_delay(87);
    regs_read_arr(57)(REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT0_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT0_LSB) <= trig_tap_delay(88);
    regs_read_arr(57)(REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT1_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT1_LSB) <= trig_tap_delay(89);
    regs_read_arr(58)(REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT2_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT2_LSB) <= trig_tap_delay(90);
    regs_read_arr(58)(REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT3_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT3_LSB) <= trig_tap_delay(91);
    regs_read_arr(58)(REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT4_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT4_LSB) <= trig_tap_delay(92);
    regs_read_arr(58)(REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT5_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT5_LSB) <= trig_tap_delay(93);
    regs_read_arr(58)(REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT6_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT6_LSB) <= trig_tap_delay(94);
    regs_read_arr(58)(REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT7_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT7_LSB) <= trig_tap_delay(95);
    regs_read_arr(59)(REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT0_MSB downto REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT0_LSB) <= sot_tap_delay(0);
    regs_read_arr(59)(REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT1_MSB downto REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT1_LSB) <= sot_tap_delay(1);
    regs_read_arr(59)(REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT2_MSB downto REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT2_LSB) <= sot_tap_delay(2);
    regs_read_arr(59)(REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT3_MSB downto REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT3_LSB) <= sot_tap_delay(3);
    regs_read_arr(59)(REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT4_MSB downto REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT4_LSB) <= sot_tap_delay(4);
    regs_read_arr(59)(REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT5_MSB downto REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT5_LSB) <= sot_tap_delay(5);
    regs_read_arr(60)(REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT6_MSB downto REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT6_LSB) <= sot_tap_delay(6);
    regs_read_arr(60)(REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT7_MSB downto REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT7_LSB) <= sot_tap_delay(7);
    regs_read_arr(60)(REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT8_MSB downto REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT8_LSB) <= sot_tap_delay(8);
    regs_read_arr(60)(REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT9_MSB downto REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT9_LSB) <= sot_tap_delay(9);
    regs_read_arr(60)(REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT10_MSB downto REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT10_LSB) <= sot_tap_delay(10);
    regs_read_arr(60)(REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT11_MSB downto REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT11_LSB) <= sot_tap_delay(11);
    regs_read_arr(62)(REG_TRIG_LINKS_TX_PLL_LOCKED_BIT) <= tx_pll_locked;
    regs_read_arr(62)(REG_TRIG_LINKS_TX_RESET_DONE_BIT) <= tx_reset_done;
    regs_read_arr(62)(REG_TRIG_LINKS_TX_PRBS_MODE_MSB downto REG_TRIG_LINKS_TX_PRBS_MODE_LSB) <= tx_prbs_mode;
    regs_read_arr(62)(REG_TRIG_LINKS_TX_PLL_RESET_BIT) <= pll_reset;
    regs_read_arr(62)(REG_TRIG_LINKS_MGT_RESET_MSB downto REG_TRIG_LINKS_MGT_RESET_LSB) <= mgt_reset;
    regs_read_arr(62)(REG_TRIG_LINKS_GTXTEST_START_BIT) <= gtxtest_start;
    regs_read_arr(62)(REG_TRIG_LINKS_TXRESET_BIT) <= txreset;
    regs_read_arr(62)(REG_TRIG_LINKS_MGT_REALIGN_BIT) <= mgt_realign;
    regs_read_arr(62)(REG_TRIG_LINKS_TXPOWERDOWN_BIT) <= txpowerdown;
    regs_read_arr(62)(REG_TRIG_LINKS_TXPOWERDOWN_MODE_MSB downto REG_TRIG_LINKS_TXPOWERDOWN_MODE_LSB) <= txpowerdown_mode;
    regs_read_arr(62)(REG_TRIG_LINKS_TXPLLPOWERDOWN_BIT) <= txpllpowerdown;
    regs_read_arr(62)(REG_TRIG_LINKS_FORCE_NOT_READY_BIT) <= force_mgts_not_ready;
    regs_read_arr(64)(REG_TRIG_SBIT_MONITOR_CLUSTER0_MSB downto REG_TRIG_SBIT_MONITOR_CLUSTER0_LSB) <= '0' & frozen_cluster_0(13 downto 11) & '0' & frozen_cluster_0 (10 downto 0);
    regs_read_arr(65)(REG_TRIG_SBIT_MONITOR_CLUSTER1_MSB downto REG_TRIG_SBIT_MONITOR_CLUSTER1_LSB) <= '0' & frozen_cluster_1(13 downto 11) & '0' & frozen_cluster_1 (10 downto 0);
    regs_read_arr(66)(REG_TRIG_SBIT_MONITOR_CLUSTER2_MSB downto REG_TRIG_SBIT_MONITOR_CLUSTER2_LSB) <= '0' & frozen_cluster_2(13 downto 11) & '0' & frozen_cluster_2 (10 downto 0);
    regs_read_arr(67)(REG_TRIG_SBIT_MONITOR_CLUSTER3_MSB downto REG_TRIG_SBIT_MONITOR_CLUSTER3_LSB) <= '0' & frozen_cluster_3(13 downto 11) & '0' & frozen_cluster_3 (10 downto 0);
    regs_read_arr(68)(REG_TRIG_SBIT_MONITOR_CLUSTER4_MSB downto REG_TRIG_SBIT_MONITOR_CLUSTER4_LSB) <= '0' & frozen_cluster_4(13 downto 11) & '0' & frozen_cluster_4 (10 downto 0);
    regs_read_arr(69)(REG_TRIG_SBIT_MONITOR_CLUSTER5_MSB downto REG_TRIG_SBIT_MONITOR_CLUSTER5_LSB) <= '0' & frozen_cluster_5(13 downto 11) & '0' & frozen_cluster_5 (10 downto 0);
    regs_read_arr(70)(REG_TRIG_SBIT_MONITOR_CLUSTER6_MSB downto REG_TRIG_SBIT_MONITOR_CLUSTER6_LSB) <= '0' & frozen_cluster_6(13 downto 11) & '0' & frozen_cluster_6 (10 downto 0);
    regs_read_arr(71)(REG_TRIG_SBIT_MONITOR_CLUSTER7_MSB downto REG_TRIG_SBIT_MONITOR_CLUSTER7_LSB) <= '0' & frozen_cluster_7(13 downto 11) & '0' & frozen_cluster_7 (10 downto 0);
    regs_read_arr(72)(REG_TRIG_SBIT_MONITOR_L1A_DELAY_MSB downto REG_TRIG_SBIT_MONITOR_L1A_DELAY_LSB) <= sbitmon_l1a_delay;
    regs_read_arr(74)(REG_TRIG_SBIT_HITMAP_ACQUIRE_BIT) <= hitmap_acquire;
    regs_read_arr(75)(REG_TRIG_SBIT_HITMAP_VFAT0_MSB_MSB downto REG_TRIG_SBIT_HITMAP_VFAT0_MSB_LSB) <= hitmap_sbits(0)(63 downto 32);
    regs_read_arr(76)(REG_TRIG_SBIT_HITMAP_VFAT0_LSB_MSB downto REG_TRIG_SBIT_HITMAP_VFAT0_LSB_LSB) <= hitmap_sbits(0)(31 downto 0);
    regs_read_arr(77)(REG_TRIG_SBIT_HITMAP_VFAT1_MSB_MSB downto REG_TRIG_SBIT_HITMAP_VFAT1_MSB_LSB) <= hitmap_sbits(1)(63 downto 32);
    regs_read_arr(78)(REG_TRIG_SBIT_HITMAP_VFAT1_LSB_MSB downto REG_TRIG_SBIT_HITMAP_VFAT1_LSB_LSB) <= hitmap_sbits(1)(31 downto 0);
    regs_read_arr(79)(REG_TRIG_SBIT_HITMAP_VFAT2_MSB_MSB downto REG_TRIG_SBIT_HITMAP_VFAT2_MSB_LSB) <= hitmap_sbits(2)(63 downto 32);
    regs_read_arr(80)(REG_TRIG_SBIT_HITMAP_VFAT2_LSB_MSB downto REG_TRIG_SBIT_HITMAP_VFAT2_LSB_LSB) <= hitmap_sbits(2)(31 downto 0);
    regs_read_arr(81)(REG_TRIG_SBIT_HITMAP_VFAT3_MSB_MSB downto REG_TRIG_SBIT_HITMAP_VFAT3_MSB_LSB) <= hitmap_sbits(3)(63 downto 32);
    regs_read_arr(82)(REG_TRIG_SBIT_HITMAP_VFAT3_LSB_MSB downto REG_TRIG_SBIT_HITMAP_VFAT3_LSB_LSB) <= hitmap_sbits(3)(31 downto 0);
    regs_read_arr(83)(REG_TRIG_SBIT_HITMAP_VFAT4_MSB_MSB downto REG_TRIG_SBIT_HITMAP_VFAT4_MSB_LSB) <= hitmap_sbits(4)(63 downto 32);
    regs_read_arr(84)(REG_TRIG_SBIT_HITMAP_VFAT4_LSB_MSB downto REG_TRIG_SBIT_HITMAP_VFAT4_LSB_LSB) <= hitmap_sbits(4)(31 downto 0);
    regs_read_arr(85)(REG_TRIG_SBIT_HITMAP_VFAT5_MSB_MSB downto REG_TRIG_SBIT_HITMAP_VFAT5_MSB_LSB) <= hitmap_sbits(5)(63 downto 32);
    regs_read_arr(86)(REG_TRIG_SBIT_HITMAP_VFAT5_LSB_MSB downto REG_TRIG_SBIT_HITMAP_VFAT5_LSB_LSB) <= hitmap_sbits(5)(31 downto 0);
    regs_read_arr(87)(REG_TRIG_SBIT_HITMAP_VFAT6_MSB_MSB downto REG_TRIG_SBIT_HITMAP_VFAT6_MSB_LSB) <= hitmap_sbits(6)(63 downto 32);
    regs_read_arr(88)(REG_TRIG_SBIT_HITMAP_VFAT6_LSB_MSB downto REG_TRIG_SBIT_HITMAP_VFAT6_LSB_LSB) <= hitmap_sbits(6)(31 downto 0);
    regs_read_arr(89)(REG_TRIG_SBIT_HITMAP_VFAT7_MSB_MSB downto REG_TRIG_SBIT_HITMAP_VFAT7_MSB_LSB) <= hitmap_sbits(7)(63 downto 32);
    regs_read_arr(90)(REG_TRIG_SBIT_HITMAP_VFAT7_LSB_MSB downto REG_TRIG_SBIT_HITMAP_VFAT7_LSB_LSB) <= hitmap_sbits(7)(31 downto 0);
    regs_read_arr(91)(REG_TRIG_SBIT_HITMAP_VFAT8_MSB_MSB downto REG_TRIG_SBIT_HITMAP_VFAT8_MSB_LSB) <= hitmap_sbits(8)(63 downto 32);
    regs_read_arr(92)(REG_TRIG_SBIT_HITMAP_VFAT8_LSB_MSB downto REG_TRIG_SBIT_HITMAP_VFAT8_LSB_LSB) <= hitmap_sbits(8)(31 downto 0);
    regs_read_arr(93)(REG_TRIG_SBIT_HITMAP_VFAT9_MSB_MSB downto REG_TRIG_SBIT_HITMAP_VFAT9_MSB_LSB) <= hitmap_sbits(9)(63 downto 32);
    regs_read_arr(94)(REG_TRIG_SBIT_HITMAP_VFAT9_LSB_MSB downto REG_TRIG_SBIT_HITMAP_VFAT9_LSB_LSB) <= hitmap_sbits(9)(31 downto 0);
    regs_read_arr(95)(REG_TRIG_SBIT_HITMAP_VFAT10_MSB_MSB downto REG_TRIG_SBIT_HITMAP_VFAT10_MSB_LSB) <= hitmap_sbits(10)(63 downto 32);
    regs_read_arr(96)(REG_TRIG_SBIT_HITMAP_VFAT10_LSB_MSB downto REG_TRIG_SBIT_HITMAP_VFAT10_LSB_LSB) <= hitmap_sbits(10)(31 downto 0);
    regs_read_arr(97)(REG_TRIG_SBIT_HITMAP_VFAT11_MSB_MSB downto REG_TRIG_SBIT_HITMAP_VFAT11_MSB_LSB) <= hitmap_sbits(11)(63 downto 32);
    regs_read_arr(98)(REG_TRIG_SBIT_HITMAP_VFAT11_LSB_MSB downto REG_TRIG_SBIT_HITMAP_VFAT11_LSB_LSB) <= hitmap_sbits(11)(31 downto 0);
    regs_read_arr(99)(REG_TRIG_CTRL_SBIT_SOT_INVALID_BITSKIP_MSB downto REG_TRIG_CTRL_SBIT_SOT_INVALID_BITSKIP_LSB) <= sot_invalid_bitskip;

    -- Connect write signals
    vfat_mask <= regs_write_arr(0)(REG_TRIG_CTRL_VFAT_MASK_MSB downto REG_TRIG_CTRL_VFAT_MASK_LSB);
    trig_deadtime <= regs_write_arr(0)(REG_TRIG_CTRL_SBIT_DEADTIME_MSB downto REG_TRIG_CTRL_SBIT_DEADTIME_LSB);
    aligned_count_to_ready <= regs_write_arr(2)(REG_TRIG_CTRL_ALIGNED_COUNT_TO_READY_MSB downto REG_TRIG_CTRL_ALIGNED_COUNT_TO_READY_LSB);
    sot_invert <= regs_write_arr(5)(REG_TRIG_CTRL_INVERT_SOT_INVERT_MSB downto REG_TRIG_CTRL_INVERT_SOT_INVERT_LSB);
    TU_INVERT (7 downto 0) <= regs_write_arr(6)(REG_TRIG_CTRL_INVERT_VFAT0_TU_INVERT_MSB downto REG_TRIG_CTRL_INVERT_VFAT0_TU_INVERT_LSB);
    TU_INVERT (15 downto 8) <= regs_write_arr(6)(REG_TRIG_CTRL_INVERT_VFAT1_TU_INVERT_MSB downto REG_TRIG_CTRL_INVERT_VFAT1_TU_INVERT_LSB);
    TU_INVERT (23 downto 16) <= regs_write_arr(6)(REG_TRIG_CTRL_INVERT_VFAT2_TU_INVERT_MSB downto REG_TRIG_CTRL_INVERT_VFAT2_TU_INVERT_LSB);
    TU_INVERT (31 downto 24) <= regs_write_arr(6)(REG_TRIG_CTRL_INVERT_VFAT3_TU_INVERT_MSB downto REG_TRIG_CTRL_INVERT_VFAT3_TU_INVERT_LSB);
    TU_INVERT (39 downto 32) <= regs_write_arr(7)(REG_TRIG_CTRL_INVERT_VFAT4_TU_INVERT_MSB downto REG_TRIG_CTRL_INVERT_VFAT4_TU_INVERT_LSB);
    TU_INVERT (47 downto 40) <= regs_write_arr(7)(REG_TRIG_CTRL_INVERT_VFAT5_TU_INVERT_MSB downto REG_TRIG_CTRL_INVERT_VFAT5_TU_INVERT_LSB);
    TU_INVERT (55 downto 48) <= regs_write_arr(7)(REG_TRIG_CTRL_INVERT_VFAT6_TU_INVERT_MSB downto REG_TRIG_CTRL_INVERT_VFAT6_TU_INVERT_LSB);
    TU_INVERT (63 downto 56) <= regs_write_arr(7)(REG_TRIG_CTRL_INVERT_VFAT7_TU_INVERT_MSB downto REG_TRIG_CTRL_INVERT_VFAT7_TU_INVERT_LSB);
    TU_INVERT (71 downto 64) <= regs_write_arr(8)(REG_TRIG_CTRL_INVERT_VFAT8_TU_INVERT_MSB downto REG_TRIG_CTRL_INVERT_VFAT8_TU_INVERT_LSB);
    TU_INVERT (79 downto 72) <= regs_write_arr(8)(REG_TRIG_CTRL_INVERT_VFAT9_TU_INVERT_MSB downto REG_TRIG_CTRL_INVERT_VFAT9_TU_INVERT_LSB);
    TU_INVERT (87 downto 80) <= regs_write_arr(8)(REG_TRIG_CTRL_INVERT_VFAT10_TU_INVERT_MSB downto REG_TRIG_CTRL_INVERT_VFAT10_TU_INVERT_LSB);
    TU_INVERT (95 downto 88) <= regs_write_arr(8)(REG_TRIG_CTRL_INVERT_VFAT11_TU_INVERT_MSB downto REG_TRIG_CTRL_INVERT_VFAT11_TU_INVERT_LSB);
    sbits_mux_sel <= regs_write_arr(9)(REG_TRIG_CTRL_SBITS_MUX_SBIT_MUX_SEL_MSB downto REG_TRIG_CTRL_SBITS_MUX_SBIT_MUX_SEL_LSB);
    TU_MASK (7 downto 0) <= regs_write_arr(12)(REG_TRIG_CTRL_TU_MASK_VFAT0_TU_MASK_MSB downto REG_TRIG_CTRL_TU_MASK_VFAT0_TU_MASK_LSB);
    TU_MASK (15 downto 8) <= regs_write_arr(12)(REG_TRIG_CTRL_TU_MASK_VFAT1_TU_MASK_MSB downto REG_TRIG_CTRL_TU_MASK_VFAT1_TU_MASK_LSB);
    TU_MASK (23 downto 16) <= regs_write_arr(12)(REG_TRIG_CTRL_TU_MASK_VFAT2_TU_MASK_MSB downto REG_TRIG_CTRL_TU_MASK_VFAT2_TU_MASK_LSB);
    TU_MASK (31 downto 24) <= regs_write_arr(12)(REG_TRIG_CTRL_TU_MASK_VFAT3_TU_MASK_MSB downto REG_TRIG_CTRL_TU_MASK_VFAT3_TU_MASK_LSB);
    TU_MASK (39 downto 32) <= regs_write_arr(13)(REG_TRIG_CTRL_TU_MASK_VFAT4_TU_MASK_MSB downto REG_TRIG_CTRL_TU_MASK_VFAT4_TU_MASK_LSB);
    TU_MASK (47 downto 40) <= regs_write_arr(13)(REG_TRIG_CTRL_TU_MASK_VFAT5_TU_MASK_MSB downto REG_TRIG_CTRL_TU_MASK_VFAT5_TU_MASK_LSB);
    TU_MASK (55 downto 48) <= regs_write_arr(13)(REG_TRIG_CTRL_TU_MASK_VFAT6_TU_MASK_MSB downto REG_TRIG_CTRL_TU_MASK_VFAT6_TU_MASK_LSB);
    TU_MASK (63 downto 56) <= regs_write_arr(13)(REG_TRIG_CTRL_TU_MASK_VFAT7_TU_MASK_MSB downto REG_TRIG_CTRL_TU_MASK_VFAT7_TU_MASK_LSB);
    TU_MASK (71 downto 64) <= regs_write_arr(14)(REG_TRIG_CTRL_TU_MASK_VFAT8_TU_MASK_MSB downto REG_TRIG_CTRL_TU_MASK_VFAT8_TU_MASK_LSB);
    TU_MASK (79 downto 72) <= regs_write_arr(14)(REG_TRIG_CTRL_TU_MASK_VFAT9_TU_MASK_MSB downto REG_TRIG_CTRL_TU_MASK_VFAT9_TU_MASK_LSB);
    TU_MASK (87 downto 80) <= regs_write_arr(14)(REG_TRIG_CTRL_TU_MASK_VFAT10_TU_MASK_MSB downto REG_TRIG_CTRL_TU_MASK_VFAT10_TU_MASK_LSB);
    TU_MASK (95 downto 88) <= regs_write_arr(14)(REG_TRIG_CTRL_TU_MASK_VFAT11_TU_MASK_MSB downto REG_TRIG_CTRL_TU_MASK_VFAT11_TU_MASK_LSB);
    sbit_cnt_persist <= regs_write_arr(28)(REG_TRIG_CNT_SBIT_CNT_PERSIST_BIT);
    sbit_cnt_time_max <= regs_write_arr(29)(REG_TRIG_CNT_SBIT_CNT_TIME_MAX_MSB downto REG_TRIG_CNT_SBIT_CNT_TIME_MAX_LSB);
    trig_tap_delay(0) <= regs_write_arr(43)(REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT0_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT0_LSB);
    trig_tap_delay(1) <= regs_write_arr(43)(REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT1_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT1_LSB);
    trig_tap_delay(2) <= regs_write_arr(43)(REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT2_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT2_LSB);
    trig_tap_delay(3) <= regs_write_arr(43)(REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT3_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT3_LSB);
    trig_tap_delay(4) <= regs_write_arr(43)(REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT4_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT4_LSB);
    trig_tap_delay(5) <= regs_write_arr(43)(REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT5_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT5_LSB);
    trig_tap_delay(6) <= regs_write_arr(44)(REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT6_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT6_LSB);
    trig_tap_delay(7) <= regs_write_arr(44)(REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT7_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT7_LSB);
    trig_tap_delay(8) <= regs_write_arr(44)(REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT0_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT0_LSB);
    trig_tap_delay(9) <= regs_write_arr(44)(REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT1_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT1_LSB);
    trig_tap_delay(10) <= regs_write_arr(44)(REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT2_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT2_LSB);
    trig_tap_delay(11) <= regs_write_arr(44)(REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT3_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT3_LSB);
    trig_tap_delay(12) <= regs_write_arr(45)(REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT4_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT4_LSB);
    trig_tap_delay(13) <= regs_write_arr(45)(REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT5_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT5_LSB);
    trig_tap_delay(14) <= regs_write_arr(45)(REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT6_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT6_LSB);
    trig_tap_delay(15) <= regs_write_arr(45)(REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT7_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT7_LSB);
    trig_tap_delay(16) <= regs_write_arr(45)(REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT0_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT0_LSB);
    trig_tap_delay(17) <= regs_write_arr(45)(REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT1_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT1_LSB);
    trig_tap_delay(18) <= regs_write_arr(46)(REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT2_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT2_LSB);
    trig_tap_delay(19) <= regs_write_arr(46)(REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT3_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT3_LSB);
    trig_tap_delay(20) <= regs_write_arr(46)(REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT4_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT4_LSB);
    trig_tap_delay(21) <= regs_write_arr(46)(REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT5_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT5_LSB);
    trig_tap_delay(22) <= regs_write_arr(46)(REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT6_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT6_LSB);
    trig_tap_delay(23) <= regs_write_arr(46)(REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT7_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT7_LSB);
    trig_tap_delay(24) <= regs_write_arr(47)(REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT0_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT0_LSB);
    trig_tap_delay(25) <= regs_write_arr(47)(REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT1_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT1_LSB);
    trig_tap_delay(26) <= regs_write_arr(47)(REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT2_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT2_LSB);
    trig_tap_delay(27) <= regs_write_arr(47)(REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT3_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT3_LSB);
    trig_tap_delay(28) <= regs_write_arr(47)(REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT4_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT4_LSB);
    trig_tap_delay(29) <= regs_write_arr(47)(REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT5_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT5_LSB);
    trig_tap_delay(30) <= regs_write_arr(48)(REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT6_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT6_LSB);
    trig_tap_delay(31) <= regs_write_arr(48)(REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT7_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT7_LSB);
    trig_tap_delay(32) <= regs_write_arr(48)(REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT0_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT0_LSB);
    trig_tap_delay(33) <= regs_write_arr(48)(REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT1_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT1_LSB);
    trig_tap_delay(34) <= regs_write_arr(48)(REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT2_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT2_LSB);
    trig_tap_delay(35) <= regs_write_arr(48)(REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT3_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT3_LSB);
    trig_tap_delay(36) <= regs_write_arr(49)(REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT4_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT4_LSB);
    trig_tap_delay(37) <= regs_write_arr(49)(REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT5_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT5_LSB);
    trig_tap_delay(38) <= regs_write_arr(49)(REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT6_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT6_LSB);
    trig_tap_delay(39) <= regs_write_arr(49)(REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT7_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT7_LSB);
    trig_tap_delay(40) <= regs_write_arr(49)(REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT0_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT0_LSB);
    trig_tap_delay(41) <= regs_write_arr(49)(REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT1_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT1_LSB);
    trig_tap_delay(42) <= regs_write_arr(50)(REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT2_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT2_LSB);
    trig_tap_delay(43) <= regs_write_arr(50)(REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT3_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT3_LSB);
    trig_tap_delay(44) <= regs_write_arr(50)(REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT4_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT4_LSB);
    trig_tap_delay(45) <= regs_write_arr(50)(REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT5_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT5_LSB);
    trig_tap_delay(46) <= regs_write_arr(50)(REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT6_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT6_LSB);
    trig_tap_delay(47) <= regs_write_arr(50)(REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT7_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT7_LSB);
    trig_tap_delay(48) <= regs_write_arr(51)(REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT0_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT0_LSB);
    trig_tap_delay(49) <= regs_write_arr(51)(REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT1_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT1_LSB);
    trig_tap_delay(50) <= regs_write_arr(51)(REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT2_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT2_LSB);
    trig_tap_delay(51) <= regs_write_arr(51)(REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT3_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT3_LSB);
    trig_tap_delay(52) <= regs_write_arr(51)(REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT4_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT4_LSB);
    trig_tap_delay(53) <= regs_write_arr(51)(REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT5_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT5_LSB);
    trig_tap_delay(54) <= regs_write_arr(52)(REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT6_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT6_LSB);
    trig_tap_delay(55) <= regs_write_arr(52)(REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT7_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT7_LSB);
    trig_tap_delay(56) <= regs_write_arr(52)(REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT0_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT0_LSB);
    trig_tap_delay(57) <= regs_write_arr(52)(REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT1_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT1_LSB);
    trig_tap_delay(58) <= regs_write_arr(52)(REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT2_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT2_LSB);
    trig_tap_delay(59) <= regs_write_arr(52)(REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT3_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT3_LSB);
    trig_tap_delay(60) <= regs_write_arr(53)(REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT4_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT4_LSB);
    trig_tap_delay(61) <= regs_write_arr(53)(REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT5_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT5_LSB);
    trig_tap_delay(62) <= regs_write_arr(53)(REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT6_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT6_LSB);
    trig_tap_delay(63) <= regs_write_arr(53)(REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT7_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT7_LSB);
    trig_tap_delay(64) <= regs_write_arr(53)(REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT0_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT0_LSB);
    trig_tap_delay(65) <= regs_write_arr(53)(REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT1_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT1_LSB);
    trig_tap_delay(66) <= regs_write_arr(54)(REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT2_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT2_LSB);
    trig_tap_delay(67) <= regs_write_arr(54)(REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT3_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT3_LSB);
    trig_tap_delay(68) <= regs_write_arr(54)(REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT4_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT4_LSB);
    trig_tap_delay(69) <= regs_write_arr(54)(REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT5_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT5_LSB);
    trig_tap_delay(70) <= regs_write_arr(54)(REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT6_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT6_LSB);
    trig_tap_delay(71) <= regs_write_arr(54)(REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT7_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT7_LSB);
    trig_tap_delay(72) <= regs_write_arr(55)(REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT0_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT0_LSB);
    trig_tap_delay(73) <= regs_write_arr(55)(REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT1_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT1_LSB);
    trig_tap_delay(74) <= regs_write_arr(55)(REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT2_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT2_LSB);
    trig_tap_delay(75) <= regs_write_arr(55)(REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT3_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT3_LSB);
    trig_tap_delay(76) <= regs_write_arr(55)(REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT4_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT4_LSB);
    trig_tap_delay(77) <= regs_write_arr(55)(REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT5_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT5_LSB);
    trig_tap_delay(78) <= regs_write_arr(56)(REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT6_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT6_LSB);
    trig_tap_delay(79) <= regs_write_arr(56)(REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT7_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT7_LSB);
    trig_tap_delay(80) <= regs_write_arr(56)(REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT0_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT0_LSB);
    trig_tap_delay(81) <= regs_write_arr(56)(REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT1_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT1_LSB);
    trig_tap_delay(82) <= regs_write_arr(56)(REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT2_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT2_LSB);
    trig_tap_delay(83) <= regs_write_arr(56)(REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT3_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT3_LSB);
    trig_tap_delay(84) <= regs_write_arr(57)(REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT4_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT4_LSB);
    trig_tap_delay(85) <= regs_write_arr(57)(REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT5_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT5_LSB);
    trig_tap_delay(86) <= regs_write_arr(57)(REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT6_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT6_LSB);
    trig_tap_delay(87) <= regs_write_arr(57)(REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT7_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT7_LSB);
    trig_tap_delay(88) <= regs_write_arr(57)(REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT0_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT0_LSB);
    trig_tap_delay(89) <= regs_write_arr(57)(REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT1_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT1_LSB);
    trig_tap_delay(90) <= regs_write_arr(58)(REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT2_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT2_LSB);
    trig_tap_delay(91) <= regs_write_arr(58)(REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT3_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT3_LSB);
    trig_tap_delay(92) <= regs_write_arr(58)(REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT4_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT4_LSB);
    trig_tap_delay(93) <= regs_write_arr(58)(REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT5_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT5_LSB);
    trig_tap_delay(94) <= regs_write_arr(58)(REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT6_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT6_LSB);
    trig_tap_delay(95) <= regs_write_arr(58)(REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT7_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT7_LSB);
    sot_tap_delay(0) <= regs_write_arr(59)(REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT0_MSB downto REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT0_LSB);
    sot_tap_delay(1) <= regs_write_arr(59)(REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT1_MSB downto REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT1_LSB);
    sot_tap_delay(2) <= regs_write_arr(59)(REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT2_MSB downto REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT2_LSB);
    sot_tap_delay(3) <= regs_write_arr(59)(REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT3_MSB downto REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT3_LSB);
    sot_tap_delay(4) <= regs_write_arr(59)(REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT4_MSB downto REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT4_LSB);
    sot_tap_delay(5) <= regs_write_arr(59)(REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT5_MSB downto REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT5_LSB);
    sot_tap_delay(6) <= regs_write_arr(60)(REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT6_MSB downto REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT6_LSB);
    sot_tap_delay(7) <= regs_write_arr(60)(REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT7_MSB downto REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT7_LSB);
    sot_tap_delay(8) <= regs_write_arr(60)(REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT8_MSB downto REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT8_LSB);
    sot_tap_delay(9) <= regs_write_arr(60)(REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT9_MSB downto REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT9_LSB);
    sot_tap_delay(10) <= regs_write_arr(60)(REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT10_MSB downto REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT10_LSB);
    sot_tap_delay(11) <= regs_write_arr(60)(REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT11_MSB downto REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT11_LSB);
    tx_prbs_mode <= regs_write_arr(62)(REG_TRIG_LINKS_TX_PRBS_MODE_MSB downto REG_TRIG_LINKS_TX_PRBS_MODE_LSB);
    pll_reset <= regs_write_arr(62)(REG_TRIG_LINKS_TX_PLL_RESET_BIT);
    mgt_reset <= regs_write_arr(62)(REG_TRIG_LINKS_MGT_RESET_MSB downto REG_TRIG_LINKS_MGT_RESET_LSB);
    gtxtest_start <= regs_write_arr(62)(REG_TRIG_LINKS_GTXTEST_START_BIT);
    txreset <= regs_write_arr(62)(REG_TRIG_LINKS_TXRESET_BIT);
    mgt_realign <= regs_write_arr(62)(REG_TRIG_LINKS_MGT_REALIGN_BIT);
    txpowerdown <= regs_write_arr(62)(REG_TRIG_LINKS_TXPOWERDOWN_BIT);
    txpowerdown_mode <= regs_write_arr(62)(REG_TRIG_LINKS_TXPOWERDOWN_MODE_MSB downto REG_TRIG_LINKS_TXPOWERDOWN_MODE_LSB);
    txpllpowerdown <= regs_write_arr(62)(REG_TRIG_LINKS_TXPLLPOWERDOWN_BIT);
    force_mgts_not_ready <= regs_write_arr(62)(REG_TRIG_LINKS_FORCE_NOT_READY_BIT);
    hitmap_acquire <= regs_write_arr(74)(REG_TRIG_SBIT_HITMAP_ACQUIRE_BIT);

    -- Connect write pulse signals
    reset_counters <= regs_write_pulse_arr(27);
    reset_links <= regs_write_pulse_arr(61);
    reset_monitor <= regs_write_pulse_arr(63);
    hitmap_reset <= regs_write_pulse_arr(73);

    -- Connect write done signals

    -- Connect read pulse signals

    -- Connect counter instances

    COUNTER_TRIG_CTRL_CNT_OVERFLOW : entity work.counter_snap
    generic map (
        g_COUNTER_WIDTH  => 16
    )
    port map (
        ref_clk_i => clk_40,
        reset_i   => cnt_reset,
        en_i      => sbit_overflow,
        snap_i    => cnt_snap,
        count_o   => cnt_sbit_overflow
    );


    COUNTER_TRIG_CNT_VFAT0_SBITS : entity work.counter_snap
    generic map (
        g_COUNTER_WIDTH  => 32
    )
    port map (
        ref_clk_i => clk_40,
        reset_i   => cnt_reset_strobed,
        en_i      => active_vfats(0),
        snap_i    => sbit_cnt_snap,
        count_o   => cnt_vfat0
    );


    COUNTER_TRIG_CNT_VFAT1_SBITS : entity work.counter_snap
    generic map (
        g_COUNTER_WIDTH  => 32
    )
    port map (
        ref_clk_i => clk_40,
        reset_i   => cnt_reset_strobed,
        en_i      => active_vfats(1),
        snap_i    => sbit_cnt_snap,
        count_o   => cnt_vfat1
    );


    COUNTER_TRIG_CNT_VFAT2_SBITS : entity work.counter_snap
    generic map (
        g_COUNTER_WIDTH  => 32
    )
    port map (
        ref_clk_i => clk_40,
        reset_i   => cnt_reset_strobed,
        en_i      => active_vfats(2),
        snap_i    => sbit_cnt_snap,
        count_o   => cnt_vfat2
    );


    COUNTER_TRIG_CNT_VFAT3_SBITS : entity work.counter_snap
    generic map (
        g_COUNTER_WIDTH  => 32
    )
    port map (
        ref_clk_i => clk_40,
        reset_i   => cnt_reset_strobed,
        en_i      => active_vfats(3),
        snap_i    => sbit_cnt_snap,
        count_o   => cnt_vfat3
    );


    COUNTER_TRIG_CNT_VFAT4_SBITS : entity work.counter_snap
    generic map (
        g_COUNTER_WIDTH  => 32
    )
    port map (
        ref_clk_i => clk_40,
        reset_i   => cnt_reset_strobed,
        en_i      => active_vfats(4),
        snap_i    => sbit_cnt_snap,
        count_o   => cnt_vfat4
    );


    COUNTER_TRIG_CNT_VFAT5_SBITS : entity work.counter_snap
    generic map (
        g_COUNTER_WIDTH  => 32
    )
    port map (
        ref_clk_i => clk_40,
        reset_i   => cnt_reset_strobed,
        en_i      => active_vfats(5),
        snap_i    => sbit_cnt_snap,
        count_o   => cnt_vfat5
    );


    COUNTER_TRIG_CNT_VFAT6_SBITS : entity work.counter_snap
    generic map (
        g_COUNTER_WIDTH  => 32
    )
    port map (
        ref_clk_i => clk_40,
        reset_i   => cnt_reset_strobed,
        en_i      => active_vfats(6),
        snap_i    => sbit_cnt_snap,
        count_o   => cnt_vfat6
    );


    COUNTER_TRIG_CNT_VFAT7_SBITS : entity work.counter_snap
    generic map (
        g_COUNTER_WIDTH  => 32
    )
    port map (
        ref_clk_i => clk_40,
        reset_i   => cnt_reset_strobed,
        en_i      => active_vfats(7),
        snap_i    => sbit_cnt_snap,
        count_o   => cnt_vfat7
    );


    COUNTER_TRIG_CNT_VFAT8_SBITS : entity work.counter_snap
    generic map (
        g_COUNTER_WIDTH  => 32
    )
    port map (
        ref_clk_i => clk_40,
        reset_i   => cnt_reset_strobed,
        en_i      => active_vfats(8),
        snap_i    => sbit_cnt_snap,
        count_o   => cnt_vfat8
    );


    COUNTER_TRIG_CNT_VFAT9_SBITS : entity work.counter_snap
    generic map (
        g_COUNTER_WIDTH  => 32
    )
    port map (
        ref_clk_i => clk_40,
        reset_i   => cnt_reset_strobed,
        en_i      => active_vfats(9),
        snap_i    => sbit_cnt_snap,
        count_o   => cnt_vfat9
    );


    COUNTER_TRIG_CNT_VFAT10_SBITS : entity work.counter_snap
    generic map (
        g_COUNTER_WIDTH  => 32
    )
    port map (
        ref_clk_i => clk_40,
        reset_i   => cnt_reset_strobed,
        en_i      => active_vfats(10),
        snap_i    => sbit_cnt_snap,
        count_o   => cnt_vfat10
    );


    COUNTER_TRIG_CNT_VFAT11_SBITS : entity work.counter_snap
    generic map (
        g_COUNTER_WIDTH  => 32
    )
    port map (
        ref_clk_i => clk_40,
        reset_i   => cnt_reset_strobed,
        en_i      => active_vfats(11),
        snap_i    => sbit_cnt_snap,
        count_o   => cnt_vfat11
    );


    COUNTER_TRIG_CNT_CLUSTER_COUNT : entity work.counter_snap
    generic map (
        g_COUNTER_WIDTH  => 32
    )
    port map (
        ref_clk_i => clk_40,
        reset_i   => cnt_reset_strobed,
        en_i      => valid_clusters_or,
        snap_i    => sbit_cnt_snap,
        count_o   => cnt_clusters
    );


    COUNTER_TRIG_CNT_SBITS_OVER_64x0 : entity work.counter_snap
    generic map (
        g_COUNTER_WIDTH  => 16
    )
    port map (
        ref_clk_i => clk_40,
        reset_i   => cnt_reset_strobed,
        en_i      => sbits_comparator_over_threshold(0),
        snap_i    => sbit_cnt_snap,
        count_o   => cnt_over_threshold0
    );


    COUNTER_TRIG_CNT_SBITS_OVER_64x1 : entity work.counter_snap
    generic map (
        g_COUNTER_WIDTH  => 16
    )
    port map (
        ref_clk_i => clk_40,
        reset_i   => cnt_reset_strobed,
        en_i      => sbits_comparator_over_threshold(1),
        snap_i    => sbit_cnt_snap,
        count_o   => cnt_over_threshold1
    );


    COUNTER_TRIG_CNT_SBITS_OVER_64x2 : entity work.counter_snap
    generic map (
        g_COUNTER_WIDTH  => 16
    )
    port map (
        ref_clk_i => clk_40,
        reset_i   => cnt_reset_strobed,
        en_i      => sbits_comparator_over_threshold(2),
        snap_i    => sbit_cnt_snap,
        count_o   => cnt_over_threshold2
    );


    COUNTER_TRIG_CNT_SBITS_OVER_64x3 : entity work.counter_snap
    generic map (
        g_COUNTER_WIDTH  => 16
    )
    port map (
        ref_clk_i => clk_40,
        reset_i   => cnt_reset_strobed,
        en_i      => sbits_comparator_over_threshold(3),
        snap_i    => sbit_cnt_snap,
        count_o   => cnt_over_threshold3
    );


    COUNTER_TRIG_CNT_SBITS_OVER_64x4 : entity work.counter_snap
    generic map (
        g_COUNTER_WIDTH  => 16
    )
    port map (
        ref_clk_i => clk_40,
        reset_i   => cnt_reset_strobed,
        en_i      => sbits_comparator_over_threshold(4),
        snap_i    => sbit_cnt_snap,
        count_o   => cnt_over_threshold4
    );


    COUNTER_TRIG_CNT_SBITS_OVER_64x5 : entity work.counter_snap
    generic map (
        g_COUNTER_WIDTH  => 16
    )
    port map (
        ref_clk_i => clk_40,
        reset_i   => cnt_reset_strobed,
        en_i      => sbits_comparator_over_threshold(5),
        snap_i    => sbit_cnt_snap,
        count_o   => cnt_over_threshold5
    );


    COUNTER_TRIG_CNT_SBITS_OVER_64x6 : entity work.counter_snap
    generic map (
        g_COUNTER_WIDTH  => 16
    )
    port map (
        ref_clk_i => clk_40,
        reset_i   => cnt_reset_strobed,
        en_i      => sbits_comparator_over_threshold(6),
        snap_i    => sbit_cnt_snap,
        count_o   => cnt_over_threshold6
    );


    COUNTER_TRIG_CNT_SBITS_OVER_64x7 : entity work.counter_snap
    generic map (
        g_COUNTER_WIDTH  => 16
    )
    port map (
        ref_clk_i => clk_40,
        reset_i   => cnt_reset_strobed,
        en_i      => sbits_comparator_over_threshold(7),
        snap_i    => sbit_cnt_snap,
        count_o   => cnt_over_threshold7
    );


    COUNTER_TRIG_CNT_SBITS_OVER_64x8 : entity work.counter_snap
    generic map (
        g_COUNTER_WIDTH  => 16
    )
    port map (
        ref_clk_i => clk_40,
        reset_i   => cnt_reset_strobed,
        en_i      => sbits_comparator_over_threshold(8),
        snap_i    => sbit_cnt_snap,
        count_o   => cnt_over_threshold8
    );


    COUNTER_TRIG_CNT_SBITS_OVER_64x9 : entity work.counter_snap
    generic map (
        g_COUNTER_WIDTH  => 16
    )
    port map (
        ref_clk_i => clk_40,
        reset_i   => cnt_reset_strobed,
        en_i      => sbits_comparator_over_threshold(9),
        snap_i    => sbit_cnt_snap,
        count_o   => cnt_over_threshold9
    );


    COUNTER_TRIG_CNT_SBITS_OVER_64x10 : entity work.counter_snap
    generic map (
        g_COUNTER_WIDTH  => 16
    )
    port map (
        ref_clk_i => clk_40,
        reset_i   => cnt_reset_strobed,
        en_i      => sbits_comparator_over_threshold(10),
        snap_i    => sbit_cnt_snap,
        count_o   => cnt_over_threshold10
    );


    COUNTER_TRIG_CNT_SBITS_OVER_64x11 : entity work.counter_snap
    generic map (
        g_COUNTER_WIDTH  => 16
    )
    port map (
        ref_clk_i => clk_40,
        reset_i   => cnt_reset_strobed,
        en_i      => sbits_comparator_over_threshold(11),
        snap_i    => sbit_cnt_snap,
        count_o   => cnt_over_threshold11
    );


    -- Connect rate instances

    -- Connect read ready signals

    -- Defaults
    regs_defaults(0)(REG_TRIG_CTRL_VFAT_MASK_MSB downto REG_TRIG_CTRL_VFAT_MASK_LSB) <= REG_TRIG_CTRL_VFAT_MASK_DEFAULT;
    regs_defaults(0)(REG_TRIG_CTRL_SBIT_DEADTIME_MSB downto REG_TRIG_CTRL_SBIT_DEADTIME_LSB) <= REG_TRIG_CTRL_SBIT_DEADTIME_DEFAULT;
    regs_defaults(2)(REG_TRIG_CTRL_ALIGNED_COUNT_TO_READY_MSB downto REG_TRIG_CTRL_ALIGNED_COUNT_TO_READY_LSB) <= REG_TRIG_CTRL_ALIGNED_COUNT_TO_READY_DEFAULT;
    regs_defaults(5)(REG_TRIG_CTRL_INVERT_SOT_INVERT_MSB downto REG_TRIG_CTRL_INVERT_SOT_INVERT_LSB) <= REG_TRIG_CTRL_INVERT_SOT_INVERT_DEFAULT;
    regs_defaults(6)(REG_TRIG_CTRL_INVERT_VFAT0_TU_INVERT_MSB downto REG_TRIG_CTRL_INVERT_VFAT0_TU_INVERT_LSB) <= REG_TRIG_CTRL_INVERT_VFAT0_TU_INVERT_DEFAULT;
    regs_defaults(6)(REG_TRIG_CTRL_INVERT_VFAT1_TU_INVERT_MSB downto REG_TRIG_CTRL_INVERT_VFAT1_TU_INVERT_LSB) <= REG_TRIG_CTRL_INVERT_VFAT1_TU_INVERT_DEFAULT;
    regs_defaults(6)(REG_TRIG_CTRL_INVERT_VFAT2_TU_INVERT_MSB downto REG_TRIG_CTRL_INVERT_VFAT2_TU_INVERT_LSB) <= REG_TRIG_CTRL_INVERT_VFAT2_TU_INVERT_DEFAULT;
    regs_defaults(6)(REG_TRIG_CTRL_INVERT_VFAT3_TU_INVERT_MSB downto REG_TRIG_CTRL_INVERT_VFAT3_TU_INVERT_LSB) <= REG_TRIG_CTRL_INVERT_VFAT3_TU_INVERT_DEFAULT;
    regs_defaults(7)(REG_TRIG_CTRL_INVERT_VFAT4_TU_INVERT_MSB downto REG_TRIG_CTRL_INVERT_VFAT4_TU_INVERT_LSB) <= REG_TRIG_CTRL_INVERT_VFAT4_TU_INVERT_DEFAULT;
    regs_defaults(7)(REG_TRIG_CTRL_INVERT_VFAT5_TU_INVERT_MSB downto REG_TRIG_CTRL_INVERT_VFAT5_TU_INVERT_LSB) <= REG_TRIG_CTRL_INVERT_VFAT5_TU_INVERT_DEFAULT;
    regs_defaults(7)(REG_TRIG_CTRL_INVERT_VFAT6_TU_INVERT_MSB downto REG_TRIG_CTRL_INVERT_VFAT6_TU_INVERT_LSB) <= REG_TRIG_CTRL_INVERT_VFAT6_TU_INVERT_DEFAULT;
    regs_defaults(7)(REG_TRIG_CTRL_INVERT_VFAT7_TU_INVERT_MSB downto REG_TRIG_CTRL_INVERT_VFAT7_TU_INVERT_LSB) <= REG_TRIG_CTRL_INVERT_VFAT7_TU_INVERT_DEFAULT;
    regs_defaults(8)(REG_TRIG_CTRL_INVERT_VFAT8_TU_INVERT_MSB downto REG_TRIG_CTRL_INVERT_VFAT8_TU_INVERT_LSB) <= REG_TRIG_CTRL_INVERT_VFAT8_TU_INVERT_DEFAULT;
    regs_defaults(8)(REG_TRIG_CTRL_INVERT_VFAT9_TU_INVERT_MSB downto REG_TRIG_CTRL_INVERT_VFAT9_TU_INVERT_LSB) <= REG_TRIG_CTRL_INVERT_VFAT9_TU_INVERT_DEFAULT;
    regs_defaults(8)(REG_TRIG_CTRL_INVERT_VFAT10_TU_INVERT_MSB downto REG_TRIG_CTRL_INVERT_VFAT10_TU_INVERT_LSB) <= REG_TRIG_CTRL_INVERT_VFAT10_TU_INVERT_DEFAULT;
    regs_defaults(8)(REG_TRIG_CTRL_INVERT_VFAT11_TU_INVERT_MSB downto REG_TRIG_CTRL_INVERT_VFAT11_TU_INVERT_LSB) <= REG_TRIG_CTRL_INVERT_VFAT11_TU_INVERT_DEFAULT;
    regs_defaults(9)(REG_TRIG_CTRL_SBITS_MUX_SBIT_MUX_SEL_MSB downto REG_TRIG_CTRL_SBITS_MUX_SBIT_MUX_SEL_LSB) <= REG_TRIG_CTRL_SBITS_MUX_SBIT_MUX_SEL_DEFAULT;
    regs_defaults(12)(REG_TRIG_CTRL_TU_MASK_VFAT0_TU_MASK_MSB downto REG_TRIG_CTRL_TU_MASK_VFAT0_TU_MASK_LSB) <= REG_TRIG_CTRL_TU_MASK_VFAT0_TU_MASK_DEFAULT;
    regs_defaults(12)(REG_TRIG_CTRL_TU_MASK_VFAT1_TU_MASK_MSB downto REG_TRIG_CTRL_TU_MASK_VFAT1_TU_MASK_LSB) <= REG_TRIG_CTRL_TU_MASK_VFAT1_TU_MASK_DEFAULT;
    regs_defaults(12)(REG_TRIG_CTRL_TU_MASK_VFAT2_TU_MASK_MSB downto REG_TRIG_CTRL_TU_MASK_VFAT2_TU_MASK_LSB) <= REG_TRIG_CTRL_TU_MASK_VFAT2_TU_MASK_DEFAULT;
    regs_defaults(12)(REG_TRIG_CTRL_TU_MASK_VFAT3_TU_MASK_MSB downto REG_TRIG_CTRL_TU_MASK_VFAT3_TU_MASK_LSB) <= REG_TRIG_CTRL_TU_MASK_VFAT3_TU_MASK_DEFAULT;
    regs_defaults(13)(REG_TRIG_CTRL_TU_MASK_VFAT4_TU_MASK_MSB downto REG_TRIG_CTRL_TU_MASK_VFAT4_TU_MASK_LSB) <= REG_TRIG_CTRL_TU_MASK_VFAT4_TU_MASK_DEFAULT;
    regs_defaults(13)(REG_TRIG_CTRL_TU_MASK_VFAT5_TU_MASK_MSB downto REG_TRIG_CTRL_TU_MASK_VFAT5_TU_MASK_LSB) <= REG_TRIG_CTRL_TU_MASK_VFAT5_TU_MASK_DEFAULT;
    regs_defaults(13)(REG_TRIG_CTRL_TU_MASK_VFAT6_TU_MASK_MSB downto REG_TRIG_CTRL_TU_MASK_VFAT6_TU_MASK_LSB) <= REG_TRIG_CTRL_TU_MASK_VFAT6_TU_MASK_DEFAULT;
    regs_defaults(13)(REG_TRIG_CTRL_TU_MASK_VFAT7_TU_MASK_MSB downto REG_TRIG_CTRL_TU_MASK_VFAT7_TU_MASK_LSB) <= REG_TRIG_CTRL_TU_MASK_VFAT7_TU_MASK_DEFAULT;
    regs_defaults(14)(REG_TRIG_CTRL_TU_MASK_VFAT8_TU_MASK_MSB downto REG_TRIG_CTRL_TU_MASK_VFAT8_TU_MASK_LSB) <= REG_TRIG_CTRL_TU_MASK_VFAT8_TU_MASK_DEFAULT;
    regs_defaults(14)(REG_TRIG_CTRL_TU_MASK_VFAT9_TU_MASK_MSB downto REG_TRIG_CTRL_TU_MASK_VFAT9_TU_MASK_LSB) <= REG_TRIG_CTRL_TU_MASK_VFAT9_TU_MASK_DEFAULT;
    regs_defaults(14)(REG_TRIG_CTRL_TU_MASK_VFAT10_TU_MASK_MSB downto REG_TRIG_CTRL_TU_MASK_VFAT10_TU_MASK_LSB) <= REG_TRIG_CTRL_TU_MASK_VFAT10_TU_MASK_DEFAULT;
    regs_defaults(14)(REG_TRIG_CTRL_TU_MASK_VFAT11_TU_MASK_MSB downto REG_TRIG_CTRL_TU_MASK_VFAT11_TU_MASK_LSB) <= REG_TRIG_CTRL_TU_MASK_VFAT11_TU_MASK_DEFAULT;
    regs_defaults(28)(REG_TRIG_CNT_SBIT_CNT_PERSIST_BIT) <= REG_TRIG_CNT_SBIT_CNT_PERSIST_DEFAULT;
    regs_defaults(29)(REG_TRIG_CNT_SBIT_CNT_TIME_MAX_MSB downto REG_TRIG_CNT_SBIT_CNT_TIME_MAX_LSB) <= REG_TRIG_CNT_SBIT_CNT_TIME_MAX_DEFAULT;
    regs_defaults(43)(REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT0_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT0_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT0_DEFAULT;
    regs_defaults(43)(REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT1_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT1_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT1_DEFAULT;
    regs_defaults(43)(REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT2_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT2_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT2_DEFAULT;
    regs_defaults(43)(REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT3_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT3_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT3_DEFAULT;
    regs_defaults(43)(REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT4_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT4_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT4_DEFAULT;
    regs_defaults(43)(REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT5_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT5_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT5_DEFAULT;
    regs_defaults(44)(REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT6_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT6_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT6_DEFAULT;
    regs_defaults(44)(REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT7_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT7_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT7_DEFAULT;
    regs_defaults(44)(REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT0_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT0_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT0_DEFAULT;
    regs_defaults(44)(REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT1_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT1_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT1_DEFAULT;
    regs_defaults(44)(REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT2_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT2_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT2_DEFAULT;
    regs_defaults(44)(REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT3_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT3_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT3_DEFAULT;
    regs_defaults(45)(REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT4_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT4_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT4_DEFAULT;
    regs_defaults(45)(REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT5_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT5_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT5_DEFAULT;
    regs_defaults(45)(REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT6_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT6_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT6_DEFAULT;
    regs_defaults(45)(REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT7_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT7_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT7_DEFAULT;
    regs_defaults(45)(REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT0_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT0_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT0_DEFAULT;
    regs_defaults(45)(REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT1_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT1_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT1_DEFAULT;
    regs_defaults(46)(REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT2_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT2_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT2_DEFAULT;
    regs_defaults(46)(REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT3_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT3_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT3_DEFAULT;
    regs_defaults(46)(REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT4_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT4_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT4_DEFAULT;
    regs_defaults(46)(REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT5_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT5_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT5_DEFAULT;
    regs_defaults(46)(REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT6_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT6_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT6_DEFAULT;
    regs_defaults(46)(REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT7_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT7_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT7_DEFAULT;
    regs_defaults(47)(REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT0_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT0_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT0_DEFAULT;
    regs_defaults(47)(REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT1_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT1_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT1_DEFAULT;
    regs_defaults(47)(REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT2_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT2_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT2_DEFAULT;
    regs_defaults(47)(REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT3_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT3_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT3_DEFAULT;
    regs_defaults(47)(REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT4_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT4_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT4_DEFAULT;
    regs_defaults(47)(REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT5_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT5_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT5_DEFAULT;
    regs_defaults(48)(REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT6_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT6_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT6_DEFAULT;
    regs_defaults(48)(REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT7_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT7_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT7_DEFAULT;
    regs_defaults(48)(REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT0_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT0_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT0_DEFAULT;
    regs_defaults(48)(REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT1_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT1_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT1_DEFAULT;
    regs_defaults(48)(REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT2_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT2_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT2_DEFAULT;
    regs_defaults(48)(REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT3_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT3_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT3_DEFAULT;
    regs_defaults(49)(REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT4_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT4_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT4_DEFAULT;
    regs_defaults(49)(REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT5_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT5_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT5_DEFAULT;
    regs_defaults(49)(REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT6_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT6_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT6_DEFAULT;
    regs_defaults(49)(REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT7_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT7_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT7_DEFAULT;
    regs_defaults(49)(REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT0_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT0_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT0_DEFAULT;
    regs_defaults(49)(REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT1_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT1_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT1_DEFAULT;
    regs_defaults(50)(REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT2_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT2_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT2_DEFAULT;
    regs_defaults(50)(REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT3_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT3_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT3_DEFAULT;
    regs_defaults(50)(REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT4_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT4_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT4_DEFAULT;
    regs_defaults(50)(REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT5_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT5_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT5_DEFAULT;
    regs_defaults(50)(REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT6_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT6_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT6_DEFAULT;
    regs_defaults(50)(REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT7_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT7_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT7_DEFAULT;
    regs_defaults(51)(REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT0_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT0_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT0_DEFAULT;
    regs_defaults(51)(REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT1_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT1_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT1_DEFAULT;
    regs_defaults(51)(REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT2_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT2_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT2_DEFAULT;
    regs_defaults(51)(REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT3_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT3_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT3_DEFAULT;
    regs_defaults(51)(REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT4_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT4_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT4_DEFAULT;
    regs_defaults(51)(REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT5_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT5_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT5_DEFAULT;
    regs_defaults(52)(REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT6_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT6_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT6_DEFAULT;
    regs_defaults(52)(REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT7_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT7_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT7_DEFAULT;
    regs_defaults(52)(REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT0_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT0_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT0_DEFAULT;
    regs_defaults(52)(REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT1_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT1_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT1_DEFAULT;
    regs_defaults(52)(REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT2_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT2_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT2_DEFAULT;
    regs_defaults(52)(REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT3_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT3_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT3_DEFAULT;
    regs_defaults(53)(REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT4_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT4_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT4_DEFAULT;
    regs_defaults(53)(REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT5_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT5_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT5_DEFAULT;
    regs_defaults(53)(REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT6_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT6_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT6_DEFAULT;
    regs_defaults(53)(REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT7_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT7_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT7_DEFAULT;
    regs_defaults(53)(REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT0_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT0_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT0_DEFAULT;
    regs_defaults(53)(REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT1_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT1_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT1_DEFAULT;
    regs_defaults(54)(REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT2_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT2_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT2_DEFAULT;
    regs_defaults(54)(REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT3_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT3_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT3_DEFAULT;
    regs_defaults(54)(REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT4_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT4_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT4_DEFAULT;
    regs_defaults(54)(REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT5_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT5_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT5_DEFAULT;
    regs_defaults(54)(REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT6_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT6_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT6_DEFAULT;
    regs_defaults(54)(REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT7_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT7_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT7_DEFAULT;
    regs_defaults(55)(REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT0_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT0_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT0_DEFAULT;
    regs_defaults(55)(REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT1_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT1_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT1_DEFAULT;
    regs_defaults(55)(REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT2_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT2_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT2_DEFAULT;
    regs_defaults(55)(REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT3_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT3_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT3_DEFAULT;
    regs_defaults(55)(REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT4_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT4_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT4_DEFAULT;
    regs_defaults(55)(REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT5_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT5_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT5_DEFAULT;
    regs_defaults(56)(REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT6_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT6_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT6_DEFAULT;
    regs_defaults(56)(REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT7_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT7_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT7_DEFAULT;
    regs_defaults(56)(REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT0_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT0_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT0_DEFAULT;
    regs_defaults(56)(REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT1_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT1_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT1_DEFAULT;
    regs_defaults(56)(REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT2_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT2_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT2_DEFAULT;
    regs_defaults(56)(REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT3_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT3_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT3_DEFAULT;
    regs_defaults(57)(REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT4_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT4_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT4_DEFAULT;
    regs_defaults(57)(REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT5_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT5_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT5_DEFAULT;
    regs_defaults(57)(REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT6_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT6_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT6_DEFAULT;
    regs_defaults(57)(REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT7_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT7_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT7_DEFAULT;
    regs_defaults(57)(REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT0_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT0_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT0_DEFAULT;
    regs_defaults(57)(REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT1_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT1_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT1_DEFAULT;
    regs_defaults(58)(REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT2_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT2_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT2_DEFAULT;
    regs_defaults(58)(REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT3_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT3_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT3_DEFAULT;
    regs_defaults(58)(REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT4_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT4_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT4_DEFAULT;
    regs_defaults(58)(REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT5_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT5_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT5_DEFAULT;
    regs_defaults(58)(REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT6_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT6_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT6_DEFAULT;
    regs_defaults(58)(REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT7_MSB downto REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT7_LSB) <= REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT7_DEFAULT;
    regs_defaults(59)(REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT0_MSB downto REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT0_LSB) <= REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT0_DEFAULT;
    regs_defaults(59)(REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT1_MSB downto REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT1_LSB) <= REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT1_DEFAULT;
    regs_defaults(59)(REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT2_MSB downto REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT2_LSB) <= REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT2_DEFAULT;
    regs_defaults(59)(REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT3_MSB downto REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT3_LSB) <= REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT3_DEFAULT;
    regs_defaults(59)(REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT4_MSB downto REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT4_LSB) <= REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT4_DEFAULT;
    regs_defaults(59)(REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT5_MSB downto REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT5_LSB) <= REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT5_DEFAULT;
    regs_defaults(60)(REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT6_MSB downto REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT6_LSB) <= REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT6_DEFAULT;
    regs_defaults(60)(REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT7_MSB downto REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT7_LSB) <= REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT7_DEFAULT;
    regs_defaults(60)(REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT8_MSB downto REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT8_LSB) <= REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT8_DEFAULT;
    regs_defaults(60)(REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT9_MSB downto REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT9_LSB) <= REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT9_DEFAULT;
    regs_defaults(60)(REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT10_MSB downto REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT10_LSB) <= REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT10_DEFAULT;
    regs_defaults(60)(REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT11_MSB downto REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT11_LSB) <= REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT11_DEFAULT;
    regs_defaults(62)(REG_TRIG_LINKS_TX_PRBS_MODE_MSB downto REG_TRIG_LINKS_TX_PRBS_MODE_LSB) <= REG_TRIG_LINKS_TX_PRBS_MODE_DEFAULT;
    regs_defaults(62)(REG_TRIG_LINKS_TX_PLL_RESET_BIT) <= REG_TRIG_LINKS_TX_PLL_RESET_DEFAULT;
    regs_defaults(62)(REG_TRIG_LINKS_MGT_RESET_MSB downto REG_TRIG_LINKS_MGT_RESET_LSB) <= REG_TRIG_LINKS_MGT_RESET_DEFAULT;
    regs_defaults(62)(REG_TRIG_LINKS_GTXTEST_START_BIT) <= REG_TRIG_LINKS_GTXTEST_START_DEFAULT;
    regs_defaults(62)(REG_TRIG_LINKS_TXRESET_BIT) <= REG_TRIG_LINKS_TXRESET_DEFAULT;
    regs_defaults(62)(REG_TRIG_LINKS_MGT_REALIGN_BIT) <= REG_TRIG_LINKS_MGT_REALIGN_DEFAULT;
    regs_defaults(62)(REG_TRIG_LINKS_TXPOWERDOWN_BIT) <= REG_TRIG_LINKS_TXPOWERDOWN_DEFAULT;
    regs_defaults(62)(REG_TRIG_LINKS_TXPOWERDOWN_MODE_MSB downto REG_TRIG_LINKS_TXPOWERDOWN_MODE_LSB) <= REG_TRIG_LINKS_TXPOWERDOWN_MODE_DEFAULT;
    regs_defaults(62)(REG_TRIG_LINKS_TXPLLPOWERDOWN_BIT) <= REG_TRIG_LINKS_TXPLLPOWERDOWN_DEFAULT;
    regs_defaults(62)(REG_TRIG_LINKS_FORCE_NOT_READY_BIT) <= REG_TRIG_LINKS_FORCE_NOT_READY_DEFAULT;
    regs_defaults(74)(REG_TRIG_SBIT_HITMAP_ACQUIRE_BIT) <= REG_TRIG_SBIT_HITMAP_ACQUIRE_DEFAULT;

    -- Define writable regs
    regs_writable_arr(0) <= '1';
    regs_writable_arr(2) <= '1';
    regs_writable_arr(5) <= '1';
    regs_writable_arr(6) <= '1';
    regs_writable_arr(7) <= '1';
    regs_writable_arr(8) <= '1';
    regs_writable_arr(9) <= '1';
    regs_writable_arr(12) <= '1';
    regs_writable_arr(13) <= '1';
    regs_writable_arr(14) <= '1';
    regs_writable_arr(28) <= '1';
    regs_writable_arr(29) <= '1';
    regs_writable_arr(43) <= '1';
    regs_writable_arr(44) <= '1';
    regs_writable_arr(45) <= '1';
    regs_writable_arr(46) <= '1';
    regs_writable_arr(47) <= '1';
    regs_writable_arr(48) <= '1';
    regs_writable_arr(49) <= '1';
    regs_writable_arr(50) <= '1';
    regs_writable_arr(51) <= '1';
    regs_writable_arr(52) <= '1';
    regs_writable_arr(53) <= '1';
    regs_writable_arr(54) <= '1';
    regs_writable_arr(55) <= '1';
    regs_writable_arr(56) <= '1';
    regs_writable_arr(57) <= '1';
    regs_writable_arr(58) <= '1';
    regs_writable_arr(59) <= '1';
    regs_writable_arr(60) <= '1';
    regs_writable_arr(62) <= '1';
    regs_writable_arr(74) <= '1';

    --==== Registers end ============================================================================

end Behavioral;
