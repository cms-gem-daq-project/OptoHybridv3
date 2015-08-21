----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:   09:50:12 08/21/2015
-- Design Name:    OptoHybrid v2
-- Module Name:    wb_master_test - Behavioral 
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
use ieee.numeric_std.all; 
 
library work;
use work.types_pkg.all;
use work.wb_pkg.all;
 
entity wb_master_test is
end wb_master_test;
 
architecture behavior of wb_master_test is    

    --Inputs
    signal ref_clk_i        : std_logic := '0';
    signal reset_i          : std_logic := '0';
    signal wb_req_i         : wb_req_t;
    signal wb_res_i         : wb_res_t;

    --Outputs
    signal wb_req_o         : wb_req_t;
    signal wb_res_o         : wb_res_t;

    constant ref_clk_period : time := 10 ns;
    constant empty_sig      : wb_req_t := (addr  => (others => '0'), data  => (others => '0'), we    => '0', stb   => '0');
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
    uut : entity work.wb_master_interface 
    port map(
        ref_clk_i   => ref_clk_i,
        reset_i     => reset_i,
        wb_req_i    => wb_req_i,
        wb_req_o    => wb_req_o,
        wb_res_i    => wb_res_i,
        wb_res_o    => wb_res_o
    );

    -- Clock process definitions
    process
    begin
        ref_clk_i <= '1';
        wait for ref_clk_period / 2;
        ref_clk_i <= '0';
        wait for ref_clk_period / 2;
    end process;
    
    -- Reset process
    process
    begin		
        reset_i <= '1';
        wait for 100 ns;
        reset_i <= '0';
        wait;
    wait;
    end process;
    
    -- Data process
    process
    begin
        wb_req_i <= empty_sig;
        wait for 150 ns;
        ---
        wb_req_i <= (stb => '1', we => '1', addr => x"00000000", data => (others => '0'));        
        wait for ref_clk_period;
        --wb_req_i.stb <= '0';
        wait;
    end process;
    
    wb_res_i.ack <= wb_req_o.stb;
   
end;
