----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    08:37:33 07/07/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    temperature - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description: 
--
-- Reads out the temperature sensor
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

library unisim;
use unisim.vcomponents.all;

entity temperature is
port(

    temp_clk_o      : out std_logic;
    temp_data_io    : inout std_logic

);
end temperature;

architecture Behavioral of temperature is

    --== I2C lines ==--

    signal sda_mosi : std_logic;
    signal sda_miso : std_logic;
    signal sda_tri  : std_logic;

begin

    --======================--
    --== Tri-state buffer ==--
    --======================--
    
    temp_data_iobuf : iobuf
    generic map (
        drive       => 12,
        iostandard  => "lvcmos25",
        slew        => "slow"
    )
    port map (
        o           => sda_miso,
        io          => temp_data_io,
        i           => sda_mosi,
        t           => sda_tri
    );
    
    --================--
    --== NULL logic ==--
    --================--
    
    temp_clk_o <= '0';
    sda_mosi <= '0';
    sda_tri <= '0';

end Behavioral;

