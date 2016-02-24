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
-- This entity controls the PHY level of the GTX.
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

    mgt_refclk_n_i  : in std_logic;
    mgt_refclk_p_i  : in std_logic;
    ref_clk_i       : in std_logic;
    
    reset_i         : in std_logic;
    
    gtx_clk_o       : out std_logic;    
    rec_clk_o       : out std_logic;    

    gtx_tx_kchar_i  : in std_logic_vector(3 downto 0);
    gtx_tx_data_i   : in std_logic_vector(31 downto 0);
    gtx_rx_kchar_o  : out std_logic_vector(3 downto 0);
    gtx_rx_data_o   : out std_logic_vector(31 downto 0);
    gtx_rx_error_o  : out std_logic_vector(1 downto 0);
   
    rx_n_i          : in std_logic_vector(1 downto 0);
    rx_p_i          : in std_logic_vector(1 downto 0);
    tx_n_o          : out std_logic_vector(1 downto 0);
    tx_p_o          : out std_logic_vector(1 downto 0)
    
);
end gtx;

architecture Behavioral of gtx is          
begin    
        
    --=================--
    --== GTX wrapper ==--
    --=================--
    
	gtx_wrapper_inst : entity work.gtx_wrapper 
    port map(
		mgt_refclk_n_i  => mgt_refclk_n_i,
		mgt_refclk_p_i  => mgt_refclk_p_i,
		ref_clk_i       => ref_clk_i,
		reset_i         => reset_i,
		tx_kchar_i      => gtx_tx_kchar_i,
		tx_data_i       => gtx_tx_data_i,
		rx_kchar_o      => gtx_rx_kchar_o,
		rx_data_o       => gtx_rx_data_o,
		rx_error_o      => gtx_rx_error_o,
		usr_clk_o       => gtx_clk_o,
        rec_clk_o       => rec_clk_o,
		rx_n_i          => rx_n_i(1 downto 0),
		rx_p_i          => rx_p_i(1 downto 0),
		tx_n_o          => tx_n_o(1 downto 0),
		tx_p_o          => tx_p_o(1 downto 0)
	);   
        
end Behavioral;
