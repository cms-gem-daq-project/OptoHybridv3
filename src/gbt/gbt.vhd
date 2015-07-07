----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    10:15:19 06/03/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    gbt - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description: 
--
-- Instantiation of the GBT-FPGA project 3.1.1
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
-- Based on the example design v3.2 of the GLIB 
-- by Manoel Barros Marin (manoel.barros.marin@cern.ch) (m.barros.marin@ieee.org)
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library unisim;
use unisim.vcomponents.all;

library work;
use work.gbt_bank_package.all;
use work.vendor_specific_gbt_bank_package.all;
use work.gbt_banks_user_setup.all;
use work.types_pkg.all;

entity gbt is   
port (   

    mgt_refclk_p_i          : in  std_logic;
    mgt_refclk_n_i          : in  std_logic;

    general_reset_i         : in std_logic;
    manual_reset_tx_i       : in std_logic;
    manual_reset_rx_i       : in std_logic;

    mgt_tx_p_o              : out std_logic_vector(3 downto 0); 
    mgt_tx_n_o              : out std_logic_vector(3 downto 0); 
    
    mgt_rx_p_i              : in  std_logic_vector(3 downto 0);
    mgt_rx_n_i              : in  std_logic_vector(3 downto 0);      

    tx_data_i               : in gbt_data_array_t(3 downto 0);
   
    rx_data_o               : out gbt_data_array_t(3 downto 0);
    
    tx_frameclk_o           : out std_logic;
    tx_wordclk_o            : out std_logic;
    
    rx_frameclk_o           : out std_logic_vector(3 downto 0);                           
    rx_wordclk_o            : out std_logic_vector(3 downto 0); 
    
    rx_frameclk_ready_o     : out std_logic_vector(3 downto 0); 
    rx_wordclk_ready_o      : out std_logic_vector(3 downto 0);
    
    mgt_ready_o             : out std_logic_vector(3 downto 0); 
    tx_frame_pll_locked_o   : out std_logic;  
    gbt_rx_ready_o          : out std_logic_vector(3 downto 0)  

);
end gbt;

architecture structural of gbt is  

    --== Clock signals ==--
    
    signal mgt_refclk               : std_logic;

    signal mgt_refclk_buffered      : std_logic;
    
    signal tx_word_clk              : std_logic;
    signal tx_frame_clk             : std_logic;
    
    signal rx_word_clk              : std_logic_vector(4 downto 1);
    signal rx_frame_clk             : std_logic_vector(4 downto 1);
    signal rx_frame_pll_locked      : std_logic_vector(4 downto 1);
    signal rx_frame_align_done      : std_logic_vector(4 downto 1);

    --== GBT bank signals ==--
    
    signal to_gbt_bank_clks         : gbtBankClks_i_R;                          
    signal from_gbt_bank_clks       : gbtBankClks_o_R;
    
    signal to_gbt_bank_gbt_tx       : gbtTx_i_R_A(1 to 4); 
    signal from_gbt_bank_gbt_tx     : gbtTx_o_R_A(1 to 4); 
    
    signal to_gbt_bank_mgt          : mgt_i_R;
    signal from_gbt_bank_mgt        : mgt_o_R; 
    
    signal to_gbt_bank_gbt_rx       : gbtRx_i_R_A(1 to 4); 
    signal from_gbt_bank_gbt_rx     : gbtRx_o_R_A(1 to 4);
    
    --== Reset signals ==--
    
    signal mgt_tx_reset             : std_logic;
    signal mgt_rx_reset             : std_logic;
    signal gbt_tx_reset             : std_logic;
    signal gbt_rx_reset             : std_logic;
   
begin      

    --=========================--
    --== MGT reference clock ==--
    --=========================--
           
    mgt_refclk_ibufs_gtxe1 : ibufds_gtxe1
    port map (
        i   => mgt_refclk_p_i,
        ib  => mgt_refclk_n_i,
        o   => mgt_refclk,
        ceb => '0'
    );

    to_gbt_bank_clks.mgt_clks.tx_refClk <= mgt_refclk;
    to_gbt_bank_clks.mgt_clks.rx_refClk <= mgt_refclk; 
    
    mgt_clk_bufg_inst : bufg
    port map (
        i => mgt_refclk,
        o => mgt_refclk_buffered
    );     

    --===================--
    --== TX word clock ==--
    --===================--

    tx_word_clk_bufg_inst : bufg
    port map (
        i   => from_gbt_bank_clks.mgt_clks.tx_wordClk_noBuff(1),
        o   => tx_word_clk
    ); 
    
    to_gbt_bank_clks.mgt_clks.tx_wordClk(1) <= tx_word_clk;
    to_gbt_bank_clks.mgt_clks.tx_wordClk(2) <= tx_word_clk;
    to_gbt_bank_clks.mgt_clks.tx_wordClk(3) <= tx_word_clk;
    to_gbt_bank_clks.mgt_clks.tx_wordClk(4) <= tx_word_clk;
    
    tx_wordclk_o <= tx_word_clk; 

    --====================--
    --== TX frame clock ==--
    --====================--
    
    tx_pll_inst: entity work.xlx_v6_tx_mmcm
    port map (
        clk_in1     => mgt_refclk_buffered,               
        clk_out1    => tx_frame_clk,    
        reset       => '0',
        locked      => tx_frame_pll_locked_o
    );    
    
    to_gbt_bank_clks.tx_frameClk(1) <= tx_frame_clk;
    to_gbt_bank_clks.tx_frameClk(2) <= tx_frame_clk;         
    to_gbt_bank_clks.tx_frameClk(3) <= tx_frame_clk;         
    to_gbt_bank_clks.tx_frameClk(4) <= tx_frame_clk;     

    tx_frameclk_o <= tx_frame_clk;

    --===================--
    --== RX word clock ==--
    --===================--
    
    rx_word_clk_loop : for I in 1 to 4 generate
    begin
    
        rx_word_diff_clk_bufg_inst: bufg
        port map (
            i   => from_gbt_bank_clks.mgt_clks.rx_wordClk_noBuff(I),
            o   => rx_word_clk(I)
        );   
        
        to_gbt_bank_clks.mgt_clks.rx_wordClk(I) <= rx_word_clk(I);
        
        rx_wordclk_o(I - 1) <= rx_word_clk(I);   
        
    end generate;
    
    --====================--
    --== RX frame clock ==--
    --====================--

    rx_frameclk_loop : for I in 1 to 4 generate
    begin

        rx_frameclk_diff_phalgnr_inst : entity work.gbt_rx_frameclk_phalgnr
        port map (
            reset_i         => gbt_rx_reset,
            rx_wordclk_i    => to_gbt_bank_clks.mgt_clks.rx_wordClk(I),
            rx_frameclk_o   => rx_frame_clk(I),   
            sync_enable_i   => from_gbt_bank_gbt_rx(I).latOptGbtBank_rx and from_gbt_bank_mgt.mgtLink(I).rxWordClkReady,
            sync_i          => from_gbt_bank_gbt_rx(I).header_flag,
            pll_locked_o    => rx_frame_pll_locked(I),
            done_o          => rx_frame_align_done(I)
        );                          
                                                      
        to_gbt_bank_clks.rx_frameClk(I) <= rx_frame_clk(I); 

        rx_frameclk_o(I - 1) <= rx_frame_clk(I);  
                                                         
        to_gbt_bank_gbt_rx(I).rxFrameClkReady <= rx_frame_align_done(I);    
        
        rx_frameclk_ready_o(I - 1) <= rx_frame_align_done(I); 

    end generate;

    --==============--
    --== GBT bank ==--
    --==============--
    
    gbt_bank_inst : entity work.gbt_bank
    generic map (
        GBT_BANK_ID => 1
    )
    port map (                                  
        CLKS_I      => to_gbt_bank_clks,                                  
        CLKS_O      => from_gbt_bank_clks,                   
        GBT_TX_I    => to_gbt_bank_gbt_tx,             
        GBT_TX_O    => from_gbt_bank_gbt_tx,                  
        MGT_I       => to_gbt_bank_mgt,              
        MGT_O       => from_gbt_bank_mgt,                    
        GBT_RX_I    => to_gbt_bank_gbt_rx,              
        GBT_RX_O    => from_gbt_bank_gbt_rx         
    ); 
    
    --===========--
    --== Links ==--
    --===========--
    
    links_loop : for I in 0 to 3 generate
    begin
    
       to_gbt_bank_mgt.mgtLink(I + 1).rx_p <= mgt_rx_p_i(I);   
       to_gbt_bank_mgt.mgtLink(I + 1).rx_n <= mgt_rx_n_i(I);
       mgt_tx_p_o(I) <= from_gbt_bank_mgt.mgtLink(I + 1).tx_p;
       mgt_tx_n_o(I) <= from_gbt_bank_mgt.mgtLink(I + 1).tx_n;         
        
    end generate;

    --=============--
    --== TX data ==--
    --=============--
    
    tx_data_loop : for I in 0 to 3 generate
    begin
    
        to_gbt_bank_gbt_tx(I + 1).isDataSel <= tx_data_i(I).is_data;
        to_gbt_bank_gbt_tx(I + 1).data <= tx_data_i(I).data; 
    
    end generate;
   
    --============--
   --== RX data ==--
    --============--
   
    rx_data_loop : for I in 0 to 3 generate
    begin

        rx_data_o(I).is_data <=  from_gbt_bank_gbt_rx(I + 1).isDataFlag;
        rx_data_o(I).data <= from_gbt_bank_gbt_rx(I + 1).data;

    end generate;
 
    --=================--
    --== MGT control ==--   
    --=================--      

    to_gbt_bank_clks.mgt_clks.drp_dClk <= '0';    

    control_loop : for I in 1 to 4 generate
    begin   

        to_gbt_bank_mgt.mgtLink(I).loopBack <= "000";
        to_gbt_bank_mgt.mgtLink(I).tx_syncReset <= '0';
        to_gbt_bank_mgt.mgtLink(I).rx_syncReset <= '0';

        to_gbt_bank_mgt.mgtLink(I).prbs_txEn <= "000";
        to_gbt_bank_mgt.mgtLink(I).prbs_rxEn <= "000";
        to_gbt_bank_mgt.mgtLink(I).prbs_forcErr <= '0';
        to_gbt_bank_mgt.mgtLink(I).prbs_errCntRst <= '0';             
                                                      
        to_gbt_bank_mgt.mgtLink(I).conf_diff <= "1000";
        to_gbt_bank_mgt.mgtLink(I).conf_pstEmph <= "00000";
        to_gbt_bank_mgt.mgtLink(I).conf_preEmph <= "0000";
        to_gbt_bank_mgt.mgtLink(I).conf_eqMix <= "000";
        to_gbt_bank_mgt.mgtLink(I).conf_txPol <= '0';
        to_gbt_bank_mgt.mgtLink(I).conf_rxPol <= '0';
                                                 
        to_gbt_bank_mgt.mgtLink(I).drp_dAddr <= x"00";
        to_gbt_bank_mgt.mgtLink(I).drp_dEn <= '0';
        to_gbt_bank_mgt.mgtLink(I).drp_dI <= x"0000";
        to_gbt_bank_mgt.mgtLink(I).drp_dWe <= '0';

        to_gbt_bank_mgt.mgtLink(I).rxBitSlip_enable <= '1'; 
        to_gbt_bank_mgt.mgtLink(I).rxBitSlip_ctrl <= '0'; 
        to_gbt_bank_mgt.mgtLink(I).rxBitSlip_nbr <= "00000";
        to_gbt_bank_mgt.mgtLink(I).rxBitSlip_run <= '0';
        to_gbt_bank_mgt.mgtLink(I).rxBitSlip_oddRstEn <= '0';   
        
        mgt_ready_o(I - 1) <= from_gbt_bank_mgt.mgtLink(I).ready;
        rx_wordclk_ready_o(I - 1) <= from_gbt_bank_mgt.mgtLink(I).rxWordClkReady;   
        gbt_rx_ready_o(I - 1) <= from_gbt_bank_gbt_rx(I).ready;

    end generate;
    
    --===========--
    --== Reset ==--
    --===========--
    
    gbt_bank_reset_inst : entity work.gbt_bank_reset    
    generic map(
        RX_INIT_FIRST       => false,
        INITIAL_DELAY       => 1 * 40e6, 
        TIME_N              => 1 * 40e6,
        GAP_DELAY           => 1 * 40e6)
    port map(                                  
        clk_i               => tx_frame_clk,             
        general_reset_i     => general_reset_i,                                                                 
        manual_reset_tx_i   => manual_reset_tx_i,
        manual_reset_rx_i   => manual_reset_rx_i,  
        mgt_tx_reset_o      => mgt_tx_reset,                              
        mgt_rx_reset_o      => mgt_rx_reset,                             
        gbt_tx_reset_o      => gbt_tx_reset,                                      
        gbt_rx_reset_o      => gbt_rx_reset,  
        busy_o              => open,                                                                         
        done_o              => open                                                                          
    );      
    
    reset_loop : for I in 1 to 4 generate
    begin
     
        to_gbt_bank_mgt.mgtLink(I).tx_reset <= mgt_tx_reset;
        to_gbt_bank_mgt.mgtLink(I).rx_reset <= mgt_rx_reset;   
        to_gbt_bank_gbt_tx(I).reset <= gbt_tx_reset;  
        to_gbt_bank_gbt_rx(I).reset <= gbt_rx_reset;  
    
    end generate;
   
end structural;