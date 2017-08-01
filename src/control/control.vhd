----------------------------------------------------------------------------------
-- CMS Muon Endcap
-- GEM Collaboration
-- Optohybrid v3 Firmware -- Counters
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
    gbt_txvalid_i : in std_logic;

    -- Trigger

    active_vfats_i  : in std_logic_vector (23 downto 0);
    sbit_overflow_i : in std_logic;
    cluster_count_i : in std_logic_vector (7 downto 0);

    -- GBT
    gbt_link_error_i : in std_logic;

    -- SEM
    sem_correction_i    : in std_logic;

    --------------------
    -- config outputs --
    --------------------

    -- VFAT
    vfat_reset_o       : out std_logic;
    sbit_mask_o   : out std_logic_vector(23 downto 0);
    ext_sbits_o         : out std_logic_vector(5 downto 0);

    -- LEDs
    led_o              : out std_logic_vector(15 downto 0);

    -- sump

    sump_o : out std_logic

);

end control;

architecture Behavioral of control is

    --== Sbits ==--

    signal sbit_mask : std_logic_vector (23 downto 0);
    signal sys_sbit_sel   : std_logic_vector(29 downto 0);
    signal sys_sbit_mode  : std_logic_vector(1  downto 0);
    signal sys_loop_sbit  : std_logic_vector(4  downto 0);
    signal cluster_rate  : std_logic_vector(31  downto 0);

    --== Wishbone ==--

    signal wb_m_res : wb_res_array_t((WB_MASTERS- 1) downto 0);

    signal wb_s_req : wb_req_array_t((WB_SLAVES - 1) downto 0);
    signal wb_s_res : wb_res_array_t((WB_SLAVES - 1) downto 0);

    signal wb_sump : std_logic;
    signal sys_sump : std_logic;
    signal stat_sump : std_logic;
    signal loop_sump : std_logic;
    signal counters_sump : std_logic;

begin

    sbit_mask_o <= sbit_mask;

    wb_m_res_o  <= wb_m_res;
    --=====================--
    --== Wishbone switch ==--
    --=====================--

    -- This module is the Wishbone switch which redirects requests from the masters to the slaves.

    wb_switch_inst : entity work.wb_switch
    port map(
        ref_clk_i   => clock_i,
        reset_i     => reset_i,

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
        reset_i             => reset_i,

        wb_slv_req_i        => wb_s_req(WB_SLV_SYS),
        wb_slv_res_o        => wb_s_res(WB_SLV_SYS),

        vfat_reset_o        => vfat_reset_o,
        vfat_sbit_mask_o    => sbit_mask,
        sys_loop_sbit_o     => sys_loop_sbit,
        sys_sbit_sel_o      => sys_sbit_sel,
        sys_sbit_mode_o     => sys_sbit_mode,


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
        reset_i             => reset_i,
        wb_slv_req_i        => wb_s_req(WB_SLV_STAT),
        wb_slv_res_o        => wb_s_res(WB_SLV_STAT),

        -- gbt
        gbt_rxready_i       => gbt_rxready_i,
        gbt_rxvalid_i       => gbt_rxvalid_i,
        gbt_txready_i       => gbt_txready_i,
        gbt_txvalid_i       => gbt_txvalid_i,

        -- mmcms
        mmcms_locked_i      => mmcms_locked_i,
        dskw_mmcm_locked_i  => dskw_mmcm_locked_i,
        eprt_mmcm_locked_i  => eprt_mmcm_locked_i,

        -- sbits

        cluster_rate_i      => cluster_rate,
        -- sem

        sem_critical_i      => sem_critical_i,

        sump_o              => stat_sump
    );

    --==============--
    --== Counters ==--
    --==============--

    -- This module implements a multitude of counters.

    counters_inst : entity work.counters
    port map(
        clock               => clock_i,
        reset_i             => reset_i,

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
        reset_i             => reset_i,
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
        reset         => reset_i,

        -- clocks
        clock         => clock_i,
        gbt_eclk      => gbt_clock_i,

        -- signals
        mmcm_locked   => mmcms_locked_i,
        gbt_rxready   => gbt_rxready_i,
        gbt_rxvalid   => gbt_rxvalid_i,
        cluster_count => cluster_count_i,

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

        active_vfats_i      => active_vfats_i,

        sys_sbit_mode_i     => sys_sbit_mode,
        sys_sbit_sel_i      => sys_sbit_sel,
        ext_sbits_o         => ext_sbits_o
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
