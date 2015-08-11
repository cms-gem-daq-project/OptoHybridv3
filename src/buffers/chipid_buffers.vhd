----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    08:37:33 07/07/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    chipid_buffers - Behavioral 
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

entity chipid_buffers is
port(

    --== Chip ID raw ==--

    chipid_io       : inout std_logic;

    --== Chip ID buffered ==--
    
    chipid_mosi_i   : in std_logic;
    chipid_miso_o   : out std_logic;
    chipid_tri_i    : in std_logic

);
end chipid_buffers;

architecture Behavioral of chipid_buffers is
begin
    
    -- chipid_io
    
    chipid_iobuf : iobuf
    generic map (
        drive       => 12,
        iostandard  => "lvcmos25",
        slew        => "slow"
    )
    port map (
        o           => chipid_miso_o,
        io          => chipid_io,
        i           => chipid_mosi_i,
        t           => chipid_tri_i
    );
    
end Behavioral;

