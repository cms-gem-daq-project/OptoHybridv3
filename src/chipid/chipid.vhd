----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    08:37:33 07/07/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    chipid - Behavioral 
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

library work;
use work.types_pkg.all;

entity chipid is
port(

    --== Chip ID raw ==--
    
    chip_id_io  : inout std_logic;

    --== Chip ID packed ==--
    
    wb_req_i    : in wb_req_t;
    wb_res_o    : in wb_res_t

);
end chipid;

architecture Behavioral of chipid is

    signal chip_id_mosi : std_logic;
    signal chip_id_miso : std_logic;
    signal chip_id_tri  : std_logic;

begin

    --=====================--
    --== Chip ID buffers ==--
    --=====================--
    
    chipid_buffers_inst : entity work.chipid_buffers
    port map(
        -- Raw
        chip_id_io      => chip_id_io,
        -- Buffered
        chip_id_mosi_i  => chip_id_mosi,
        chip_id_miso_o  => chip_id_miso,
        chip_id_tri_i   => chip_id_tri
    );

end Behavioral;

