----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    13:13:21 03/12/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    vfat2_data_switch - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description: 
--
-- This module controls which module should receive the tracking data from the VFAT2s
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

entity vfat2_data_switch is
port(
    
    tracking_mode_i : in std_logic_vector(3 downto 0);
    
    readout_en_o    : out std_logic;
    threshold_en_o  : out std_logic;
    latency_en_o    : out std_logic
    
);
end vfat2_data_switch;

architecture Behavioral of vfat2_data_switch is
begin

    readout_en_o <= '1' when tracking_mode_i = "0000" else '0';
    threshold_en_o <= '1' when tracking_mode_i = "0001" else '0';
    latency_en_o <= '1' when tracking_mode_i = "0010" else '0';
    
end Behavioral;