----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    11:22:49 06/30/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    trigger_link - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description: 
--
-- Handles a tracking link
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

entity trigger_link is
port(

    ref_clk_i           : in std_logic;
    reset_i             : in std_logic;

    vfat2_sbits_i       : in sbits_array_t(23 downto 0);
    
    gbt_rx_i            : in gbt_data_t;
    gbt_tx_o            : out gbt_data_t;
    
    gbt_tx_frameclk_i   : in std_logic;
    gbt_tx_wordclk_i    : in std_logic;
    gbt_rx_frameclk_i   : in std_logic;
    gbt_rx_wordclk_i    : in std_logic;
    gbt_rx_ready_i      : in std_logic;
    mgt_ready_i         : in std_logic
    
);
end trigger_link;

architecture Behavioral of trigger_link is
begin

    --================--
    --== NULL logic ==--
    --================--
    
    gbt_tx_o.data <= (others => '0');
    gbt_tx_o.is_data <= '0';

end Behavioral;