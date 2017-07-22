----------------------------------------------------------------------------------
-- CMS Muon Endcap
-- GEM Collaboration
-- Optohybrid v3 Firmware -- Top Logic
-- 2017/07/21 -- Initial port to version 3 electronics
-- 2017/07/22 -- Additional MMCM added to monitor and dejitter the eport clock
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

use IEEE.Numeric_STD.all;


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

    gbt_eclk_p  : in std_logic_vector (1 downto 0) ;
    gbt_eclk_n  : in std_logic_vector (1 downto 0) ;

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

    gbt_txvalid : out std_logic;
    gbt_txready : in std_logic;

    gbt_rxvalid : in std_logic;
    gbt_rxready : in std_logic;

    ext_reset   : out std_logic_vector (11 downto 0);

    --== VFAT Mezzanine ==--


    --== GTX ==--

    mgt_clk_p_i : in std_logic;
    mgt_clk_n_i : in std_logic;

    mgt_tx_p_o  : out std_logic_vector(3 downto 0);
    mgt_tx_n_o  : out std_logic_vector(3 downto 0);

    --== VFAT2s Data ==--

    vfat0_sof_p_i  : in std_logic;
    vfat0_sof_n_i  : in std_logic;
    vfat1_sof_p_i  : in std_logic;
    vfat1_sof_n_i  : in std_logic;
    vfat2_sof_p_i  : in std_logic;
    vfat2_sof_n_i  : in std_logic;
    vfat3_sof_p_i  : in std_logic;
    vfat3_sof_n_i  : in std_logic;
    vfat4_sof_p_i  : in std_logic;
    vfat4_sof_n_i  : in std_logic;
    vfat5_sof_p_i  : in std_logic;
    vfat5_sof_n_i  : in std_logic;
    vfat6_sof_p_i  : in std_logic;
    vfat6_sof_n_i  : in std_logic;
    vfat7_sof_p_i  : in std_logic;
    vfat7_sof_n_i  : in std_logic;
    vfat8_sof_p_i  : in std_logic;
    vfat8_sof_n_i  : in std_logic;
    vfat9_sof_p_i  : in std_logic;
    vfat9_sof_n_i  : in std_logic;
    vfat10_sof_p_i : in std_logic;
    vfat10_sof_n_i : in std_logic;
    vfat11_sof_p_i : in std_logic;
    vfat11_sof_n_i : in std_logic;
    vfat12_sof_p_i : in std_logic;
    vfat12_sof_n_i : in std_logic;
    vfat13_sof_p_i : in std_logic;
    vfat13_sof_n_i : in std_logic;
    vfat14_sof_p_i : in std_logic;
    vfat14_sof_n_i : in std_logic;
    vfat15_sof_p_i : in std_logic;
    vfat15_sof_n_i : in std_logic;
    vfat16_sof_p_i : in std_logic;
    vfat16_sof_n_i : in std_logic;
    vfat17_sof_p_i : in std_logic;
    vfat17_sof_n_i : in std_logic;
    vfat18_sof_p_i : in std_logic;
    vfat18_sof_n_i : in std_logic;
    vfat19_sof_p_i : in std_logic;
    vfat19_sof_n_i : in std_logic;
    vfat20_sof_p_i : in std_logic;
    vfat20_sof_n_i : in std_logic;
    vfat21_sof_p_i : in std_logic;
    vfat21_sof_n_i : in std_logic;
    vfat22_sof_p_i : in std_logic;
    vfat22_sof_n_i : in std_logic;
    vfat23_sof_p_i : in std_logic;
    vfat23_sof_n_i : in std_logic;

    vfat0_sbits_p_i  : in std_logic_vector(7 downto 0);
    vfat0_sbits_n_i  : in std_logic_vector(7 downto 0);
    vfat1_sbits_p_i  : in std_logic_vector(7 downto 0);
    vfat1_sbits_n_i  : in std_logic_vector(7 downto 0);
    vfat2_sbits_p_i  : in std_logic_vector(7 downto 0);
    vfat2_sbits_n_i  : in std_logic_vector(7 downto 0);
    vfat3_sbits_p_i  : in std_logic_vector(7 downto 0);
    vfat3_sbits_n_i  : in std_logic_vector(7 downto 0);
    vfat4_sbits_p_i  : in std_logic_vector(7 downto 0);
    vfat4_sbits_n_i  : in std_logic_vector(7 downto 0);
    vfat5_sbits_p_i  : in std_logic_vector(7 downto 0);
    vfat5_sbits_n_i  : in std_logic_vector(7 downto 0);
    vfat6_sbits_p_i  : in std_logic_vector(7 downto 0);
    vfat6_sbits_n_i  : in std_logic_vector(7 downto 0);
    vfat7_sbits_p_i  : in std_logic_vector(7 downto 0);
    vfat7_sbits_n_i  : in std_logic_vector(7 downto 0);
    vfat8_sbits_p_i  : in std_logic_vector(7 downto 0);
    vfat8_sbits_n_i  : in std_logic_vector(7 downto 0);
    vfat9_sbits_p_i  : in std_logic_vector(7 downto 0);
    vfat9_sbits_n_i  : in std_logic_vector(7 downto 0);
    vfat10_sbits_p_i : in std_logic_vector(7 downto 0);
    vfat10_sbits_n_i : in std_logic_vector(7 downto 0);
    vfat11_sbits_p_i : in std_logic_vector(7 downto 0);
    vfat11_sbits_n_i : in std_logic_vector(7 downto 0);
    vfat12_sbits_p_i : in std_logic_vector(7 downto 0);
    vfat12_sbits_n_i : in std_logic_vector(7 downto 0);
    vfat13_sbits_p_i : in std_logic_vector(7 downto 0);
    vfat13_sbits_n_i : in std_logic_vector(7 downto 0);
    vfat14_sbits_p_i : in std_logic_vector(7 downto 0);
    vfat14_sbits_n_i : in std_logic_vector(7 downto 0);
    vfat15_sbits_p_i : in std_logic_vector(7 downto 0);
    vfat15_sbits_n_i : in std_logic_vector(7 downto 0);
    vfat16_sbits_p_i : in std_logic_vector(7 downto 0);
    vfat16_sbits_n_i : in std_logic_vector(7 downto 0);
    vfat17_sbits_p_i : in std_logic_vector(7 downto 0);
    vfat17_sbits_n_i : in std_logic_vector(7 downto 0);
    vfat18_sbits_p_i : in std_logic_vector(7 downto 0);
    vfat18_sbits_n_i : in std_logic_vector(7 downto 0);
    vfat19_sbits_p_i : in std_logic_vector(7 downto 0);
    vfat19_sbits_n_i : in std_logic_vector(7 downto 0);
    vfat20_sbits_p_i : in std_logic_vector(7 downto 0);
    vfat20_sbits_n_i : in std_logic_vector(7 downto 0);
    vfat21_sbits_p_i : in std_logic_vector(7 downto 0);
    vfat21_sbits_n_i : in std_logic_vector(7 downto 0);
    vfat22_sbits_p_i : in std_logic_vector(7 downto 0);
    vfat22_sbits_n_i : in std_logic_vector(7 downto 0);
    vfat23_sbits_p_i : in std_logic_vector(7 downto 0);
    vfat23_sbits_n_i : in std_logic_vector(7 downto 0)

);
end optohybrid_top;

architecture Behavioral of optohybrid_top is

    --== SBit cluster packer ==--

    signal sbit_overflow : std_logic;
    signal cluster_count : std_logic_vector     (7  downto 0);

    --== Global signals ==--

    signal mmcms_locked : std_logic;

    signal clock        : std_logic;

    signal gbt_clk1x    : std_logic;
    signal gbt_clk8x    : std_logic;

    signal clk_1x       : std_logic;
    signal clk_2x       : std_logic;
    signal clk_4x       : std_logic;
    signal clk_4x_90    : std_logic;

    signal mgt_refclk   : std_logic;
    signal reset        : std_logic;

    signal clock_source : std_logic;

    signal ttc_resync   : std_logic;
    signal ttc_l1a      : std_logic;
    signal ttc_bc0      : std_logic;

    --== Wishbone signals ==--

    signal wb_m_req : wb_req_array_t((WB_MASTERS - 1) downto 0);
    signal wb_m_res : wb_res_array_t((WB_MASTERS - 1) downto 0);
    signal wb_s_req : wb_req_array_t((WB_SLAVES - 1) downto 0);
    signal wb_s_res : wb_res_array_t((WB_SLAVES - 1) downto 0);


    --== Configuration ==--

    signal sys_loop_sbit  : std_logic_vector(4 downto 0);
    signal vfat_reset     : std_logic;
    signal sbit_mask      : std_logic_vector(23 downto 0);
    signal sys_sbit_sel   : std_logic_vector(29 downto 0);
    signal sys_sbit_mode  : std_logic_vector(1 downto 0);

    signal sem_correction : std_logic;
    signal sem_critical   : std_logic;




begin

    reset       <= '0';
    gbt_txvalid <= '1';
    ext_reset   <= (others => reset);
    clock       <= clk_1x;

    --==============--
    --== Clocking ==--
    --==============--

    clocking_inst : entity work.clocking
    port map(

        gbt_dclk_p         => gbt_dclk_p, -- phase shiftable 40MHz ttc clocks
        gbt_dclk_n         => gbt_dclk_n, --

        gbt_eclk_p         => gbt_eclk_p, -- phase shiftable 40MHz ttc clocks
        gbt_eclk_n         => gbt_eclk_n, --

        mmcms_locked_o     => mmcms_locked,

        eprt_mmcm_locked_o => open,
        dskw_mmcm_locked_o => open,

        gbt_clk1x_o        => gbt_clk1x, -- 40  MHz e-port aligned GBT clock (DO NOT SHIFT)
        gbt_clk8x_o        => gbt_clk8x, -- 320 MHz e-port aligned GBT clock (DO NOT SHIFT)

        clk_1x_o           => clk_1x, -- phase shiftable logic clocks
        clk_2x_o           => clk_2x,
        clk_4x_o           => clk_4x,
        clk_4x_90_o        => clk_4x_90
    );

    --=====================--
    --== Wishbone switch ==--
    --=====================--

    -- This module is the Wishbone switch which redirects requests from the masters to the slaves.

    wb_switch_inst : entity work.wb_switch
    port map(
        ref_clk_i   => clock,
        reset_i     => reset,

        wb_req_i    => wb_m_req,
        wb_req_o    => wb_s_req,

        wb_res_i    => wb_s_res,
        wb_res_o    => wb_m_res
    );

    --===================--
    --== Configuration ==--
    --===================--

    sys_inst : entity work.sys
    port map(
        ref_clk_i           => clock,
        reset_i             => reset,

        wb_slv_req_i        => wb_s_req(WB_SLV_SYS),
        wb_slv_res_o        => wb_s_res(WB_SLV_SYS),

      --vfat_reset_o        => vfat_reset,
        vfat_sbit_mask_o    => sbit_mask,
        sys_loop_sbit_o     => sys_loop_sbit,
        sys_sbit_sel_o      => sys_sbit_sel,
        sys_sbit_mode_o     => sys_sbit_mode

        --sem_critical_i      => sem_critical
    );

    --=========--
    --== GBT ==--
    --=========--

    gbt_controller : entity work.gbt_controller
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

        -- wishbone master
        wb_mst_req_o    => wb_m_req(WB_MST_GBT),
        wb_mst_res_i    => wb_m_res(WB_MST_GBT),

        -- decoded TTC
        resync_o        => ttc_resync,
        l1a_o           => ttc_l1a,
        bc0_o           => ttc_bc0

    );


    --=========================--
    --== Trigger Data        ==--
    --=========================--

    trigger : entity work.trigger
    port map (

        -- reset
        reset => reset,

        -- clocks
        mgt_clk_p => mgt_clk_p_i,
        mgt_clk_n => mgt_clk_n_i,

        clk_40 => clk_1x,
        clk_80 => clk_2x,
        clk_160 => clk_4x,
        clk_160_90 => clk_4x_90,

        -- mgt pairs
        mgt_tx_p => mgt_tx_p_o,
        mgt_tx_n => mgt_tx_n_o,

        -- config
        oneshot_en_i    => ('1'),
        sbit_mask_i     => (sbit_mask),
        cluster_count_o => cluster_count,
        overflow_o      => sbit_overflow,

        -- sbits follow

        vfat0_sbits_p_i  => vfat0_sbits_p_i,
        vfat0_sbits_n_i  => vfat0_sbits_n_i,
        vfat1_sbits_p_i  => vfat1_sbits_p_i,
        vfat1_sbits_n_i  => vfat1_sbits_n_i,
        vfat2_sbits_p_i  => vfat2_sbits_p_i,
        vfat2_sbits_n_i  => vfat2_sbits_n_i,
        vfat3_sbits_p_i  => vfat3_sbits_p_i,
        vfat3_sbits_n_i  => vfat3_sbits_n_i,
        vfat4_sbits_p_i  => vfat4_sbits_p_i,
        vfat4_sbits_n_i  => vfat4_sbits_n_i,
        vfat5_sbits_p_i  => vfat5_sbits_p_i,
        vfat5_sbits_n_i  => vfat5_sbits_n_i,
        vfat6_sbits_p_i  => vfat6_sbits_p_i,
        vfat6_sbits_n_i  => vfat6_sbits_n_i,
        vfat7_sbits_p_i  => vfat7_sbits_p_i,
        vfat7_sbits_n_i  => vfat7_sbits_n_i,
        vfat8_sbits_p_i  => vfat8_sbits_p_i,
        vfat8_sbits_n_i  => vfat8_sbits_n_i,
        vfat9_sbits_p_i  => vfat9_sbits_p_i,
        vfat9_sbits_n_i  => vfat9_sbits_n_i,
        vfat10_sbits_p_i => vfat10_sbits_p_i,
        vfat10_sbits_n_i => vfat10_sbits_n_i,
        vfat11_sbits_p_i => vfat11_sbits_p_i,
        vfat11_sbits_n_i => vfat11_sbits_n_i,
        vfat12_sbits_p_i => vfat12_sbits_p_i,
        vfat12_sbits_n_i => vfat12_sbits_n_i,
        vfat13_sbits_p_i => vfat13_sbits_p_i,
        vfat13_sbits_n_i => vfat13_sbits_n_i,
        vfat14_sbits_p_i => vfat14_sbits_p_i,
        vfat14_sbits_n_i => vfat14_sbits_n_i,
        vfat15_sbits_p_i => vfat15_sbits_p_i,
        vfat15_sbits_n_i => vfat15_sbits_n_i,
        vfat16_sbits_p_i => vfat16_sbits_p_i,
        vfat16_sbits_n_i => vfat16_sbits_n_i,
        vfat17_sbits_p_i => vfat17_sbits_p_i,
        vfat17_sbits_n_i => vfat17_sbits_n_i,
        vfat18_sbits_p_i => vfat18_sbits_p_i,
        vfat18_sbits_n_i => vfat18_sbits_n_i,
        vfat19_sbits_p_i => vfat19_sbits_p_i,
        vfat19_sbits_n_i => vfat19_sbits_n_i,
        vfat20_sbits_p_i => vfat20_sbits_p_i,
        vfat20_sbits_n_i => vfat20_sbits_n_i,
        vfat21_sbits_p_i => vfat21_sbits_p_i,
        vfat21_sbits_n_i => vfat21_sbits_n_i,
        vfat22_sbits_p_i => vfat22_sbits_p_i,
        vfat22_sbits_n_i => vfat22_sbits_n_i,
        vfat23_sbits_p_i => vfat23_sbits_p_i,
        vfat23_sbits_n_i => vfat23_sbits_n_i,

        vfat0_sof_p_i   => vfat0_sof_p_i,
        vfat0_sof_n_i   => vfat0_sof_n_i,
        vfat1_sof_p_i   => vfat1_sof_p_i,
        vfat1_sof_n_i   => vfat1_sof_n_i,
        vfat2_sof_p_i   => vfat2_sof_p_i,
        vfat2_sof_n_i   => vfat2_sof_n_i,
        vfat3_sof_p_i   => vfat3_sof_p_i,
        vfat3_sof_n_i   => vfat3_sof_n_i,
        vfat4_sof_p_i   => vfat4_sof_p_i,
        vfat4_sof_n_i   => vfat4_sof_n_i,
        vfat5_sof_p_i   => vfat5_sof_p_i,
        vfat5_sof_n_i   => vfat5_sof_n_i,
        vfat6_sof_p_i   => vfat6_sof_p_i,
        vfat6_sof_n_i   => vfat6_sof_n_i,
        vfat7_sof_p_i   => vfat7_sof_p_i,
        vfat7_sof_n_i   => vfat7_sof_n_i,
        vfat8_sof_p_i   => vfat8_sof_p_i,
        vfat8_sof_n_i   => vfat8_sof_n_i,
        vfat9_sof_p_i   => vfat9_sof_p_i,
        vfat9_sof_n_i   => vfat9_sof_n_i,
        vfat10_sof_p_i  => vfat10_sof_p_i,
        vfat10_sof_n_i  => vfat10_sof_n_i,
        vfat11_sof_p_i  => vfat11_sof_p_i,
        vfat11_sof_n_i  => vfat11_sof_n_i,
        vfat12_sof_p_i  => vfat12_sof_p_i,
        vfat12_sof_n_i  => vfat12_sof_n_i,
        vfat13_sof_p_i  => vfat13_sof_p_i,
        vfat13_sof_n_i  => vfat13_sof_n_i,
        vfat14_sof_p_i  => vfat14_sof_p_i,
        vfat14_sof_n_i  => vfat14_sof_n_i,
        vfat15_sof_p_i  => vfat15_sof_p_i,
        vfat15_sof_n_i  => vfat15_sof_n_i,
        vfat16_sof_p_i  => vfat16_sof_p_i,
        vfat16_sof_n_i  => vfat16_sof_n_i,
        vfat17_sof_p_i  => vfat17_sof_p_i,
        vfat17_sof_n_i  => vfat17_sof_n_i,
        vfat18_sof_p_i  => vfat18_sof_p_i,
        vfat18_sof_n_i  => vfat18_sof_n_i,
        vfat19_sof_p_i  => vfat19_sof_p_i,
        vfat19_sof_n_i  => vfat19_sof_n_i,
        vfat20_sof_p_i  => vfat20_sof_p_i,
        vfat20_sof_n_i  => vfat20_sof_n_i,
        vfat21_sof_p_i  => vfat21_sof_p_i,
        vfat21_sof_n_i  => vfat21_sof_n_i,
        vfat22_sof_p_i  => vfat22_sof_p_i,
        vfat22_sof_n_i  => vfat22_sof_n_i,
        vfat23_sof_p_i  => vfat23_sof_p_i,
        vfat23_sof_n_i  => vfat23_sof_n_i

    );

    --==========--
    --== LEDS ==--
    --==========--

    led_control : entity work.led_control
    port map (
        -- reset
        reset         => reset,

        -- clocks
        clock         => clk_1x,
        gbt_eclk      => gbt_clk1x,

        -- signals
        mmcm_locked   => mmcms_locked,
        gbt_rxready   => gbt_rxready ,
        gbt_rxvalid   => gbt_rxvalid,
        cluster_count => cluster_count,

        -- led outputs
        led_out       => led_o
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
