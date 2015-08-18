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
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
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
    
--    eprom_data_i            : inout std_logic_vector(7 downto 0);
--    eprom_clk_o             : out std_logic;
--    eprom_reset_b_o         : out std_logic;
--    eprom_chip_enable_b_o   : out std_logic;
--    eprom_tdi_o             : out std_logic;
--    eprom_tdo_i             : in std_logic;
--    eprom_tms_o             : out std_logic;
--    eprom_tck_o             : out std_logic;
    
    --== Clocking ==--
    
    clk_50MHz_i             : in std_logic;

    qpll_ref_40MHz_o        : out std_logic;
    qpll_reset_o            : out std_logic;
    qpll_locked_i           : in std_logic;
    qpll_error_i            : in std_logic;
    qpll_clk_p_i            : in std_logic;
    qpll_clk_n_i            : in std_logic;

    cdce_clk_p_i            : in std_logic;
    cdce_clk_n_i            : in std_logic;
    cdce_clk_pri_p_o        : out std_logic;
    cdce_clk_pri_n_o        : out std_logic;
    cdce_aux_out_o          : out std_logic;
    cdce_aux_in_i           : in std_logic;
    cdce_ref_o              : out std_logic;
    cdce_pwrdown_o          : out std_logic;
    cdce_sync_o             : out std_logic;
    cdce_locked_i           : in std_logic;
    cdce_sck_o              : out std_logic;
    cdce_mosi_o             : out std_logic;
    cdce_le_o               : out std_logic;
    cdce_miso_i             : in std_logic;
    
    --== Miscellaneous ==--

    adc_chip_select_o       : out std_logic;
    adc_din_i               : in std_logic;
    adc_dout_o              : out std_logic;
    adc_clk_o               : out std_logic;
    adc_eoc_i               : in std_logic;

    temp_clk_o              : out std_logic;
    temp_data_io            : inout std_logic;

    chipid_io               : inout std_logic
    
--    hdmi_scl_io             : inout std_logic_vector(1 downto 0);
--    hdmi_sda_io             : inout std_logic_vector(1 downto 0);
--
--    tmds_d_p_io             : inout std_logic_vector(1 downto 0);
--    tmds_d_n_io             : inout std_logic_vector(1 downto 0);
--
--    tmds_clk_p_io           : inout std_logic;
--    tmds_clk_n_io           : inout std_logic;
       
    --== GTX ==--
    
--    mgt_112_clk0_p_i        : in std_logic;
--    mgt_112_clk0_n_i        : in std_logic;
    
--    mgt_116_clk1_p_i        : in std_logic;
--    mgt_116_clk1_n_i        : in std_logic;
    
--    mgt_112_rx_p_i          : in std_logic_vector(3 downto 0);
--    mgt_112_rx_n_i          : in std_logic_vector(3 downto 0);
--    mgt_112_tx_p_o          : out std_logic_vector(3 downto 0);
--    mgt_112_tx_n_o          : out std_logic_vector(3 downto 0)
    
--    mgt_113_rx_p_i          : in std_logic_vector(3 downto 0);
--    mgt_113_rx_n_i          : in std_logic_vector(3 downto 0);
--    mgt_113_tx_p_o          : out std_logic_vector(3 downto 0);
--    mgt_113_tx_n_o          : out std_logic_vector(3 downto 0);
    
--    mgt_114_rx_p_i          : in std_logic_vector(3 downto 0);
--    mgt_114_rx_n_i          : in std_logic_vector(3 downto 0);
--    mgt_114_tx_p_o          : out std_logic_vector(3 downto 0);
--    mgt_114_tx_n_o          : out std_logic_vector(3 downto 0);
    
--    mgt_115_rx_p_i          : in std_logic_vector(3 downto 0);
--    mgt_115_rx_n_i          : in std_logic_vector(3 downto 0);
--    mgt_115_tx_p_o          : out std_logic_vector(3 downto 0);
--    mgt_115_tx_n_o          : out std_logic_vector(3 downto 0);
    
--    mgt_116_rx_p_i          : in std_logic_vector(3 downto 0);
--    mgt_116_rx_n_i          : in std_logic_vector(3 downto 0);
--    mgt_116_tx_p_o          : out std_logic_vector(3 downto 0);
--    mgt_116_tx_n_o          : out std_logic_vector(3 downto 0)

);
end optohybrid_top;

architecture Behavioral of optohybrid_top is

    --== Global signals ==--

    signal ref_clk              : std_logic;
    signal reset                : std_logic;

    --== VFAT2 signals ==--
    
    signal vfat2_mclk           : std_logic; -- VFAT2 refenrece clock (should be the same as the LHC clock)
    signal vfat2_reset          : std_logic;
    signal vfat2_t1             : std_logic;
    signal vfat2_scl            : std_logic_vector(5 downto 0); 
    signal vfat2_sda_mosi       : std_logic_vector(5 downto 0); 
    signal vfat2_sda_miso       : std_logic_vector(5 downto 0); 
    signal vfat2_sda_tri        : std_logic_vector(5 downto 0); 
    signal vfat2_data_valid     : std_logic_vector(5 downto 0);
    signal vfat2_data_out       : std_logic_vector(23 downto 0);
    signal vfat2_sbits          : sbits_array_t(23 downto 0);
    
    --== ADC signals ==--
    
    signal adc_clk              : std_logic;
    signal adc_chip_select      : std_logic;
    signal adc_dout             : std_logic;
    signal adc_din              : std_logic;
    signal adc_eoc              : std_logic;    
    
    --== CDCE signals ==--

    signal cdce_clk             : std_logic;
    signal cdce_clk_pri         : std_logic;
    signal cdce_aux_out         : std_logic;
    signal cdce_aux_in          : std_logic;
    signal cdce_ref             : std_logic;
    signal cdce_pwrdown         : std_logic;
    signal cdce_sync            : std_logic;
    signal cdce_locked          : std_logic;
    signal cdce_sck             : std_logic;
    signal cdce_mosi            : std_logic;
    signal cdce_le              : std_logic;
    signal cdce_miso            : std_logic;    
    
    --== Chip ID signals ==--

    signal chipid_mosi          : std_logic;
    signal chipid_miso          : std_logic;
    signal chipid_tri           : std_logic;

    
    --== QPLL signals ==--

    signal qpll_ref_40MHz       : std_logic;
    signal qpll_reset           : std_logic;
    signal qpll_locked          : std_logic;
    signal qpll_error           : std_logic;
    signal qpll_clk             : std_logic;
    
    --== Temperature signals ==--

    signal temp_clk             : std_logic;
    signal temp_data_mosi       : std_logic;
    signal temp_data_miso       : std_logic;
    signal temp_data_tri        : std_logic;
    
    --== Wishbone signals ==--
    
    signal wb_clk               : std_logic;
    
    -- Masters
    signal wb_m_req             : wb_req_array_t((WB_MASTERS - 1) downto 0);
    signal wb_m_res             : wb_res_array_t((WB_MASTERS - 1) downto 0);
    
    alias wb_mst_gtx_req        : wb_req_array_t(2 downto 0) is wb_m_req(WB_MST_GTX_2 downto WB_MST_GTX_0);
    alias wb_mst_gtx_res        : wb_res_array_t(2 downto 0) is wb_m_res(WB_MST_GTX_2 downto WB_MST_GTX_0);
    alias wb_mst_scan_req       : wb_req_array_t(5 downto 0) is wb_m_req(WB_MST_SCAN_5 downto WB_MST_SCAN_0);
    alias wb_mst_scan_res       : wb_res_array_t(5 downto 0) is wb_m_res(WB_MST_SCAN_5 downto WB_MST_SCAN_0);
    
    -- Slaves
    signal wb_s_req             : wb_req_array_t((WB_SLAVES - 1) downto 0);
    signal wb_s_res             : wb_res_array_t((WB_SLAVES - 1) downto 0);
    
    alias wb_slv_i2c_req        : wb_req_array_t(5 downto 0) is wb_s_req(WB_SLV_I2C_5 downto WB_SLV_I2C_0);
    alias wb_slv_i2c_res        : wb_res_array_t(5 downto 0) is wb_s_res(WB_SLV_I2C_5 downto WB_SLV_I2C_0);
    alias wb_slv_scan_req       : wb_req_array_t(5 downto 0) is wb_s_req(WB_SLV_SCAN_5 downto WB_SLV_SCAN_0);
    alias wb_slv_scan_res       : wb_res_array_t(5 downto 0) is wb_s_res(WB_SLV_SCAN_5 downto WB_SLV_SCAN_0);
    alias wb_slv_t1_req         : wb_req_t is wb_s_req(WB_SLV_T1);
    alias wb_slv_t1_res         : wb_res_t is wb_s_res(WB_SLV_T1);
    
    --== Chipscope signals ==--
    
    signal cs_clk               : std_logic; -- ChipScope clock
    signal cs_ctrl0             : std_logic_vector(35 downto 0);
    signal cs_ctrl1             : std_logic_vector(35 downto 0); 
    signal cs_sync_in           : std_logic_vector(34 downto 0);
    signal cs_sync_out          : std_logic_vector(65 downto 0);
    signal cs_trig0             : std_logic_vector(31 downto 0);
    
    -- Tracking data
    signal vfat2_tk_data        : tk_data_array_t(23 downto 0);
    
begin

    reset <= '0';
    vfat2_reset <= '1';
    
    ref_clk <= qpll_clk;
    wb_clk <= qpll_clk;
    vfat2_mclk <= qpll_clk;
    
    --=====================--
    --== Wishbone switch ==--
    --=====================--
    
    wb_switch_inst : entity work.wb_switch
    port map(
        wb_clk_i    => wb_clk,
        reset_i     => reset,
        wb_m_req_i  => wb_m_req,
        wb_s_req_o  => wb_s_req,
        wb_s_res_i  => wb_s_res,
        wb_m_res_o  => wb_m_res
    );

    --===========--
    --== VFAT2 ==--
    --===========--
        
    vfat2_inst : entity work.vfat2      
    port map(        
        ref_clk_i           => ref_clk,
        reset_i             => reset,
        wb_slv_t1_req_i     => wb_slv_t1_req,
        wb_slv_t1_res_o     => wb_slv_t1_res,
        wb_slv_i2c_req_i    => wb_slv_i2c_req,
        wb_slv_i2c_res_o    => wb_slv_i2c_res,
        wb_slv_scan_req_i   => wb_slv_scan_req,
        wb_slv_scan_res_o   => wb_slv_scan_res,
        wb_mst_scan_req_o   => wb_mst_scan_req,
        wb_mst_scan_res_i   => wb_mst_scan_res,
        vfat2_mclk_o        => vfat2_mclk,
        vfat2_t1_o          => vfat2_t1,
        vfat2_reset_o       => vfat2_reset,
        vfat2_data_out_i    => vfat2_data_out,
        vfat2_sbits_i       => vfat2_sbits,
        vfat2_scl_o         => vfat2_scl,
        vfat2_sda_miso_i    => vfat2_sda_miso,
        vfat2_sda_mosi_o    => vfat2_sda_mosi,
        vfat2_sda_tri_o     => vfat2_sda_tri,
        vfat2_tk_data_o     => vfat2_tk_data
    );    
    
    --============--
    --== VFAT2s ==--
    --============--
    
--    vfat2_inst : entity work.vfat2
--    port map(     
--    ); 
    
    --=========--
    --== ADC ==--
    --=========--
    
--    adc_inst : entity work.adc
--    port map(
--    );

    --==========--
    --== CDCE ==--
    --==========--
    
--    cdce_inst : entity work.cdce
--    port map(
--    );

    --=============--
    --== Chip ID ==--
    --=============--
    
--    chipid_inst : entity work.chipid
--    port map(
--    );

    --==========--
    --== QPLL ==--
    --==========--
    
--    qpll_inst : entity work.qpll
--    port map(
--    );
    
    --=================--
    --== Temperature ==--
    --=================--
    
--    temp_inst : entity work.temp
--    port map(
--    );
    
    --===============--
    --== ChipScope ==--
    --===============--
    
    cs_clk <= qpll_clk;
    
    chipscope_icon_inst : entity work.chipscope_icon
    port map(
        control0    => cs_ctrl0,
        control1    => cs_ctrl1
    );
    
    chipscope_vio_inst : entity work.chipscope_vio
    port map(
        control     => cs_ctrl0,
        clk         => cs_clk,
        sync_in     => cs_sync_in,
        sync_out    => cs_sync_out
    );
    
    chipscope_ila_inst : entity work.chipscope_ila
    port map(
        control => cs_ctrl1,
        clk     => cs_clk,
        trig0   => cs_trig0
    );
    
    --===========--
    --== DEBUG ==--
    --===========--
    
    process(qpll_clk)
        variable s : std_logic;
    begin
        if (rising_edge(qpll_clk)) then
            if (reset = '1') then
                s := '0';
                wb_mst_gtx_req(0).stb <= '0'; 
            else
                if (s = '0' and cs_sync_out(65) = '1') then
                    wb_mst_gtx_req(0) <= (stb   => cs_sync_out(65),
                                          we    => cs_sync_out(64),
                                          addr  => cs_sync_out(31 downto 0),
                                          data  => cs_sync_out(63 downto 32));
                else
                    wb_mst_gtx_req(0).stb <= '0'; 
                end if;
                s := cs_sync_out(65);
            end if;
        end if; 
    end process;
    
    cs_sync_in <= wb_mst_gtx_res(0).ack & wb_mst_gtx_res(0).stat & wb_mst_gtx_res(0).data;
    
    cs_trig0 <= (0 => vfat2_data_out(1), 1 => vfat2_tk_data(0).valid, others => '0');
    
    --=============--
    --== Buffers ==--
    --=============--
    
    -- This entity is placed at the end of the file for readability reasons
    
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
        vfat2_mclk_i            => vfat2_mclk,
        vfat2_reset_i           => vfat2_reset,
        vfat2_t1_i              => vfat2_t1,
        vfat2_scl_i             => vfat2_scl,
        vfat2_sda_miso_o        => vfat2_sda_miso, 
        vfat2_sda_mosi_i        => vfat2_sda_mosi,
        vfat2_sda_tri_i         => vfat2_sda_tri,
        vfat2_data_valid_o      => vfat2_data_valid,
        vfat2_data_out_o        => vfat2_data_out,
        vfat2_sbits_o           => vfat2_sbits,
        -- ADC
        adc_clk_o               => adc_clk_o,
        adc_chip_select_o       => adc_chip_select_o,
        adc_dout_o              => adc_dout_o,
        adc_din_i               => adc_din_i,
        adc_eoc_i               => adc_eoc_i,
        --
        adc_clk_i               => adc_clk,
        adc_chip_select_i       => adc_chip_select,
        adc_dout_i              => adc_dout,
        adc_din_o               => adc_din,
        adc_eoc_o               => adc_eoc,
        -- CDCE
        cdce_clk_p_i            => cdce_clk_p_i,
        cdce_clk_n_i            => cdce_clk_n_i,
        cdce_clk_pri_p_o        => cdce_clk_pri_p_o,
        cdce_clk_pri_n_o        => cdce_clk_pri_n_o,
        cdce_aux_out_o          => cdce_aux_out_o,
        cdce_aux_in_i           => cdce_aux_in_i,
        cdce_ref_o              => cdce_ref_o,
        cdce_pwrdown_o          => cdce_pwrdown_o,
        cdce_sync_o             => cdce_sync_o,
        cdce_locked_i           => cdce_locked_i,
        cdce_sck_o              => cdce_sck_o,
        cdce_mosi_o             => cdce_mosi_o,
        cdce_le_o               => cdce_le_o,
        cdce_miso_i             => cdce_miso_i,
        -- 
        cdce_clk_o              => cdce_clk,
        cdce_clk_pri_i          => cdce_clk_pri,
        cdce_aux_out_i          => cdce_aux_out,
        cdce_aux_in_o           => cdce_aux_in,
        cdce_ref_i              => cdce_ref,
        cdce_pwrdown_i          => cdce_pwrdown,
        cdce_sync_i             => cdce_sync,
        cdce_locked_o           => cdce_locked,
        cdce_sck_i              => cdce_sck,
        cdce_mosi_i             => cdce_mosi,
        cdce_le_i               => cdce_le,
        cdce_miso_o             => cdce_miso,
        -- ChipID
        chipid_io               => chipid_io,
        -- 
        chipid_mosi_i           => chipid_mosi,
        chipid_miso_o           => chipid_miso,
        chipid_tri_i            => chipid_tri,
        -- QPLL
        qpll_ref_40MHz_o        => qpll_ref_40MHz_o,
        qpll_reset_o            => qpll_reset_o,
        qpll_locked_i           => qpll_locked_i,
        qpll_error_i            => qpll_error_i,
        qpll_clk_p_i            => qpll_clk_p_i,
        qpll_clk_n_i            => qpll_clk_n_i,
        --
        qpll_ref_40MHz_i        => qpll_ref_40MHz,
        qpll_reset_i            => qpll_reset,
        qpll_locked_o           => qpll_locked,
        qpll_error_o            => qpll_error,
        qpll_clk_o              => qpll_clk,
        -- Temperature
        temp_clk_o              => temp_clk_o,
        temp_data_io            => temp_data_io,
        --
        temp_clk_i              => temp_clk,
        temp_data_mosi_i        => temp_data_mosi,
        temp_data_miso_o        => temp_data_miso,
        temp_data_tri_i         => temp_data_tri
    );
    
end Behavioral;
