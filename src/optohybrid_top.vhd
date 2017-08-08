----------------------------------------------------------------------------------
-- CMS Muon Endcap
-- GEM Collaboration
-- Optohybrid v3 Firmware -- Top Logic
-- T. Lenzi, E. Juska, A. Peck
----------------------------------------------------------------------------------
-- 2017/07/21 -- Initial port to version 3 electronics
-- 2017/07/22 -- Additional MMCM added to monitor and dejitter the eport clock
-- 2017/07/25 -- Restructure top level module to improve organization
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

use ieee.numeric_std.all;

library work;
use work.types_pkg.all;
use work.wb_pkg.all;

entity optohybrid_top is
port(

    --== Memory ==--

--    multiboot_rs_o          : out std_logic_vector(1 downto 0);

--    flash_address_o         : out std_logic_vector(22 downto 0);
--    flash_data_io           : inout std_logic_vector(15 downto 0);
--    flash_chip_enable_b_o   : out std_logic;
--    flash_out_enable_b_o    : out std_logic;
--    flash_write_enable_b_o  : out std_logic;
--    flash_latch_enable_b_o  : out std_logic;

    --== Clocking ==--

 -- gbt_eclk_p  : in std_logic_vector (1 downto 0) ;
 -- gbt_eclk_n  : in std_logic_vector (1 downto 0) ;

    gbt_dclk_p : in std_logic_vector (1 downto 0) ;
    gbt_dclk_n : in std_logic_vector (1 downto 0) ;

    --== Miscellaneous ==--

    elink_i_p : in  std_logic_vector (1 downto 0) ;
    elink_i_n : in  std_logic_vector (1 downto 0) ;

    elink_o_p : out std_logic_vector (1 downto 0) ;
    elink_o_n : out std_logic_vector (1 downto 0) ;

    sca_io  : in  std_logic_vector (3 downto 0); -- set as input for now

    hdmi_p  : in  std_logic_vector (3 downto 0); -- set as input for now
    hdmi_n  : in  std_logic_vector (3 downto 0); -- set as input for now

    led_o   : out std_logic_vector (15 downto 0);

    -- gbt_txvalid_o : out std_logic;
    gbt_txready_i : in std_logic;

    gbt_rxvalid_i : in std_logic;
    gbt_rxready_i : in std_logic;

    ext_reset_o : out std_logic_vector (11 downto 0);

    --== VFAT Mezzanine ==--


    --== GTX ==--

    mgt_clk_p_i : in std_logic_vector (1 downto 0);
    mgt_clk_n_i : in std_logic_vector (1 downto 0);

    mgt_tx_p_o  : out std_logic_vector(3 downto 0);
    mgt_tx_n_o  : out std_logic_vector(3 downto 0);

    --== VFAT Trigger Data ==--

    vfat_sof_p     : in std_logic_vector (23 downto 0);
    vfat_sof_n     : in std_logic_vector (23 downto 0);

    vfat_sbits_p : in std_logic_vector (191 downto 0);
    vfat_sbits_n : in std_logic_vector (191 downto 0)

);
end optohybrid_top;

architecture Behavioral of optohybrid_top is

    --== SBit cluster packer ==--

    signal sbit_overflow : std_logic;
    signal cluster_count : std_logic_vector     (7  downto 0);
    signal active_vfats  : std_logic_vector     (23 downto 0);

    --== Global signals ==--

    signal mmcms_locked     : std_logic;
    signal dskw_mmcm_locked : std_logic;
    signal eprt_mmcm_locked : std_logic;

    signal clock            : std_logic;

    signal gbt_clk1x        : std_logic;
    signal gbt_clk8x        : std_logic;

    signal clk_1x           : std_logic;
    signal clk_2x           : std_logic;
    signal clk_4x           : std_logic;
    signal clk_4x_90        : std_logic;

    signal delay_refclk     : std_logic;

    signal gbt_txvalid      : std_logic;
    signal gbt_txready      : std_logic;
    signal gbt_rxvalid      : std_logic;
    signal gbt_rxready      : std_logic;

    signal gbt_link_error   : std_logic;

    signal mgt_refclk       : std_logic;
    signal reset            : std_logic;

    signal clock_source     : std_logic;

    signal ttc_resync       : std_logic;
    signal ttc_l1a          : std_logic;
    signal ttc_bc0          : std_logic;

    --== Wishbone ==--

    signal wb_m_req : wb_req_array_t((WB_MASTERS - 1) downto 0);
    signal wb_m_res : wb_res_array_t((WB_MASTERS - 1) downto 0);

    --== Configuration ==--

    signal vfat_reset     : std_logic;
    signal sbit_mask      : std_logic_vector(23 downto 0);

    signal sem_correction : std_logic;
    signal sem_critical   : std_logic;

    --== TTC ==--

    signal bxn_counter  : std_logic_vector(11 downto 0);

    --== Stupid HDMI ==--

    signal ext_sbits_o    : std_logic_vector(5  downto 0);

begin

    -- internal wiring
    gbt_txvalid <= '1';
    clock       <= clk_1x;


    -- external wiring

    ext_sbits_o   <= hdmi_n(3 downto 0) & hdmi_p(3 downto 2);

    -- gbt_txvalid_o <= gbt_txvalid;
    gbt_rxready   <= gbt_rxready_i;
    gbt_rxvalid   <= gbt_rxvalid_i;
    gbt_txready   <= gbt_txready_i;

    ext_reset_o   <= (others => '1');

    --==============--
    --== Clocking ==--
    --==============--

    clocking : entity work.clocking
    port map(

        gbt_dclk_p         => gbt_dclk_p, -- phase shiftable 40MHz ttc clocks
        gbt_dclk_n         => gbt_dclk_n, --

     -- gbt_eclk_p         => gbt_eclk_p, -- 320 MHz fixed clocks
     -- gbt_eclk_n         => gbt_eclk_n, -- do not use

        mmcms_locked_o     => mmcms_locked,

        eprt_mmcm_locked_o => eprt_mmcm_locked,
        dskw_mmcm_locked_o => dskw_mmcm_locked,

        gbt_clk1x_o        => gbt_clk1x, -- 40  MHz e-port aligned GBT clock (DO NOT SHIFT)
        gbt_clk8x_o        => gbt_clk8x, -- 320 MHz e-port aligned GBT clock (DO NOT SHIFT)

        clk_1x_o           => clk_1x, -- phase shiftable logic clocks
        clk_2x_o           => clk_2x,
        clk_4x_o           => clk_4x,
        clk_4x_90_o        => clk_4x_90,

        delay_refclk_o     => delay_refclk
    );

    reset_ctl : entity work.reset
    port map (
        clock_i        => clock,
        mmcms_locked_i => mmcms_locked,
        ready_o        => open,
        reset_o        => reset
    );

    --=========--
    --== GBT ==--
    --=========--

    gbt : entity work.gbt
    port map(

        -- reset
        reset_i => reset,

        -- input clocks

        frame_clk_i => gbt_clk1x, -- 40 MHz frame clock
        data_clk_i  => gbt_clk8x, -- 320 MHz sampling clock

        clock_i => clock,         -- 320 MHz sampling clock

        -- elinks
        elink_i_p  =>  elink_i_p,
        elink_i_n  =>  elink_i_n,

        elink_o_p  =>  elink_o_p,
        elink_o_n  =>  elink_o_n,

        -- status

        gbt_link_error_o => gbt_link_error,

        -- wishbone master
        wb_mst_req_o    => wb_m_req(WB_MST_GBT),
        wb_mst_res_i    => wb_m_res(WB_MST_GBT),

        -- decoded TTC
        resync_o        => ttc_resync,
        l1a_o           => ttc_l1a,
        bc0_o           => ttc_bc0

    );

    --=============--
    --== Control ==--
    --=============--

    control : entity work.control
    port map (

        --== TTC ==--

        clock_i                =>   clock,
        gbt_clock_i            =>   gbt_clk1x,
        reset_i                =>   reset,

        ttc_l1a                =>   ttc_l1a,
        ttc_bc0                =>   ttc_bc0,
        ttc_resync             =>   ttc_resync,

        wb_m_req_i             =>   wb_m_req,
        wb_m_res_o             =>   wb_m_res,

        -------------------
        -- status inputs --
        -------------------

        -- MMCM
        mmcms_locked_i     => mmcms_locked,
        dskw_mmcm_locked_i => dskw_mmcm_locked,
        eprt_mmcm_locked_i => eprt_mmcm_locked,

        -- SEM
        sem_critical_i => sem_critical,

        -- GBT

        gbt_rxready_i => gbt_rxready,
        gbt_rxvalid_i => gbt_rxvalid,
        gbt_txready_i => gbt_txready,
        gbt_txvalid_i => gbt_txvalid,

        -- Trigger

        active_vfats_i  => active_vfats,
        sbit_overflow_i => sbit_overflow,
        cluster_count_i => cluster_count,

        -- GBT
        gbt_link_error_i => gbt_link_error,

        -- SEM
        sem_correction_i => sem_correction,

        ---------
        -- TTC --
        ---------

        bxn_counter_o => bxn_counter,

        --------------------
        -- config outputs --
        --------------------

        -- VFAT
        vfat_reset_o => vfat_reset,
        sbit_mask_o  => sbit_mask,
        ext_sbits_o  => ext_sbits_o,

        -- LEDs
        led_o => led_o

    );

    --==================--
    --== Trigger Data ==--
    --==================--

    trigger : entity work.trigger
    port map (

        -- reset
        reset  => reset,

        -- clocks
        mgt_clk_p => mgt_clk_p_i(0),
        mgt_clk_n => mgt_clk_n_i(0),

        clk_40     => clk_1x,
        clk_80     => clk_2x,
        clk_160    => clk_4x,
        clk_160_90 => clk_4x_90,

        delay_refclk_i => delay_refclk,

        -- mgt pairs
        mgt_tx_p => mgt_tx_p_o,
        mgt_tx_n => mgt_tx_n_o,

        -- config
        oneshot_en_i    => ('1'),
        sbit_mask_i     => (sbit_mask),
        cluster_count_o => cluster_count,
        overflow_o      => sbit_overflow,
        bxn_counter_i   => bxn_counter,

        -- sbit_ors

        active_vfats_o   => active_vfats,

        -- sbits follow

        vfat_sbits_p    => vfat_sbits_p,
        vfat_sbits_n    => vfat_sbits_n,

        vfat_sof_p    => vfat_sof_p,
        vfat_sof_n    => vfat_sof_n

    );

    --=========--
    --== SEM ==--
    --=========--

    sem_mon_inst : entity work.sem_mon
    port map(
        clk_i               => clock,
        heartbeat_o         => open,
        initialization_o    => open,
        observation_o       => open,
        correction_o        => sem_correction,
        classification_o    => open,
        injection_o         => open,
        essential_o         => open,
        uncorrectable_o     => sem_critical
    );

end Behavioral;
