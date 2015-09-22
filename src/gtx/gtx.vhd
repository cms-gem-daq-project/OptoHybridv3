----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    08:37:33 07/07/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    gtx - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description: 
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library unisim;
use unisim.vcomponents.all;

library work;
use work.types_pkg.all;

entity gtx is
port(

    mgt_refclk_n_i      : in std_logic;
    mgt_refclk_p_i      : in std_logic;
    
    ref_clk_i           : in std_logic;
    
    reset_i             : in std_logic;
    
    wb_mst_req_o        : out wb_req_t;
    wb_mst_res_i        : in wb_res_t;
    
    vfat2_tk_data_i     : in tk_data_array_t(23 downto 0);
    vfat2_tk_mask_i     : in std_logic_vector(23 downto 0);
   
    rx_n_i              : in std_logic_vector(1 downto 0);
    rx_p_i              : in std_logic_vector(1 downto 0);
    tx_n_o              : out std_logic_vector(1 downto 0);
    tx_p_o              : out std_logic_vector(1 downto 0)
    
);
end gtx;

architecture Behavioral of gtx is      

    --== GTX signals ==--

    signal gtx_tx_kchar     : std_logic_vector(3 downto 0);
    signal gtx_tx_data      : std_logic_vector(31 downto 0);
    
    signal gtx_rx_kchar     : std_logic_vector(3 downto 0);
    signal gtx_rx_data      : std_logic_vector(31 downto 0);
    signal gtx_rx_error     : std_logic_vector(1 downto 0);
 
    signal gtx_usr_clk      : std_logic;   
    signal gtx_rec_clk      : std_logic;   
    
    --== GTX requests ==--
    
    signal g2o_req_en       : std_logic;
    signal g2o_req_data     : std_logic_vector(64 downto 0);    
    signal g2o_req_error    : std_logic;
    
    signal o2g_req_en       : std_logic;
    signal o2g_req_valid    : std_logic;
    signal o2g_req_data     : std_logic_vector(31 downto 0);
    
    --== VFAT2 tracking data ==--
    
    signal tk_rd_en         : std_logic;
    signal tk_rd_valid      : std_logic;
    signal tk_rd_data       : std_logic_vector(15 downto 0);
    signal tk_rd_ready      : std_logic;
    
    --== Chipscope signals ==--
    
    signal cs_ctrl0         : std_logic_vector(35 downto 0);
    signal cs_ctrl1         : std_logic_vector(35 downto 0); 
    signal cs_sync_in       : std_logic_vector(36 downto 0);
    signal cs_sync_out      : std_logic_vector(65 downto 0);
    signal cs_trig0         : std_logic_vector(31 downto 0);
    signal cs_trig1         : std_logic_vector(31 downto 0);
    
begin    
    
    --=================--
    --== GTX wrapper ==--
    --=================--
    
	gtx_wrapper_inst : entity work.gtx_wrapper 
    port map(
		mgt_refclk_n_i  => mgt_refclk_n_i,
		mgt_refclk_p_i  => mgt_refclk_p_i,
		reset_i         => reset_i,
		tx_kchar_i      => gtx_tx_kchar,
		tx_data_i       => gtx_tx_data,
		rx_kchar_o      => gtx_rx_kchar,
		rx_data_o       => gtx_rx_data,
		rx_error_o      => gtx_rx_error,
		usr_clk_o       => gtx_usr_clk,
        rec_clk_o       => gtx_rec_clk,
		rx_n_i          => rx_n_i(1 downto 0),
		rx_p_i          => rx_p_i(1 downto 0),
		tx_n_o          => tx_n_o(1 downto 0),
		tx_p_o          => tx_p_o(1 downto 0)
	);   
    
    --==========================--
    --== SFP RX Tracking link ==--
    --==========================--
       
    gtx_rx_tracking_inst : entity work.gtx_rx_tracking
    port map(
        gtx_clk_i   => gtx_usr_clk,   
        reset_i     => reset_i,           
        req_en_o    => g2o_req_en,   
        req_data_o  => g2o_req_data,  
        req_error_o => g2o_req_error,         
        rx_kchar_i  => gtx_rx_kchar(1 downto 0),   
        rx_data_i   => gtx_rx_data(15 downto 0)
    );
    
    --==========================--
    --== SFP TX Tracking link ==--
    --==========================--
       
    gtx_tx_tracking_inst : entity work.gtx_tx_tracking
    port map(
        gtx_clk_i       => gtx_usr_clk,   
        reset_i         => reset_i,       
		req_en_o        => o2g_req_en,
		req_valid_i     => o2g_req_valid,
		req_data_i      => o2g_req_data,
		tk_rd_en_o      => tk_rd_en,
		tk_rd_valid_i   => tk_rd_valid,
		tk_rd_data_i    => tk_rd_data,
        tk_rd_ready_i   => tk_rd_ready,
		tx_kchar_o      => gtx_tx_kchar(1 downto 0),  
		tx_data_o       => gtx_tx_data(15 downto 0)
	);
    
    --============================--
    --== GTX request forwarding ==--
    --============================--
    
    gtx_forward_inst : entity work.gtx_forward
    port map(
        ref_clk_i       => ref_clk_i,
        gtx_clk_i       => gtx_usr_clk,  
        reset_i         => reset_i,        
        wb_mst_req_o    => wb_mst_req_o,
        wb_mst_res_i    => wb_mst_res_i,       
        rx_en_i         => g2o_req_en,
        rx_data_i       => g2o_req_data,          
        tx_en_i         => o2g_req_en,
        tx_valid_o      => o2g_req_valid,
        tx_data_o       => o2g_req_data      
    );  
    
    --======================================--
    --== VFAT2 tracking data concentrator ==--
    --======================================--	
    
    gtx_tk_concentrator_inst : entity work.gtx_tk_concentrator 
    port map(
		ref_clk_i       => ref_clk_i,
		gtx_clk_i       => gtx_usr_clk,
		reset_i         => reset_i,
		tk_data_i       => vfat2_tk_data_i,
        vfat2_tk_mask_i => vfat2_tk_mask_i,
		tk_rd_en_i      => tk_rd_en,
		tk_rd_valid_o   => tk_rd_valid,
		tk_rd_data_o    => tk_rd_data,
        tk_rd_ready_o   => tk_rd_ready
	);  
            
    --===============--
    --== ChipScope ==--
    --===============--
    
    chipscope_icon_inst : entity work.chipscope_icon
    port map(
        control0    => cs_ctrl0,
        control1    => cs_ctrl1
    );
    
    chipscope_vio_inst : entity work.chipscope_vio
    port map(
        control     => cs_ctrl0,
        clk         => gtx_usr_clk,
        sync_in     => cs_sync_in,
        sync_out    => cs_sync_out
    );
    
    chipscope_ila_inst : entity work.chipscope_ila
    port map(
        control => cs_ctrl1,
        clk     => gtx_usr_clk,
        trig0   => cs_trig0,
        trig1   => cs_trig1
    );
        
    cs_trig0 <= gtx_rx_data(15 downto 0) & gtx_tx_data(15 downto 0);
    cs_trig1 <= (
        0 => vfat2_tk_data_i(0).valid,
        1 => vfat2_tk_data_i(0).crc_ok,
        2 => tk_rd_en,
        3 => tk_rd_valid,   
        4 => tk_rd_ready,
        others => '0'
    );
    
end Behavioral;
