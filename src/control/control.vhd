----------------------------------------------------------------------------------
-- CMS Muon Endcap
-- GEM Collaboration
-- Optohybrid v3 Firmware -- Control
-- A. Peck
----------------------------------------------------------------------------------
-- 2017/07/25 -- Initial. Wrapper around OH control modules
-- 2017/07/25 -- Clear many synthesis warnings from module
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;

use IEEE.Numeric_STD.all;

library work;
use work.types_pkg.all;
use work.wb_pkg.all;

entity control is
port(


    --== TTC ==--

    clock_i     : in std_logic;
    gbt_clock_i : in std_logic;
    reset_i     : in std_logic;

    ttc_l1a    : in std_logic;
    ttc_bc0    : in std_logic;
    ttc_resync : in std_logic;

    wb_m_req_i : in  wb_req_array_t((WB_MASTERS - 1) downto 0);
    wb_m_res_o : out wb_res_array_t((WB_MASTERS - 1) downto 0);

    -------------------
    -- status inputs --
    -------------------

    -- MMCM
    mmcms_locked_i     : in std_logic;
    dskw_mmcm_locked_i : in std_logic;
    eprt_mmcm_locked_i : in std_logic;

    -- SEM
    sem_critical_i : in std_logic;

    -- GBT

    gbt_rxready_i : in std_logic;
    gbt_rxvalid_i : in std_logic;
    gbt_txready_i : in std_logic;

    -- Trigger

    active_vfats_i  : in std_logic_vector (23 downto 0);
    sbit_overflow_i : in std_logic;
    cluster_count_i : in std_logic_vector (7 downto 0);

    -- GBT
    gbt_link_error_i : in std_logic;

    -- SEM
    sem_correction_i    : in std_logic;

    -- Analog input
    adc_vp         : in  std_logic;
    adc_vn         : in  std_logic;

    --------------------
    -- config outputs --
    --------------------

    -- VFAT
    vfat_reset_o       : out std_logic;
    sbit_mask_o        : out std_logic_vector(23 downto 0);
    trigger_deadtime_o : out std_logic_vector(3 downto 0);
    ext_sbits_o        : out std_logic_vector(5 downto 0);

    -- LEDs
    led_o              : out std_logic_vector(15 downto 0);


    -------------
    -- outputs --
    -------------

    trig_stop_o   : out std_logic;
    bxn_counter_o : out std_logic_vector (11 downto 0);

    -----------
    -- sump  --
    -----------

    sump_o : out std_logic

);

end control;

architecture Behavioral of control is

    --== Sbits ==--

    signal sys_sbit_sel  : std_logic_vector(29 downto 0);
    signal sys_sbit_mode : std_logic_vector(1  downto 0);
    signal sys_loop_sbit : std_logic_vector(4  downto 0);
    signal cluster_rate  : std_logic_vector(31  downto 0);

    --== TTC FMM ==--

    signal fmm_ignore_startstop : std_logic;
    signal fmm_force_stop       : std_logic;
    signal fmm_dont_wait        : std_logic;

    --== TTC Sync ==--

    signal ttc_bxn_offset      : std_logic_vector (11 downto 0);
    signal ttc_orbit_counter   : std_logic_vector (31 downto 0);
    signal ttc_bxn_counter     : std_logic_vector (11 downto 0);
    signal ttc_bx0_counter_lcl : std_logic_vector (31 downto 0); -- bc0 counter local    bc0s
    signal ttc_bx0_counter_rxd : std_logic_vector (31 downto 0); -- bc0 counter received bc0s

    signal bx0_sync_err      : std_logic;
    signal bxn_sync_err      : std_logic;

    --== ADC ==--

    signal overtemp       : std_logic;
    signal vccaux_alarm   : std_logic;
    signal vccint_alarm   : std_logic;

    --== Wishbone ==--

    signal wb_m_res : wb_res_array_t((WB_MASTERS- 1) downto 0);

    signal wb_s_req : wb_req_array_t((WB_SLAVES - 1) downto 0);
    signal wb_s_res : wb_res_array_t((WB_SLAVES - 1) downto 0);

    signal wb_sump : std_logic;
    signal sys_sump : std_logic;
    signal stat_sump : std_logic;
    signal loop_sump : std_logic;
    signal counters_sump : std_logic;

    signal reset : std_logic;

begin

    process (clock_i) begin
        if (rising_edge(clock_i)) then
            reset <= reset_i;
        end if;
    end process;


    wb_m_res_o  <= wb_m_res;

    --=====================--
    --== Wishbone switch ==--
    --=====================--

    -- This module is the Wishbone switch which redirects requests from the masters to the slaves.

    wb_switch_inst : entity work.wb_switch
    port map(
        ref_clk_i   => clock_i,
        reset_i     => reset,

        wb_req_i    => wb_m_req_i,
        wb_req_o    => wb_s_req,

        wb_res_i    => wb_s_res,
        wb_res_o    => wb_m_res
    );

    --===================--
    --== Configuration ==--
    --===================--

    sys_inst : entity work.sys
    port map(
        ref_clk_i           => clock_i,
        reset_i             => reset,

        wb_slv_req_i        => wb_s_req(WB_SLV_SYS),
        wb_slv_res_o        => wb_s_res(WB_SLV_SYS),

        -- sbit control
        vfat_reset_o            => vfat_reset_o,
        vfat_sbit_mask_o        => sbit_mask_o,
        vfat_trigger_deadtime_o => trigger_deadtime_o,

        -- hdmi control
        sys_loop_sbit_o     => sys_loop_sbit,
        sys_sbit_sel_o      => sys_sbit_sel,
        sys_sbit_mode_o     => sys_sbit_mode,

        -- fmm control
        fmm_ignore_startstop_o => fmm_ignore_startstop,
        fmm_force_stop_o       => fmm_force_stop,
        fmm_dont_wait_o        => fmm_dont_wait,

        -- ttc control
        ttc_bxn_offset_o       => ttc_bxn_offset,

        --sem_critical_i      => sem_critical
        sump_o              => sys_sump
    );

    --============--
    --== Status ==--
    --============--

    -- This module holds the status registers that describe the state of the OH.

    stat_inst : entity work.stat
    port map(
        ref_clk_i           => clock_i,
        reset_i             => reset,
        wb_slv_req_i        => wb_s_req(WB_SLV_STAT),
        wb_slv_res_o        => wb_s_res(WB_SLV_STAT),

        -- gbt
        gbt_rxready_i       => gbt_rxready_i,
        gbt_rxvalid_i       => gbt_rxvalid_i,
        gbt_txready_i       => gbt_txready_i,

        -- mmcms
        mmcms_locked_i      => mmcms_locked_i,
        dskw_mmcm_locked_i  => dskw_mmcm_locked_i,
        eprt_mmcm_locked_i  => eprt_mmcm_locked_i,

        -- sbits

        cluster_rate_i      => cluster_rate,

        -- sem

        sem_critical_i      => sem_critical_i,

        -- ttc

        ttc_bxn_counter_i     => ttc_bxn_counter,
        ttc_bx0_counter_lcl_i => ttc_bx0_counter_lcl,
        ttc_bx0_counter_rxd_i => ttc_bx0_counter_rxd,
        ttc_orbit_counter_i   => ttc_orbit_counter,
        ttc_bx0_sync_err      => bx0_sync_err,
        ttc_bxn_sync_err      => bxn_sync_err,

        sump_o                => stat_sump
    );

    --==============--
    --== Counters ==--
    --==============--

    -- This module implements a multitude of counters.

    counters_inst : entity work.counters
    port map(
        clock               => clock_i,
        reset_i             => reset,

        -- wishbone
        wb_slv_req_i        => wb_s_req(WB_SLV_CNT),
        wb_slv_res_o        => wb_s_res(WB_SLV_CNT),
        wb_m_req_i          => wb_m_req_i,
        wb_m_res_i          => wb_m_res,
        wb_s_req_i          => wb_s_req,
        wb_s_res_i          => wb_s_res,

        ttc_l1a             => ttc_l1a,
        ttc_bc0             => ttc_bc0,
        ttc_resync          => ttc_resync,

        sbit_overflow_i     => sbit_overflow_i,

        active_vfats_i      => active_vfats_i,

        gbt_link_error_i    => gbt_link_error_i,

        mmcms_locked_i      => mmcms_locked_i,
        eprt_mmcm_locked_i  => eprt_mmcm_locked_i,
        dskw_mmcm_locked_i  => dskw_mmcm_locked_i,

        sem_correction_i    => sem_correction_i,

        sump_o              => counters_sump
    );

    --==============--
    --== Loopback ==--
    --==============--

    loop_inst : entity work.loopback
    port map(
        ref_clk_i           => clock_i,
        reset_i             => reset,
        wb_slv_req_i        => wb_s_req(WB_SLV_LOOP),
        wb_slv_res_o        => wb_s_res(WB_SLV_LOOP),

        sump_o              => loop_sump
    );

    --==========--
    --== LEDS ==--
    --==========--

    led_control : entity work.led_control
    port map (
        -- reset
        reset         => reset,

        -- clocks
        clock         => clock_i,
        gbt_eclk      => gbt_clock_i,

        -- signals
        mmcm_locked          => mmcms_locked_i,
        gbt_rxready          => gbt_rxready_i,
        gbt_rxvalid          => gbt_rxvalid_i,
        gbt_request_received => wb_m_req_i(0).stb,
        cluster_count        => cluster_count_i,

        cluster_rate  => cluster_rate,

        -- led outputs
        led_out       => led_o
    );


    --======================--
    --== External signals ==--
    --======================--

    -- This module handles the external signals: the input trigger and the output SBits.

    external_inst : entity work.external
    port map(
        clock               => clock_i,

        reset_i             => reset,

        active_vfats_i      => active_vfats_i,

        sys_sbit_mode_i     => sys_sbit_mode,
        sys_sbit_sel_i      => sys_sbit_sel,
        ext_sbits_o         => ext_sbits_o
    );


    --=================--
    --== TTC Sync    ==--
    --=================--

    ttc_inst : entity work.ttc

    port map (

        -- clock & reset
        clock => clock_i,
        reset => reset,

        -- ttc commands
        ttc_bx0    => ttc_bc0,
        ttc_resync => ttc_resync,

        -- control
        bxn_offset => ttc_bxn_offset,

        -- output
       orbit_counter   => ttc_orbit_counter,
       bxn_counter     => ttc_bxn_counter,
       bx0_counter_lcl => ttc_bx0_counter_lcl,
       bx0_counter_rxd => ttc_bx0_counter_rxd,
       bx0_sync_err    => bx0_sync_err,
       bxn_sync_err    => bxn_sync_err

    );

    bxn_counter_o   <= ttc_bxn_counter;

    --=================--
    --== Trigger FMM ==--
    --=================--

    fmm_inst : entity work.fmm
    port map (

        -- clock & reset
        clock   => clock_i,
        reset_i => reset,

        -- ttc commands
        ttc_bx0    => ttc_bc0,
        ttc_resync => ttc_resync,

        -- control
        ignore_startstop   => fmm_ignore_startstop,
        force_stop_trigger => fmm_force_stop,
        dont_wait          => fmm_dont_wait,

        -- output
        fmm_trig_stop => trig_stop_o

    );

    --====================--
    --== System Monitor ==--
    --====================--

    adc_inst : entity work.adc port map(
        ref_clk_i       => clock_i,
        reset_i         => reset,
        wb_slv_req_i    => wb_s_req (WB_SLV_ADC),
        wb_slv_res_o    => wb_s_res (WB_SLV_ADC),
        overtemp_o      => overtemp,
        vccaux_alarm_o  => vccaux_alarm,
        vccint_alarm_o  => vccint_alarm,
        adc_vp          => adc_vp,
        adc_vn          => adc_vn
    );

    --=============--
    --== Sump    ==--
    --=============--

    wb_sump <=  -- master
                   or_reduce(wb_m_req_i(0).addr) or or_reduce(wb_m_req_i(0).data) or wb_m_req_i(0).we
                or or_reduce(wb_m_res(0).stat) or or_reduce(wb_m_res(0).data)

                -- slaves
                or or_reduce(wb_s_req(0).data) or or_reduce(wb_s_req(1).data) or or_reduce(wb_s_req(2).data)
                or or_reduce(wb_s_req(0).addr) or or_reduce(wb_s_req(1).addr) or or_reduce(wb_s_req(2).addr)
                or or_reduce(wb_s_res(0).stat) or or_reduce(wb_s_res(1).stat) or or_reduce(wb_s_res(2).stat)
                or or_reduce(wb_s_res(0).data) or or_reduce(wb_s_res(1).data) or or_reduce(wb_s_res(2).data)
                or wb_s_req(0).we or wb_s_req(1).we or wb_s_req(2).we;

    sump_o <= wb_sump or sys_sump or stat_sump or counters_sump or loop_sump;

end Behavioral;
