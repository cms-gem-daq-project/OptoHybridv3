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
    
--    vfat2_daco_v_i          : in std_logic_vector(2 downto 0);
--    vfat2_daco_i_i          : in std_logic_vector(2 downto 0);
    
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
    
--    tmds_d_p_io             : inout std_logic_vector(2 downto 0);
--    tmds_d_n_io             : inout std_logic_vector(2 downto 0);
--
--    tmds_clk_p_io           : inout std_logic;
--    tmds_clk_n_io           : inout std_logic;

    ext_clk_i               : in std_logic;
    ext_trigger_i           : in std_logic;
    ext_sbits_o             : out std_logic_vector(5 downto 0);
    
    header_io               : in std_logic_vector(15 downto 0);
       
    --== GTX ==--
    
    mgt_clk_p_i             : in std_logic;
    mgt_clk_n_i             : in std_logic;
    
    -- the first link is the track and control link, the other 4 are the trigger links TODO: make different name for trigger links
    mgt_rx_p_i        : in std_logic_vector(4 downto 0);
    mgt_rx_n_i        : in std_logic_vector(4 downto 0);
    mgt_tx_p_o        : out std_logic_vector(4 downto 0);
    mgt_tx_n_o        : out std_logic_vector(4 downto 0)

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
    
    signal vfat_sbit_clusters   : sbit_cluster_array_t(7 downto 0);
    
    --== Global signals ==--

    signal ref_clk              : std_logic;
    signal reset                : std_logic;    

    --== GTX ==--
    
    signal gtx_clk              : std_logic;   
    signal gtx_rec_clk          : std_logic;   
    signal gtx_tk_error         : std_logic;
    signal gtx_tr_error         : std_logic;
    signal gtx_evt_sent         : std_logic;
    
    signal gtx_tx_kchar         : std_logic_vector(5 downto 0);
    signal gtx_tx_data          : std_logic_vector(47 downto 0);
    signal gtx_rx_kchar         : std_logic_vector(1 downto 0);
    signal gtx_rx_data          : std_logic_vector(15 downto 0);
    signal gtx_rx_error         : std_logic_vector(0 downto 0);
    
    --== VFAT2 ==--
    
    signal vfat2_t1             : t1_array_t(2 downto 0);
    signal vfat2_t1_lst         : t1_array_t(4 downto 0);
    signal vfat2_tk_data        : tk_data_array_t(23 downto 0);
    
    --== System ==--
    
    signal vfat2_tk_mask        : std_logic_vector(23 downto 0);
    signal vfat2_t1_sel         : std_logic_vector(2 downto 0);
    signal sys_loop_sbit        : std_logic_vector(4 downto 0);
    signal vfat2_reset          : std_logic;
    signal vfat2_sbit_mask      : std_logic_vector(23 downto 0);
    signal sys_sbit_sel         : std_logic_vector(29 downto 0);
    signal trigger_lim          : std_logic_vector(31 downto 0);
    signal zero_suppress        : std_logic;
    
    --== Wishbone signals ==--
    
    signal wb_m_req             : wb_req_array_t((WB_MASTERS - 1) downto 0);
    signal wb_m_res             : wb_res_array_t((WB_MASTERS - 1) downto 0);
    signal wb_s_req             : wb_req_array_t((WB_SLAVES - 1) downto 0);
    signal wb_s_res             : wb_res_array_t((WB_SLAVES - 1) downto 0);
    
    --== ChipScope ==--    
    
    signal CONTROL0 : STD_LOGIC_VECTOR(35 DOWNTO 0);
    signal CONTROL1 : STD_LOGIC_VECTOR(35 DOWNTO 0);
    signal TRIG0 : STD_LOGIC_VECTOR(191 DOWNTO 0);
    signal SYNC_IN : STD_LOGIC_VECTOR(36 DOWNTO 0);
    signal SYNC_OUT : STD_LOGIC_VECTOR(65 DOWNTO 0);
        
begin

    reset <= '0';
    
    --==============--
    --== Clocking ==--
    --==============--
    
    ref_clk <= qpll_clk_b;
    
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
        sys_sbit_sel_i      => sys_sbit_sel,
        ext_sbits_o         => ext_sbits_o        
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
		mgt_refclk_n_i  => mgt_clk_n_i,
		mgt_refclk_p_i  => mgt_clk_p_i,
        ref_clk_i       => ref_clk,
		reset_i         => reset,
        gtx_clk_o       => gtx_clk,
        rec_clk_o       => gtx_rec_clk,
        gtx_tx_kchar_i  => gtx_tx_kchar,
        gtx_tx_data_i   => gtx_tx_data,
        gtx_rx_kchar_o  => gtx_rx_kchar,
        gtx_rx_data_o   => gtx_rx_data,
        gtx_rx_error_o  => gtx_rx_error,     
		rx_n_i          => mgt_rx_n_i,
		rx_p_i          => mgt_rx_p_i,
		tx_n_o          => mgt_tx_n_o,
		tx_p_o          => mgt_tx_p_o
	);
    
    --==========--
    --== Link ==--
    --==========--
    
    -- This module controls the DATA of the GTX. It formats data packets to be sent over the optical link.

    link_inst : entity work.link
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
        vfat2_t1_i      => vfat2_t1_lst(4),
        vfat2_t1_o      => vfat2_t1(0), 
        tk_error_o      => gtx_tk_error,
        tr_error_o      => gtx_tr_error,
        evt_sent_o      => gtx_evt_sent,
        sbit_clusters_i => vfat_sbit_clusters        
    );

    --===========--
    --== VFAT2 ==--
    --===========--
    
    -- This module controls the low-level VFAT2 functionnalities.
        
    vfat2_inst : entity work.vfat2      
    port map(        
        ref_clk_i           => ref_clk,
        reset_i             => reset,
        vfat2_reset_i       => vfat2_reset,
        vfat2_t1_lst_i      => vfat2_t1,
        vfat2_t1_lst_o      => vfat2_t1_lst,
        vfat2_t1_sel_i      => vfat2_t1_sel,
        trigger_lim_i       => trigger_lim,
        vfat2_mclk_o        => vfat2_mclk_b,
        vfat2_reset_o       => vfat2_reset_b,
        vfat2_t1_o          => vfat2_t1_b,
        vfat2_data_out_i    => vfat2_data_out_b,
        vfat2_tk_data_o     => vfat2_tk_data,
        vfat2_sbits_i       => vfat2_sbits_b,
        sys_loop_sbit_i     => sys_loop_sbit,
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
        
    vfat2_func_inst : entity work.vfat2_func      
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
    
--    adc_inst : entity work.adc
--    port map(
--        ref_clk_i       => ref_clk,
--        reset_i         => reset,
--        wb_slv_req_i    => wb_s_req(WB_SLV_ADC),
--        wb_slv_res_o    => wb_s_res(WB_SLV_ADC),
--        xadc_p_i        => xadc_p_i,
--        xadc_n_i        => xadc_n_i
--    );
            
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
        vfat2_t1_i          => vfat2_t1_lst,
        gtx_tk_error_i      => gtx_tk_error,
        gtx_tr_error_i      => gtx_tr_error,
        gtx_evt_sent_i      => gtx_evt_sent,
        qpll_locked_i       => qpll_locked_b,
        qpll_pll_locked_i   => qpll_pll_locked_b
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
        zero_suppress_o     => zero_suppress
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
        qpll_pll_locked_i   => qpll_pll_locked_b
    );
    
    --=========================--
    --== SBit cluster packer ==--
    --=========================--
    
    -- This module handles the SBits
    sbits_inst : entity work.sbits
    port map(        
        ref_clk_i               => gtx_clk,
        reset_i                 => reset,        
        vfat2_sbits_i           => vfat2_sbits_b,  
        vfat2_sbit_mask_i       => vfat2_sbit_mask,        
        vfat_sbit_clusters_o    => vfat_sbit_clusters
    );

    chipscope_icon_inst : entity work.chipscope_icon
    port map(
        CONTROL0    => CONTROL0,
        CONTROL1    => CONTROL1
    );
    
    chipscope_ila_inst : entity work.chipscope_ila
    port map(
        CONTROL => CONTROL0,
        CLK     => ref_clk,
        TRIG0   => TRIG0
    );
    
    chipscope_vio_inst : entity work.chipscope_vio
    port map(
        CONTROL     => CONTROL1,
        CLK         => ref_clk,
        SYNC_IN     => SYNC_IN,
        SYNC_OUT    => SYNC_OUT
    );
    
    gen_con : for I in 0 to 23 generate
    begin
        TRIG0(((I + 1) * 8 - 1) downto (I * 8)) <= vfat2_sbits_b(I);
    end generate;
    
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
        vfat2_0_sbits_p_i		=> vfat2_0_sbits_p_i,
        vfat2_0_sbits_n_i		=> vfat2_0_sbits_n_i,
        vfat2_0_data_out_p_i	=> vfat2_0_data_out_p_i,
        vfat2_0_data_out_n_i	=> vfat2_0_data_out_n_i,
        vfat2_1_sbits_p_i		=> vfat2_1_sbits_p_i,
        vfat2_1_sbits_n_i		=> vfat2_1_sbits_n_i,
        vfat2_1_data_out_p_i	=> vfat2_1_data_out_p_i,
        vfat2_1_data_out_n_i	=> vfat2_1_data_out_n_i,
        vfat2_2_sbits_p_i		=> vfat2_2_sbits_p_i,
        vfat2_2_sbits_n_i		=> vfat2_2_sbits_n_i,
        vfat2_2_data_out_p_i	=> vfat2_2_data_out_p_i,
        vfat2_2_data_out_n_i	=> vfat2_2_data_out_n_i,
        vfat2_3_sbits_p_i		=> vfat2_3_sbits_p_i,
        vfat2_3_sbits_n_i		=> vfat2_3_sbits_n_i,
        vfat2_3_data_out_p_i	=> vfat2_3_data_out_p_i,
        vfat2_3_data_out_n_i	=> vfat2_3_data_out_n_i,
        vfat2_4_sbits_p_i		=> vfat2_4_sbits_p_i,
        vfat2_4_sbits_n_i		=> vfat2_4_sbits_n_i,
        vfat2_4_data_out_p_i	=> vfat2_4_data_out_p_i,
        vfat2_4_data_out_n_i	=> vfat2_4_data_out_n_i,
        vfat2_5_sbits_p_i		=> vfat2_5_sbits_p_i,
        vfat2_5_sbits_n_i		=> vfat2_5_sbits_n_i,
        vfat2_5_data_out_p_i	=> vfat2_5_data_out_p_i,
        vfat2_5_data_out_n_i	=> vfat2_5_data_out_n_i,
        vfat2_6_sbits_p_i		=> vfat2_6_sbits_p_i,
        vfat2_6_sbits_n_i		=> vfat2_6_sbits_n_i,
        vfat2_6_data_out_p_i	=> vfat2_6_data_out_p_i,
        vfat2_6_data_out_n_i	=> vfat2_6_data_out_n_i,
        vfat2_7_sbits_p_i		=> vfat2_7_sbits_p_i,
        vfat2_7_sbits_n_i		=> vfat2_7_sbits_n_i,
        vfat2_7_data_out_p_i	=> vfat2_7_data_out_p_i,
        vfat2_7_data_out_n_i	=> vfat2_7_data_out_n_i,
        vfat2_8_sbits_p_i		=> vfat2_8_sbits_p_i,
        vfat2_8_sbits_n_i		=> vfat2_8_sbits_n_i,
        vfat2_8_data_out_p_i	=> vfat2_8_data_out_p_i,
        vfat2_8_data_out_n_i	=> vfat2_8_data_out_n_i,
        vfat2_9_sbits_p_i		=> vfat2_9_sbits_p_i,
        vfat2_9_sbits_n_i		=> vfat2_9_sbits_n_i,
        vfat2_9_data_out_p_i	=> vfat2_9_data_out_p_i,
        vfat2_9_data_out_n_i	=> vfat2_9_data_out_n_i,
        vfat2_10_sbits_p_i		=> vfat2_10_sbits_p_i,
        vfat2_10_sbits_n_i		=> vfat2_10_sbits_n_i,
        vfat2_10_data_out_p_i	=> vfat2_10_data_out_p_i,
        vfat2_10_data_out_n_i	=> vfat2_10_data_out_n_i,
        vfat2_11_sbits_p_i		=> vfat2_11_sbits_p_i,
        vfat2_11_sbits_n_i		=> vfat2_11_sbits_n_i,
        vfat2_11_data_out_p_i	=> vfat2_11_data_out_p_i,
        vfat2_11_data_out_n_i	=> vfat2_11_data_out_n_i,
        vfat2_12_sbits_p_i		=> vfat2_12_sbits_p_i,
        vfat2_12_sbits_n_i		=> vfat2_12_sbits_n_i,
        vfat2_12_data_out_p_i	=> vfat2_12_data_out_p_i,
        vfat2_12_data_out_n_i	=> vfat2_12_data_out_n_i,
        vfat2_13_sbits_p_i		=> vfat2_13_sbits_p_i,
        vfat2_13_sbits_n_i		=> vfat2_13_sbits_n_i,
        vfat2_13_data_out_p_i	=> vfat2_13_data_out_p_i,
        vfat2_13_data_out_n_i	=> vfat2_13_data_out_n_i,
        vfat2_14_sbits_p_i		=> vfat2_14_sbits_p_i,
        vfat2_14_sbits_n_i		=> vfat2_14_sbits_n_i,
        vfat2_14_data_out_p_i	=> vfat2_14_data_out_p_i,
        vfat2_14_data_out_n_i	=> vfat2_14_data_out_n_i,
        vfat2_15_sbits_p_i		=> vfat2_15_sbits_p_i,
        vfat2_15_sbits_n_i		=> vfat2_15_sbits_n_i,
        vfat2_15_data_out_p_i	=> vfat2_15_data_out_p_i,
        vfat2_15_data_out_n_i	=> vfat2_15_data_out_n_i,
        vfat2_16_sbits_p_i		=> vfat2_16_sbits_p_i,
        vfat2_16_sbits_n_i		=> vfat2_16_sbits_n_i,
        vfat2_16_data_out_p_i	=> vfat2_16_data_out_p_i,
        vfat2_16_data_out_n_i	=> vfat2_16_data_out_n_i,
        vfat2_17_sbits_p_i		=> vfat2_17_sbits_p_i,
        vfat2_17_sbits_n_i		=> vfat2_17_sbits_n_i,
        vfat2_17_data_out_p_i	=> vfat2_17_data_out_p_i,
        vfat2_17_data_out_n_i	=> vfat2_17_data_out_n_i,
        vfat2_18_sbits_p_i		=> vfat2_18_sbits_p_i,
        vfat2_18_sbits_n_i		=> vfat2_18_sbits_n_i,
        vfat2_18_data_out_p_i	=> vfat2_18_data_out_p_i,
        vfat2_18_data_out_n_i	=> vfat2_18_data_out_n_i,
        vfat2_19_sbits_p_i		=> vfat2_19_sbits_p_i,
        vfat2_19_sbits_n_i		=> vfat2_19_sbits_n_i,
        vfat2_19_data_out_p_i	=> vfat2_19_data_out_p_i,
        vfat2_19_data_out_n_i	=> vfat2_19_data_out_n_i,
        vfat2_20_sbits_p_i		=> vfat2_20_sbits_p_i,
        vfat2_20_sbits_n_i		=> vfat2_20_sbits_n_i,
        vfat2_20_data_out_p_i	=> vfat2_20_data_out_p_i,
        vfat2_20_data_out_n_i	=> vfat2_20_data_out_n_i,
        vfat2_21_sbits_p_i		=> vfat2_21_sbits_p_i,
        vfat2_21_sbits_n_i		=> vfat2_21_sbits_n_i,
        vfat2_21_data_out_p_i	=> vfat2_21_data_out_p_i,
        vfat2_21_data_out_n_i	=> vfat2_21_data_out_n_i,
        vfat2_22_sbits_p_i		=> vfat2_22_sbits_p_i,
        vfat2_22_sbits_n_i		=> vfat2_22_sbits_n_i,
        vfat2_22_data_out_p_i	=> vfat2_22_data_out_p_i,
        vfat2_22_data_out_n_i	=> vfat2_22_data_out_n_i,
        vfat2_23_sbits_p_i		=> vfat2_23_sbits_p_i,
        vfat2_23_sbits_n_i		=> vfat2_23_sbits_n_i,
        vfat2_23_data_out_p_i	=> vfat2_23_data_out_p_i,
        vfat2_23_data_out_n_i	=> vfat2_23_data_out_n_i,
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
        -- QPLL
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
