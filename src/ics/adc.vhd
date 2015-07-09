----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    08:37:20 07/07/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    adc - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description: 
--
-- Interfaces with the ADC to readout the values 
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

entity adc is
port(
    
    adc_io_clk_o    : out std_logic;
    adc_cs_n_o      : out std_logic;
    adc_data_o      : out std_logic;
    
    adc_data_i      : in std_logic;
    adc_eoc_i       : in std_logic
    
);
end adc;

architecture Behavioral of adc is
begin
    
    --================--
    --== NULL logic ==--
    --================--
    
    adc_io_clk_o <= '0';
    adc_cs_n_o <= '1';
    adc_data_o <= '0';

end Behavioral;

