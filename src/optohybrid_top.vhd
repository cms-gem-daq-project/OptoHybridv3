----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    13:13:21 03/12/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    optohybrid_top - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description: 
--
-- Top Level of the design
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library work;
use work.types_pkg.all;
use work.wb_pkg.all;

entity optohybrid_top is
port(

    --== VFAT2s Control ==--
    
    vfat2_mclk_p_o          : out std_logic_vector(2 downto 0);
    vfat2_mclk_n_o          : out std_logic_vector(2 downto 0);
    
    vfat2_resb_o            : out std_logic_vector(2 downto 0);
    vfat2_resh_o            : out std_logic_vector(2 downto 0);
    
    vfat2_t1_p_o            : out std_logic_vector(2 downto 0);
    vfat2_t1_n_o            : out std_logic_vector(2 downto 0);
    
    vfat2_scl_o             : out std_logic_vector(5 downto 0);
    vfat2_sda_io            : inout std_logic_vector(5 downto 0);
    
    -- vfat2_daco_v_i          : in std_logic_vector(2 downto 0);
    -- vfat2_daco_i_i          : in std_logic_vector(2 downto 0);
    
    vfat2_data_valid_p_i    : in std_logic_vector(5 downto 0);
    vfat2_data_valid_n_i    : in std_logic_vector(5 downto 0);
    
    --== VFAT2s Data ==--
    
    vfat2_0_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat2_0_sbits_n_i       : in std_logic_vector(7 downto 0);
    vfat2_0_data_out_p_i    : in std_logic;
    vfat2_0_data_out_n_i    : in std_logic;

    vfat2_1_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat2_1_sbits_n_i       : in std_logic_vector(7 downto 0);
    vfat2_1_data_out_p_i    : in std_logic;
    vfat2_1_data_out_n_i    : in std_logic;

    vfat2_2_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat2_2_sbits_n_i       : in std_logic_vector(7 downto 0);
    vfat2_2_data_out_p_i    : in std_logic;
    vfat2_2_data_out_n_i    : in std_logic;

    vfat2_3_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat2_3_sbits_n_i       : in std_logic_vector(7 downto 0);
    vfat2_3_data_out_p_i    : in std_logic;
    vfat2_3_data_out_n_i    : in std_logic;

    vfat2_4_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat2_4_sbits_n_i       : in std_logic_vector(7 downto 0);
    vfat2_4_data_out_p_i    : in std_logic;
    vfat2_4_data_out_n_i    : in std_logic;

    vfat2_5_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat2_5_sbits_n_i       : in std_logic_vector(7 downto 0);
    vfat2_5_data_out_p_i    : in std_logic;
    vfat2_5_data_out_n_i    : in std_logic;

    vfat2_6_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat2_6_sbits_n_i       : in std_logic_vector(7 downto 0);
    vfat2_6_data_out_p_i    : in std_logic;
    vfat2_6_data_out_n_i    : in std_logic;

    vfat2_7_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat2_7_sbits_n_i       : in std_logic_vector(7 downto 0);
    vfat2_7_data_out_p_i    : in std_logic;
    vfat2_7_data_out_n_i    : in std_logic;

    vfat2_8_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat2_8_sbits_n_i       : in std_logic_vector(7 downto 0);
    vfat2_8_data_out_p_i    : in std_logic;
    vfat2_8_data_out_n_i    : in std_logic;

    vfat2_9_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat2_9_sbits_n_i       : in std_logic_vector(7 downto 0);
    vfat2_9_data_out_p_i    : in std_logic;
    vfat2_9_data_out_n_i    : in std_logic;

    vfat2_10_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat2_10_sbits_n_i      : in std_logic_vector(7 downto 0);
    vfat2_10_data_out_p_i   : in std_logic;
    vfat2_10_data_out_n_i   : in std_logic;
    
    vfat2_11_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat2_11_sbits_n_i      : in std_logic_vector(7 downto 0);
    vfat2_11_data_out_p_i   : in std_logic;
    vfat2_11_data_out_n_i   : in std_logic;

    vfat2_12_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat2_12_sbits_n_i      : in std_logic_vector(7 downto 0);
    vfat2_12_data_out_p_i   : in std_logic;
    vfat2_12_data_out_n_i   : in std_logic;

    vfat2_13_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat2_13_sbits_n_i      : in std_logic_vector(7 downto 0);
    vfat2_13_data_out_p_i   : in std_logic;
    vfat2_13_data_out_n_i   : in std_logic;

    vfat2_14_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat2_14_sbits_n_i      : in std_logic_vector(7 downto 0);
    vfat2_14_data_out_p_i   : in std_logic;
    vfat2_14_data_out_n_i   : in std_logic;

    vfat2_15_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat2_15_sbits_n_i      : in std_logic_vector(7 downto 0);
    vfat2_15_data_out_p_i   : in std_logic;
    vfat2_15_data_out_n_i   : in std_logic;

    vfat2_16_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat2_16_sbits_n_i      : in std_logic_vector(7 downto 0);
    vfat2_16_data_out_p_i   : in std_logic;
    vfat2_16_data_out_n_i   : in std_logic;

    vfat2_17_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat2_17_sbits_n_i      : in std_logic_vector(7 downto 0);
    vfat2_17_data_out_p_i   : in std_logic;
    vfat2_17_data_out_n_i   : in std_logic;

    vfat2_18_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat2_18_sbits_n_i      : in std_logic_vector(7 downto 0);
    vfat2_18_data_out_p_i   : in std_logic;
    vfat2_18_data_out_n_i   : in std_logic;

    vfat2_19_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat2_19_sbits_n_i      : in std_logic_vector(7 downto 0);
    vfat2_19_data_out_p_i   : in std_logic;
    vfat2_19_data_out_n_i   : in std_logic;

    vfat2_20_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat2_20_sbits_n_i      : in std_logic_vector(7 downto 0);
    vfat2_20_data_out_p_i   : in std_logic;
    vfat2_20_data_out_n_i   : in std_logic;

    vfat2_21_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat2_21_sbits_n_i      : in std_logic_vector(7 downto 0);
    vfat2_21_data_out_p_i   : in std_logic;
    vfat2_21_data_out_n_i   : in std_logic;

    vfat2_22_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat2_22_sbits_n_i      : in std_logic_vector(7 downto 0);
    vfat2_22_data_out_p_i   : in std_logic;
    vfat2_22_data_out_n_i   : in std_logic;

    vfat2_23_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat2_23_sbits_n_i      : in std_logic_vector(7 downto 0);
    vfat2_23_data_out_p_i   : in std_logic;
    vfat2_23_data_out_n_i   : in std_logic;
    
    --== Memory ==--
    
--    multiboot_rs_o          : out std_logic_vector(1 downto 0);
    
--    flash_address_o         : out std_logic_vector(22 downto 0);
--    flash_data_io           : inout std_logic_vector(15 downto 0);
--    flash_chip_enable_b_o   : out std_logic;
--    flash_out_enable_b_o    : out std_logic;
--    flash_write_enable_b_o  : out std_logic;
--    flash_latch_enable_b_o  : out std_logic;
    
    --== Clocking ==--
    
    qpll_clk_p_i            : in std_logic;
    qpll_clk_n_i            : in std_logic;
    qpll_reset_o            : out std_logic;
    qpll_locked_i           : in std_logic;
    
    --== Miscellaneous ==--
    
    ext_clk_i               : in std_logic;
    ext_trigger_i           : in std_logic;
    ext_sbits_o             : out std_logic_vector(5 downto 0);
    
    header_io               : in std_logic_vector(15 downto 0);

    xadc_p_i                : in std_logic_vector(5 downto 0);
    xadc_n_i                : in std_logic_vector(5 downto 0);

    -- test points
    tp_1p_o                 : out std_logic;
    tp_1n_o                 : out std_logic;
    tp_4p_o                 : out std_logic;
    tp_4n_o                 : out std_logic;
    tp_5p_o                 : out std_logic;
    tp_5n_o                 : out std_logic;
    tp_20p_o                : out std_logic;
    tp_20n_o                : out std_logic;
    
    --== GTX ==--
    
    mgt_clk_p_i             : in std_logic;
    mgt_clk_n_i             : in std_logic;

    mgt_rx_p_i              : in std_logic_vector(4 downto 0); -- 0 = Tracking and control
    mgt_rx_n_i              : in std_logic_vector(4 downto 0); -- 1 to 4 = trigger links
    mgt_tx_p_o              : out std_logic_vector(4 downto 0);
    mgt_tx_n_o              : out std_logic_vector(4 downto 0);
    
    --== GBT ==--
    
    to_gbt_p_o              : out std_logic_vector(3 downto 0);
    to_gbt_n_o              : out std_logic_vector(3 downto 0);       
    from_gbt_p_i            : in std_logic_vector(1 downto 0);
    from_gbt_n_i            : in std_logic_vector(1 downto 0);       
    gbtx_data_clk_p_i       : in std_logic; -- elink clk (320MHz)
    gbtx_data_clk_n_i       : in std_logic; -- elink clk (320MHz)
    gbtx_clk0_p_i           : in std_logic; -- TTC clk (40MHz)
    gbtx_clk0_n_i           : in std_logic  -- TTC clk (40MHz)

);
end optohybrid_top;

architecture Behavioral of optohybrid_top is

    --== Buffers ==--
    
    signal vfat2_mclk_b         : std_logic; 
    signal vfat2_reset_b        : std_logic;
    signal vfat2_t1_b           : std_logic;
    signal vfat2_scl_b          : std_logic_vector(5 downto 0); 
    signal vfat2_sda_mosi_b     : std_logic_vector(5 downto 0); 
    signal vfat2_sda_miso_b     : std_logic_vector(5 downto 0); 
    signal vfat2_sda_tri_b      : std_logic_vector(5 downto 0); 
    signal vfat2_data_valid_b   : std_logic_vector(5 downto 0);
    signal vfat2_data_out_b     : std_logic_vector(23 downto 0);
    signal vfat2_sbits_b        : sbits_array_t(23 downto 0);    
 
    signal qpll_clk_b           : std_logic;
    signal qpll_reset_b         : std_logic;
    signal qpll_locked_b        : std_logic;
    signal qpll_pll_locked_b    : std_logic;
    
    --== SBit cluster packer ==--
    
    signal sbit_overflow        : std_logic;
    signal vfat_sbit_clusters   : sbit_cluster_array_t(7 downto 0);
    
    --== Global signals ==--

    signal ref_clk              : std_logic;
    signal clk_1x               : std_logic;
    signal clk_2x               : std_logic;
    signal clk_4x               : std_logic;

    signal mgt_refclk           : std_logic;
    signal reset                : std_logic;    

    --== GTX ==--
    
    signal gtx_clk              : std_logic;    
    signal gtx_tk_error         : std_logic;
    signal gtx_tr_error         : std_logic;
    signal gtx_evt_sent         : std_logic;
    
    signal gtx_tx_kchar         : std_logic_vector(5 downto 0);
    signal gtx_tx_data          : std_logic_vector(47 downto 0);
    signal gtx_rx_kchar         : std_logic_vector(1 downto 0);
    signal gtx_rx_data          : std_logic_vector(15 downto 0);
    signal gtx_rx_error         : std_logic_vector(0 downto 0);
    
    --== GBT ==--
    
    signal gbt_clk              : std_logic;
    signal gbt_din              : std_logic_vector(15 downto 0);
    signal gbt_dout             : std_logic_vector(31 downto 0);
    signal gbt_valid            : std_logic;
    signal gbt_error            : std_logic;
    signal gbt_evt_sent         : std_logic;
    signal gbt_sync_reset       : std_logic;
    
    --== VFAT2 ==--
    
    signal vfat2_t1             : t1_array_t(5 downto 0); -- 0 = GTX, 1 = Internal, 2 = External, 3 = loop, 4 = Muxed, 5 = GBT (for backwards compatibility put at the end)
    signal vfat2_tk_data        : tk_data_array_t(23 downto 0);
    
    --== SEM ==--
    signal sem_correction       : std_logic;
    signal sem_critical         : std_logic;
    
    --== System ==--
    
    signal vfat2_tk_mask        : std_logic_vector(23 downto 0);
    signal vfat2_t1_sel         : std_logic_vector(2 downto 0);
    signal sys_loop_sbit        : std_logic_vector(4 downto 0);
    signal vfat2_reset          : std_logic;
    signal vfat2_sbit_mask      : std_logic_vector(23 downto 0);
    signal sys_sbit_sel         : std_logic_vector(29 downto 0);
    signal trigger_lim          : std_logic_vector(31 downto 0);
    signal zero_suppress        : std_logic;
    signal sys_sbit_mode        : std_logic_vector(1 downto 0);
    signal clk_source           : std_logic;
    signal remove_bad_crc       : std_logic;
    
    --== Wishbone signals ==--
    
    signal wb_m_req             : wb_req_array_t((WB_MASTERS - 1) downto 0);
    signal wb_m_res             : wb_res_array_t((WB_MASTERS - 1) downto 0);
    signal wb_s_req             : wb_req_array_t((WB_SLAVES - 1) downto 0);
    signal wb_s_res             : wb_res_array_t((WB_SLAVES - 1) downto 0);
        
begin

    reset <= '0';
    
    clocking_inst : entity work.clocking
    port map(
        qpll_clk_i      => qpll_clk_b,
        gbt_clk_i       => gbt_clk,
        clk_source_i    => clk_source,
        ref_clk_o       => ref_clk,
        clk_1x_o        => clk_1x,
        clk_2x_o        => clk_2x,
        clk_4x_o        => clk_4x        
    );
        
    --======================--
    --== External signals ==--
    --======================--   

    -- This module handles the external signals: the input trigger and the output SBits.
    
    external_inst : entity work.external
    port map(
        ref_clk_i           => ref_clk,
        reset_i             => reset,
        ext_trigger_i       => ext_trigger_i,
        vfat2_t1_o          => vfat2_t1(2),
        vfat2_sbits_i       => vfat2_sbits_b,
        vfat2_sbit_mask_i   => vfat2_sbit_mask,
        sys_sbit_mode_i     => sys_sbit_mode,
        sys_sbit_sel_i      => sys_sbit_sel,
        ext_sbits_o         => ext_sbits_o        
    );

    --=================--
    --== Test points ==--
    --=================-- 
    
    tp_inst : entity work.tp
    port map(
        gbt_clk_i   => gbt_clk,
        tp_1p_o     => tp_1p_o,
        tp_1n_o     => tp_1n_o,
        tp_4p_o     => tp_4p_o,
        tp_4n_o     => tp_4n_o,
        tp_5p_o     => tp_5p_o,
        tp_5n_o     => tp_5n_o,
        tp_20p_o    => tp_20p_o,
        tp_20n_o    => tp_20n_o
    ); 
    
    --=====================--
    --== Wishbone switch ==--
    --=====================--
    
    -- This module is the Wishbone switch which redirects requests from the masters to the slaves.
    
    wb_switch_inst : entity work.wb_switch
    port map(
        ref_clk_i   => ref_clk,
        reset_i     => reset,
        wb_req_i    => wb_m_req,
        wb_req_o    => wb_s_req,
        wb_res_i    => wb_s_res,
        wb_res_o    => wb_m_res
    );

    --=========--
    --== GTX ==--
    --=========--
    
    -- This module controls the PHY of the GTX. It contains low-level functions that control the quality of the 
    -- link and perform the resets.
    
    gtx_inst : entity work.gtx
    port map(
        mgt_refclk_n_i => mgt_clk_n_i,
        mgt_refclk_p_i => mgt_clk_p_i,
        mgt_refclk_o   => mgt_refclk,
        ref_clk_i      => ref_clk,
        reset_i        => reset,
        gtx_clk_o      => gtx_clk,
        tx_kchar_i     => gtx_tx_kchar( 1 downto 0),
        tx_data_i      => gtx_tx_data (15 downto 0),
        rx_kchar_o     => gtx_rx_kchar( 1 downto 0),
        rx_data_o      => gtx_rx_data (15 downto 0),
        rx_error_o     => gtx_rx_error,
        rx_n_i         => mgt_rx_n_i(0 downto 0),
        rx_p_i         => mgt_rx_p_i(0 downto 0),
        tx_n_o         => mgt_tx_n_o(0 downto 0),
        tx_p_o         => mgt_tx_p_o(0 downto 0)
    );
    
    -- This module controls the DATA of the GTX. It formats data packets to be sent over the optical link.

    gtx_link_inst : entity work.gtx_link
    port map(
        ref_clk_i       => ref_clk,
        gtx_clk_i       => gtx_clk,
        reset_i         => reset,
        gtx_tx_kchar_o  => gtx_tx_kchar,
        gtx_tx_data_o   => gtx_tx_data,
        gtx_rx_kchar_i  => gtx_rx_kchar,
        gtx_rx_data_i   => gtx_rx_data,
        gtx_rx_error_i  => gtx_rx_error,        
        wb_mst_req_o    => wb_m_req(WB_MST_GTX),
        wb_mst_res_i    => wb_m_res(WB_MST_GTX),
        vfat2_tk_data_i => vfat2_tk_data,
        vfat2_tk_mask_i => vfat2_tk_mask,
        zero_suppress_i => zero_suppress,
        vfat2_t1_i      => vfat2_t1(4),
        vfat2_t1_o      => vfat2_t1(0), 
        tk_error_o      => gtx_tk_error,
        tr_error_o      => gtx_tr_error,
        evt_sent_o      => gtx_evt_sent,
        sbit_clusters_i => vfat_sbit_clusters        
    );
    
    --=========--
    --== GBT ==--
    --=========--
    
    -- This module controls the PHY of the GBT. It contains low-level functions that control the quality of the 
    -- link and perform the resets.
    
    gbt_inst : entity work.gbt
    port map(
       sync_reset_i     => gbt_sync_reset,
       to_gbt_p         => to_gbt_p_o,
       to_gbt_n         => to_gbt_n_o,       
       from_gbt_p       => from_gbt_p_i,
       from_gbt_n       => from_gbt_n_i,     
       data_clk_p       => gbtx_data_clk_p_i,
       data_clk_n       => gbtx_data_clk_n_i,
       gbt_ttc_clk_p    => gbtx_clk0_p_i,
       gbt_ttc_clk_n    => gbtx_clk0_n_i,
       gbt_clk_o        => gbt_clk,
       data_o           => gbt_din,
       data_i           => gbt_dout,
       valid_o          => gbt_valid,    
       header_io        => open     
    );
    
    -- This module controls the DATA of the GBT. It formats data packets to be sent over the optical link.
    
    gbt_link_inst : entity work.gbt_link
    port map(
        ref_clk_i       => ref_clk,
        reset_i         => reset,
        data_i          => gbt_din,
        data_o          => gbt_dout,
        valid_i         => gbt_valid,
        wb_mst_req_o    => wb_m_req(WB_MST_GBT),
        wb_mst_res_i    => wb_m_res(WB_MST_GBT),
        vfat2_tk_data_i => vfat2_tk_data,
        vfat2_tk_mask_i => vfat2_tk_mask,
        zero_suppress_i => zero_suppress,
        vfat2_t1_i      => vfat2_t1(4),
        vfat2_t1_o      => vfat2_t1(5), 
        error_o         => gbt_error,
        evt_sent_o      => gbt_evt_sent,
        sync_reset_o    => gbt_sync_reset
    );    
    
    --=================================--
    --== Fixed latency trigger links ==--
    --=================================--

    trigger_links_inst : entity work.trigger_links
    port map (
        mgt_refclk => mgt_refclk, -- 160 MHz Reference Clock from QPLL

        clk_40     => clk_1x,  -- 40 MHz Clock Derived from QPLL
        clk_80     => clk_2x,  -- 80 MHz Clock Derived from QPLL
        clk_160    => clk_4x, -- 160 MHz Clock Derived from QPLL

        reset      => reset,

        trg_tx_p   => mgt_tx_p_o (4 downto 1),
        trg_tx_n   => mgt_tx_n_o (4 downto 1),

        cluster0   => vfat_sbit_clusters(0),
        cluster1   => vfat_sbit_clusters(1),
        cluster2   => vfat_sbit_clusters(2),
        cluster3   => vfat_sbit_clusters(3),
        cluster4   => vfat_sbit_clusters(4),
        cluster5   => vfat_sbit_clusters(5),
        cluster6   => vfat_sbit_clusters(6),
        cluster7   => vfat_sbit_clusters(7),

        overflow   => sbit_overflow
    );

    --=============--
    --== Trigger ==--
    --=============--
    
    -- This module controls the trigger source. 
    
    trigger_inst : entity work.trigger
    port map(
        ref_clk_i       => ref_clk,
        reset_i         => reset,
        vfat2_sbits_i   => vfat2_sbits_b,
        vfat2_t1_sel_i  => vfat2_t1_sel,
        sys_loop_sbit_i => sys_loop_sbit,
        trigger_lim_i   => trigger_lim,
        vfat2_t1_gtx_i  => vfat2_t1(0),    
        vfat2_t1_gbt_i  => vfat2_t1(5), 
        vfat2_t1_int_i  => vfat2_t1(1),
        vfat2_t1_ext_i  => vfat2_t1(2),
        vfat2_t1_loop_o => vfat2_t1(3),
        vfat2_t1_mux_o  => vfat2_t1(4)
    );

    --===========--
    --== VFAT2 ==--
    --===========--
    
    -- This module controls the low-level VFAT2 functionnalities.
        
    vfat2_inst : entity work.vfat2      
    port map(        
        ref_clk_i           => ref_clk,
        clk_4x_i            => clk_4x,
        reset_i             => reset,
        vfat2_reset_i       => vfat2_reset,
        vfat2_t1_i          => vfat2_t1(4),
        vfat2_mclk_o        => vfat2_mclk_b,
        vfat2_reset_o       => vfat2_reset_b,
        vfat2_t1_o          => vfat2_t1_b,
        remove_bad_crc_i    => remove_bad_crc,
        vfat2_data_out_i    => vfat2_data_out_b,
        vfat2_tk_data_o     => vfat2_tk_data,
        wb_slv_i2c_req_i    => wb_s_req(WB_SLV_I2C_5 downto WB_SLV_I2C_0),
        wb_slv_i2c_res_o    => wb_s_res(WB_SLV_I2C_5 downto WB_SLV_I2C_0),
        vfat2_scl_o         => vfat2_scl_b,
        vfat2_sda_miso_i    => vfat2_sda_miso_b,
        vfat2_sda_mosi_o    => vfat2_sda_mosi_b,
        vfat2_sda_tri_o     => vfat2_sda_tri_b
    );    

    --=====================--
    --== Functionalities ==--
    --=====================--
    
    -- This modules controls the high-level VFAT2 functionnalities.
        
    func_inst : entity work.func      
    port map(        
        ref_clk_i           => ref_clk,
        reset_i             => reset,
        wb_slv_ei2c_req_i   => wb_s_req(WB_SLV_EI2C),
        wb_slv_ei2c_res_o   => wb_s_res(WB_SLV_EI2C),
        wb_mst_ei2c_req_o   => wb_m_req(WB_MST_EI2C),
        wb_mst_ei2c_res_i   => wb_m_res(WB_MST_EI2C),
        wb_slv_scan_req_i   => wb_s_req(WB_SLV_SCAN),
        wb_slv_scan_res_o   => wb_s_res(WB_SLV_SCAN),
        wb_mst_scan_req_o   => wb_m_req(WB_MST_SCAN),
        wb_mst_scan_res_i   => wb_m_res(WB_MST_SCAN),
        wb_slv_uscan_req_i  => wb_s_req(WB_SLV_USCAN),
        wb_slv_uscan_res_o  => wb_s_res(WB_SLV_USCAN),
        wb_mst_uscan_req_o  => wb_m_req(WB_MST_USCAN),
        wb_mst_uscan_res_i  => wb_m_res(WB_MST_USCAN),
        wb_slv_t1_req_i     => wb_s_req(WB_SLV_T1),
        wb_slv_t1_res_o     => wb_s_res(WB_SLV_T1),
        wb_slv_dac_req_i    => wb_s_req(WB_SLV_DAC),
        wb_slv_dac_res_o    => wb_s_res(WB_SLV_DAC),
        wb_mst_dac_req_o    => wb_m_req(WB_MST_DAC),
        wb_mst_dac_res_i    => wb_m_res(WB_MST_DAC),
        vfat2_tk_data_i     => vfat2_tk_data,
        vfat2_sbits_i       => vfat2_sbits_b,
        vfat2_t1_o          => vfat2_t1(1)
    );    
    
    --=========--
    --== ADC ==--
    --=========--
    
    -- This module controls the xADC of the Virtex6.
    
    adc_inst : entity work.adc
    port map(
        ref_clk_i       => ref_clk,
        reset_i         => reset,
        wb_slv_req_i    => wb_s_req(WB_SLV_ADC),
        wb_slv_res_o    => wb_s_res(WB_SLV_ADC),
        xadc_p_i        => xadc_p_i,
        xadc_n_i        => xadc_n_i
    );
    
    --=========--
    --== SEM ==--
    --=========--
    
    sem_mon_inst : entity work.sem_mon
    port map(
        clk_i               => ref_clk,
        heartbeat_o         => open,
        initialization_o    => open,
        observation_o       => open,
        correction_o        => sem_correction,
        classification_o    => open,
        injection_o         => open,
        essential_o         => open,
        uncorrectable_o     => sem_critical
    );   
            
    --==============--
    --== Counters ==--
    --==============--
    
    -- This module implements a multitude of counters.
    
    counters_inst : entity work.counters
    port map(
        ref_clk_i           => ref_clk,
        gtx_clk_i           => gtx_clk,
        reset_i             => reset, 
        wb_slv_req_i        => wb_s_req(WB_SLV_CNT),
        wb_slv_res_o        => wb_s_res(WB_SLV_CNT),
        wb_m_req_i          => wb_m_req,      
        wb_m_res_i          => wb_m_res,
        wb_s_req_i          => wb_s_req,
        wb_s_res_i          => wb_s_res,
        vfat2_tk_data_i     => vfat2_tk_data,
        vfat2_t1_i          => vfat2_t1,
        gtx_tk_error_i      => gtx_tk_error,
        gtx_tr_error_i      => gtx_tr_error,
        gtx_evt_sent_i      => gtx_evt_sent,        
        gbt_link_error_i    => gbt_error,  
        gbt_evt_sent_i      => gbt_evt_sent,  
        qpll_locked_i       => qpll_locked_b,
        qpll_pll_locked_i   => qpll_pll_locked_b,        
        vfat2_sbits_i       => vfat2_sbits_b,
        sem_correction_i    => sem_correction
    );
    
    --============--
    --== System ==--
    --============--
    
    -- This module holds the system registers that define the behaviour of the OH.
    
    sys_inst : entity work.sys
    port map(
        ref_clk_i           => ref_clk,
        reset_i             => reset, 
        wb_slv_req_i        => wb_s_req(WB_SLV_SYS),
        wb_slv_res_o        => wb_s_res(WB_SLV_SYS),  
        vfat2_tk_mask_o     => vfat2_tk_mask,
        vfat2_t1_sel_o      => vfat2_t1_sel,
        sys_loop_sbit_o     => sys_loop_sbit,
        vfat2_reset_o       => vfat2_reset,
        vfat2_sbit_mask_o   => vfat2_sbit_mask,
        sys_sbit_sel_o      => sys_sbit_sel,
        trigger_lim_o       => trigger_lim,
        zero_suppress_o     => zero_suppress,
        sys_sbit_mode_o     => sys_sbit_mode,
        clk_source_o        => clk_source,
        remove_bad_crc_o    => remove_bad_crc
    );
    
    --============--
    --== Status ==--
    --============--
    
    -- This module holds the status registers that describe the state of the OH.
    
    stat_inst : entity work.stat
    port map(
        ref_clk_i           => ref_clk,
        reset_i             => reset, 
        wb_slv_req_i        => wb_s_req(WB_SLV_STAT),
        wb_slv_res_o        => wb_s_res(WB_SLV_STAT), 
        qpll_locked_i       => qpll_locked_b,
        qpll_pll_locked_i   => qpll_pll_locked_b,
        sem_critical_i      => sem_critical
    );

    --=========================--
    --== SBit cluster packer ==--
    --=========================--

    -- This module handles the SBits
    sbits_inst : entity work.sbits
    port map(
        gtx_clk_i               => gtx_clk,
        clk160_i                => clk_4x,
        clk40_i                 => clk_1x,
        reset_i                 => reset,
        vfat2_sbits_i           => vfat2_sbits_b,
        vfat2_sbit_mask_i       => vfat2_sbit_mask,
        vfat_sbit_clusters_o    => vfat_sbit_clusters,
        oneshot_en_i            => ('1'),
        overflow_o              => sbit_overflow
    );
    
    --=============--
    --== Buffers ==--
    --=============--
    
    -- This module implements all the required buffers on the FPGA. 
    -- Nothing to see below here.
    
    buffers_inst: entity work.buffers 
    port map(
        -- VFAT2
        vfat2_mclk_p_o          => vfat2_mclk_p_o,
        vfat2_mclk_n_o          => vfat2_mclk_n_o,
        vfat2_resb_o            => vfat2_resb_o,
        vfat2_resh_o            => vfat2_resh_o,
        vfat2_t1_p_o            => vfat2_t1_p_o,
        vfat2_t1_n_o            => vfat2_t1_n_o,
        vfat2_scl_o             => vfat2_scl_o,
        vfat2_sda_io            => vfat2_sda_io,
        vfat2_data_valid_p_i    => vfat2_data_valid_p_i,
        vfat2_data_valid_n_i    => vfat2_data_valid_n_i,
        vfat2_0_sbits_p_i       => vfat2_0_sbits_p_i,
        vfat2_0_sbits_n_i       => vfat2_0_sbits_n_i,
        vfat2_0_data_out_p_i    => vfat2_0_data_out_p_i,
        vfat2_0_data_out_n_i    => vfat2_0_data_out_n_i,
        vfat2_1_sbits_p_i       => vfat2_1_sbits_p_i,
        vfat2_1_sbits_n_i       => vfat2_1_sbits_n_i,
        vfat2_1_data_out_p_i    => vfat2_1_data_out_p_i,
        vfat2_1_data_out_n_i    => vfat2_1_data_out_n_i,
        vfat2_2_sbits_p_i       => vfat2_2_sbits_p_i,
        vfat2_2_sbits_n_i       => vfat2_2_sbits_n_i,
        vfat2_2_data_out_p_i    => vfat2_2_data_out_p_i,
        vfat2_2_data_out_n_i    => vfat2_2_data_out_n_i,
        vfat2_3_sbits_p_i       => vfat2_3_sbits_p_i,
        vfat2_3_sbits_n_i       => vfat2_3_sbits_n_i,
        vfat2_3_data_out_p_i    => vfat2_3_data_out_p_i,
        vfat2_3_data_out_n_i    => vfat2_3_data_out_n_i,
        vfat2_4_sbits_p_i       => vfat2_4_sbits_p_i,
        vfat2_4_sbits_n_i       => vfat2_4_sbits_n_i,
        vfat2_4_data_out_p_i    => vfat2_4_data_out_p_i,
        vfat2_4_data_out_n_i    => vfat2_4_data_out_n_i,
        vfat2_5_sbits_p_i       => vfat2_5_sbits_p_i,
        vfat2_5_sbits_n_i       => vfat2_5_sbits_n_i,
        vfat2_5_data_out_p_i    => vfat2_5_data_out_p_i,
        vfat2_5_data_out_n_i    => vfat2_5_data_out_n_i,
        vfat2_6_sbits_p_i       => vfat2_6_sbits_p_i,
        vfat2_6_sbits_n_i       => vfat2_6_sbits_n_i,
        vfat2_6_data_out_p_i    => vfat2_6_data_out_p_i,
        vfat2_6_data_out_n_i    => vfat2_6_data_out_n_i,
        vfat2_7_sbits_p_i       => vfat2_7_sbits_p_i,
        vfat2_7_sbits_n_i       => vfat2_7_sbits_n_i,
        vfat2_7_data_out_p_i    => vfat2_7_data_out_p_i,
        vfat2_7_data_out_n_i    => vfat2_7_data_out_n_i,
        vfat2_8_sbits_p_i       => vfat2_8_sbits_p_i,
        vfat2_8_sbits_n_i       => vfat2_8_sbits_n_i,
        vfat2_8_data_out_p_i    => vfat2_8_data_out_p_i,
        vfat2_8_data_out_n_i    => vfat2_8_data_out_n_i,
        vfat2_9_sbits_p_i       => vfat2_9_sbits_p_i,
        vfat2_9_sbits_n_i       => vfat2_9_sbits_n_i,
        vfat2_9_data_out_p_i    => vfat2_9_data_out_p_i,
        vfat2_9_data_out_n_i    => vfat2_9_data_out_n_i,
        vfat2_10_sbits_p_i      => vfat2_10_sbits_p_i,
        vfat2_10_sbits_n_i      => vfat2_10_sbits_n_i,
        vfat2_10_data_out_p_i   => vfat2_10_data_out_p_i,
        vfat2_10_data_out_n_i   => vfat2_10_data_out_n_i,
        vfat2_11_sbits_p_i      => vfat2_11_sbits_p_i,
        vfat2_11_sbits_n_i      => vfat2_11_sbits_n_i,
        vfat2_11_data_out_p_i   => vfat2_11_data_out_p_i,
        vfat2_11_data_out_n_i   => vfat2_11_data_out_n_i,
        vfat2_12_sbits_p_i      => vfat2_12_sbits_p_i,
        vfat2_12_sbits_n_i      => vfat2_12_sbits_n_i,
        vfat2_12_data_out_p_i   => vfat2_12_data_out_p_i,
        vfat2_12_data_out_n_i   => vfat2_12_data_out_n_i,
        vfat2_13_sbits_p_i      => vfat2_13_sbits_p_i,
        vfat2_13_sbits_n_i      => vfat2_13_sbits_n_i,
        vfat2_13_data_out_p_i   => vfat2_13_data_out_p_i,
        vfat2_13_data_out_n_i   => vfat2_13_data_out_n_i,
        vfat2_14_sbits_p_i      => vfat2_14_sbits_p_i,
        vfat2_14_sbits_n_i      => vfat2_14_sbits_n_i,
        vfat2_14_data_out_p_i   => vfat2_14_data_out_p_i,
        vfat2_14_data_out_n_i   => vfat2_14_data_out_n_i,
        vfat2_15_sbits_p_i      => vfat2_15_sbits_p_i,
        vfat2_15_sbits_n_i      => vfat2_15_sbits_n_i,
        vfat2_15_data_out_p_i   => vfat2_15_data_out_p_i,
        vfat2_15_data_out_n_i   => vfat2_15_data_out_n_i,
        vfat2_16_sbits_p_i      => vfat2_16_sbits_p_i,
        vfat2_16_sbits_n_i      => vfat2_16_sbits_n_i,
        vfat2_16_data_out_p_i   => vfat2_16_data_out_p_i,
        vfat2_16_data_out_n_i   => vfat2_16_data_out_n_i,
        vfat2_17_sbits_p_i      => vfat2_17_sbits_p_i,
        vfat2_17_sbits_n_i      => vfat2_17_sbits_n_i,
        vfat2_17_data_out_p_i   => vfat2_17_data_out_p_i,
        vfat2_17_data_out_n_i   => vfat2_17_data_out_n_i,
        vfat2_18_sbits_p_i      => vfat2_18_sbits_p_i,
        vfat2_18_sbits_n_i      => vfat2_18_sbits_n_i,
        vfat2_18_data_out_p_i   => vfat2_18_data_out_p_i,
        vfat2_18_data_out_n_i   => vfat2_18_data_out_n_i,
        vfat2_19_sbits_p_i      => vfat2_19_sbits_p_i,
        vfat2_19_sbits_n_i      => vfat2_19_sbits_n_i,
        vfat2_19_data_out_p_i   => vfat2_19_data_out_p_i,
        vfat2_19_data_out_n_i   => vfat2_19_data_out_n_i,
        vfat2_20_sbits_p_i      => vfat2_20_sbits_p_i,
        vfat2_20_sbits_n_i      => vfat2_20_sbits_n_i,
        vfat2_20_data_out_p_i   => vfat2_20_data_out_p_i,
        vfat2_20_data_out_n_i   => vfat2_20_data_out_n_i,
        vfat2_21_sbits_p_i      => vfat2_21_sbits_p_i,
        vfat2_21_sbits_n_i      => vfat2_21_sbits_n_i,
        vfat2_21_data_out_p_i   => vfat2_21_data_out_p_i,
        vfat2_21_data_out_n_i   => vfat2_21_data_out_n_i,
        vfat2_22_sbits_p_i      => vfat2_22_sbits_p_i,
        vfat2_22_sbits_n_i      => vfat2_22_sbits_n_i,
        vfat2_22_data_out_p_i   => vfat2_22_data_out_p_i,
        vfat2_22_data_out_n_i   => vfat2_22_data_out_n_i,
        vfat2_23_sbits_p_i      => vfat2_23_sbits_p_i,
        vfat2_23_sbits_n_i      => vfat2_23_sbits_n_i,
        vfat2_23_data_out_p_i   => vfat2_23_data_out_p_i,
        vfat2_23_data_out_n_i   => vfat2_23_data_out_n_i,
        --
        vfat2_mclk_i            => vfat2_mclk_b,
        vfat2_reset_i           => vfat2_reset_b,
        vfat2_t1_i              => vfat2_t1_b,
        vfat2_scl_i             => vfat2_scl_b,
        vfat2_sda_miso_o        => vfat2_sda_miso_b, 
        vfat2_sda_mosi_i        => vfat2_sda_mosi_b,
        vfat2_sda_tri_i         => vfat2_sda_tri_b,
        vfat2_data_valid_o      => vfat2_data_valid_b,
        vfat2_data_out_o        => vfat2_data_out_b,
        vfat2_sbits_o           => vfat2_sbits_b,
        -- Clocking
        qpll_clk_p_i            => qpll_clk_p_i,
        qpll_clk_n_i            => qpll_clk_n_i,
        qpll_reset_o            => qpll_reset_o,
        qpll_locked_i           => qpll_locked_i,
        --
        qpll_clk_o              => qpll_clk_b,
        qpll_reset_i            => qpll_reset_b,
        qpll_locked_o           => qpll_locked_b,
        qpll_pll_locked_o       => qpll_pll_locked_b
    );
 
end Behavioral;
