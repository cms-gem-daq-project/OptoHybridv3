----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    08:37:33 07/07/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    temp_buffers - Behavioral 
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

library unisim;
use unisim.vcomponents.all;

entity temp_buffers is
port(

    --== Temperature raw ==--

    temp_clk_o          : out std_logic;
    temp_data_io        : inout std_logic;

    --== Temperature buffered ==--
    
    temp_clk_i          : in std_logic;
    
    temp_data_mosi_i    : in std_logic;
    temp_data_miso_o    : out std_logic;
    temp_data_tri_i     : in std_logic

);
end temp_buffers;

architecture Behavioral of temp_buffers is
begin
 
    -- temp_clk

    temp_clk_obuf : obuf
    generic map(
        drive       => 12,
        iostandard  => "lvcmos25",
        slew        => "fast"
    )
    port map(
        i           => temp_clk_i,
        o           => temp_clk_o
    );   
    -- chip_id
    
    temp_data_iobuf : iobuf
    generic map (
        drive       => 12,
        iostandard  => "lvcmos25",
        slew        => "slow"
    )
    port map (
        o           => temp_data_miso_o,
        io          => temp_data_io,
        i           => temp_data_mosi_i,
        t           => temp_data_tri_i
    );
    
end Behavioral;

