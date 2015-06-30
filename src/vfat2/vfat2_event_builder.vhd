----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    13:13:21 03/12/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    vfat2_event_builder - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description: 
--
-- This module deserializes the tracking data coming from a single VFAT2 and checks the CRC.
-- Data is constantly checked in order to make abstraction of the data_valid line. 
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

entity vfat2_event_builder is
port(

    vfat2_mclk_i    : in std_logic;
    reset_i         : in std_logic;
    
    data_i          : in std_logic;
    
    valid_o         : out std_logic;
    bc_o            : out std_logic_vector(11 downto 0);
    ec_o            : out std_logic_vector(7 downto 0);
    flags_o         : out std_logic_vector(3 downto 0);
    chip_id_o       : out std_logic_vector(11 downto 0);
    strips_o        : out std_logic_vector(127 downto 0);
    crc_o           : out std_logic_vector(15 downto 0)
    
);
end vfat2_event_builder;

architecture Behavioral of vfat2_event_builder is
begin


end Behavioral;