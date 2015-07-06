----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    08:40:27 07/02/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    event_builder - Behavioral 
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

entity event_builder is
port(

    ref_clk_i           : in std_logic;
    reset_i             : in std_logic;
    
    tk_valid_i          : in std_logic_vector(7 downto 0);
    tk_data_i           : tk_data_array_t(7 downto 0)
    
);
end event_builder;

architecture Behavioral of event_builder is

begin


end Behavioral;

