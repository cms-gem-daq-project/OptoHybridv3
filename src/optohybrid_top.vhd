---------------------------------------------------------------------------------
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

--  multiboot_rs_o          : out std_logic_vector(1 downto 0);

--  flash_address_o         : out std_logic_vector(22 downto 0);
--  flash_data_io           : inout std_logic_vector(15 downto 0);
--  flash_chip_enable_b_o   : out std_logic;
--  flash_out_enable_b_o    : out std_logic;
--  flash_write_enable_b_o  : out std_logic;
--  flash_latch_enable_b_o  : out std_logic;

    --== Clocking ==--

  --gbt_eclk_p  : in std_logic_vector (1 downto 0) ;
  --gbt_eclk_n  : in std_logic_vector (1 downto 0) ;

    gbt_dclk_p : in std_logic_vector (1 downto 0) ;
    gbt_dclk_n : in std_logic_vector (1 downto 0) ;

    --== Miscellaneous ==--

    elink_i_p : in  std_logic_vector (1 downto 0) ;
    elink_i_n : in  std_logic_vector (1 downto 0) ;

    elink_o_p : out std_logic_vector (1 downto 0) ;
    elink_o_n : out std_logic_vector (1 downto 0) ;

    gbt_txready_i : in std_logic;

    gbt_rxvalid_i : in std_logic;
    gbt_rxready_i : in std_logic;

    --== SCA ==--

    sca_io  : in  std_logic_vector (3 downto 0); -- set as input for now

    --== HDMI  ==--

    ext_sbits_o : out  std_logic_vector (5 downto 0);

    --== LEDs ==--

    led_o   : out std_logic_vector (15 downto 0);

    --== VFAT Reset ==--

    ext_reset_o : out std_logic_vector (11 downto 0);

    --== Analog input ==--

    adc_vp         : in  std_logic;
    adc_vn         : in  std_logic;

    --== VFAT Mezzanine ==--


    --== GTX ==--

    mgt_clk_p_i : in std_logic;
    mgt_clk_n_i : in std_logic;

    mgt_tx_p_o : out std_logic_vector(3 downto 0);
    mgt_tx_n_o : out std_logic_vector(3 downto 0);

    --== VFAT Trigger Data ==--

    vfat_sof_p : in std_logic_vector (23 downto 0);
    vfat_sof_n : in std_logic_vector (23 downto 0);

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
    signal cluster_clk      : std_logic;

    signal gbt_txready      : std_logic;
    signal gbt_rxvalid      : std_logic;
    signal gbt_rxready      : std_logic;

    signal gbt_link_error   : std_logic;

    signal mgt_refclk       : std_logic;
    signal reset            : std_logic;

    signal clock_source     : std_logic;

    signal ctrl_reset_vfats : std_logic;
    signal ttc_reset_vfats  : std_logic;
    signal reset_vfats      : std_logic;
    signal ttc_resync       : std_logic;
    signal ttc_l1a          : std_logic;
    signal ttc_bc0          : std_logic;

    --== Wishbone ==--

    signal wb_m_req : wb_req_array_t((WB_MASTERS - 1) downto 0);
    signal wb_m_res : wb_res_array_t((WB_MASTERS - 1) downto 0);

    --== Configuration ==--

    signal vfat_reset       : std_logic;
    signal sbit_mask        : std_logic_vector(23 downto 0);
    signal trigger_deadtime : std_logic_vector(3 downto 0);

    signal sem_correction : std_logic;
    signal sem_critical   : std_logic;

    --== TTC ==--

    signal bxn_counter  : std_logic_vector(11 downto 0);
    signal trig_stop    : std_logic;

    --== IOB Constraints for Outputs ==--

    attribute IOB : string;
    attribute KEEP : string;

    -- don't remove duplicates for fanout, needed to pack into iob
    signal ext_reset : std_logic_vector (11 downto 0);
    attribute KEEP of ext_reset   : signal is "TRUE";

    attribute IOB  of led_o       : signal is "FORCE";
    attribute IOB  of ext_reset_o : signal is "FORCE";
    attribute IOB  of gbt_rxready : signal is "FORCE";
    attribute IOB  of gbt_rxvalid : signal is "FORCE";
    attribute IOB  of gbt_txready : signal is "FORCE";
    attribute IOB  of sca_io      : signal is "FORCE";
    attribute IOB  of ext_sbits_o : signal is "FORCE";

begin

    -- internal wiring

    clock       <= clk_1x;

    -- buffers to copy into IOBs

    process(clock)
    begin
    if (rising_edge(clock)) then

        gbt_rxready   <= gbt_rxready_i;
        gbt_rxvalid   <= gbt_rxvalid_i;
        gbt_txready   <= gbt_txready_i;

        reset_vfats <= (ttc_reset_vfats or ctrl_reset_vfats);

        ext_reset   <= (others => reset_vfats);

        ext_reset_o   <= ext_reset;

    end if;
    end process;

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

        cluster_clk_o      => cluster_clk,
        delay_refclk_o     => delay_refclk
    );

    reset_ctl : entity work.reset
    port map (
        clock_i        => clock,
        mmcms_locked_i => mmcms_locked,
        gbt_rxready_i  => gbt_rxready,
        gbt_rxvalid_i  => gbt_rxvalid,
        gbt_txready_i  => gbt_txready,
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
        reset_vfats_o   => ttc_reset_vfats,
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

        -- Trigger

        active_vfats_i  => active_vfats,
        sbit_overflow_i => sbit_overflow,
        cluster_count_i => cluster_count,

        -- GBT
        gbt_link_error_i => gbt_link_error,

        -- SEM
        sem_correction_i => sem_correction,

        -- Analog input
        adc_vp          => adc_vp,
        adc_vn          => adc_vn,

        ---------
        -- TTC --
        ---------

        bxn_counter_o => bxn_counter,
        trig_stop_o   => trig_stop,

        --------------------
        -- config outputs --
        --------------------

        -- VFAT
        vfat_reset_o       => ctrl_reset_vfats,
        sbit_mask_o        => sbit_mask,
        trigger_deadtime_o => trigger_deadtime,
        ext_sbits_o        => ext_sbits_o,

        -- LEDs
        led_o => led_o

    );

    --==================--
    --== Trigger Data ==--
    --==================--

    trigger : entity work.trigger
    port map (

        -- reset
        reset_i  => reset,

        -- clocks
        mgt_clk_p => mgt_clk_p_i,
        mgt_clk_n => mgt_clk_n_i,

        clk_40     => clk_1x,
        clk_80     => clk_2x,
        clk_160    => clk_4x,
        clk_160_90 => clk_4x_90,

        delay_refclk_i => delay_refclk,

        cluster_clk => cluster_clk,

        -- mgt pairs
        mgt_tx_p => mgt_tx_p_o,
        mgt_tx_n => mgt_tx_n_o,

        -- config
        trigger_deadtime_i => trigger_deadtime,
        sbit_mask_i        => sbit_mask,
        cluster_count_o    => cluster_count,
        overflow_o         => sbit_overflow,
        bxn_counter_i      => bxn_counter,

        -- sbit_ors

        active_vfats_o   => active_vfats,

        -- trig stop from fmm

        trig_stop_i     => trig_stop,

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
