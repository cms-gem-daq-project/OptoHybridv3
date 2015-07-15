----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    08:37:33 07/07/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    temp - Behavioral 
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

entity temp is
port(

    --== Temperature raw ==--
    
    temp_clk_o      : out std_logic;
    temp_data_io    : inout std_logic;
    
    --== Temperature packed ==--
    
    wb_req_i        : in wb_req_t;
    wb_res_o        : in wb_res_t

);
end temp;

architecture Behavioral of temp is

    signal temp_clk         : std_logic;
    signal temp_data_mosi   : std_logic;
    signal temp_data_miso   : std_logic;
    signal temp_data_tri    : std_logic;
        
begin

    --=========================--
    --== Temperature buffers ==--
    --=========================--

    temp_buffers_inst : entity work.temp_buffers
    port map(
        -- Raw
        temp_clk_o          => temp_clk_o,
        temp_data_io        => temp_data_io,
        -- Buffered
        temp_clk_i          => temp_clk,
        temp_data_mosi_i    => temp_data_mosi,
        temp_data_miso_o    => temp_data_miso,
        temp_data_tri_i     => temp_data_tri
    );

end Behavioral;

