----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    08:36:59 07/02/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    latency_scan - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description: 
--
-- Firmware implementation of the latency scan
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

entity latency_scan is
port(

    ref_clk_i           : in std_logic;
    reset_i             : in std_logic;
    
    t1_o                : out t1_t;
    
    tk_valid_i          : in std_logic_vector(7 downto 0);
    tk_data_i           : in tk_data_array_t(7 downto 0)
    
);
end latency_scan;

architecture Behavioral of latency_scan is

begin


end Behavioral;

