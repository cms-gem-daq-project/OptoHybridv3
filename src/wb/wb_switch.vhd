----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    13:13:21 03/12/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    wb_switch - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description: 
--
-- Wishbone switch that allows multiples masters to control multiples slaves
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
use work.wb_pkg.all;

entity wb_switch is
port(

    wb_clk_i    : in std_logic;
    reset_i     : in std_logic;
   
    wb_m_req_i  : in wb_req_array_t((WB_MASTERS - 1) downto 0); -- Request from master to slave
    wb_s_req_o  : out wb_req_array_t((WB_SLAVES - 1) downto 0);
    
    wb_s_res_i  : in wb_res_array_t((WB_SLAVES - 1) downto 0); -- Response from slave to master
    wb_m_res_o  : out wb_res_array_t((WB_MASTERS - 1) downto 0)
    
);
end wb_switch;

architecture Behavioral of wb_switch is

    signal wb_from_m_req    : wb_req_array_t((WB_MASTERS - 1) downto 0);
    signal wb_to_m_res      : wb_res_array_t((WB_MASTERS - 1) downto 0);
    
    signal wb_from_arb_req  : wb_req_array_t((WB_SLAVES - 1) downto 0); 
    signal wb_to_arb_res    : wb_res_array_t((WB_SLAVES - 1) downto 0);

begin

    --=======================--
    --== Master interfaces ==--
    --=======================--

    wb_master_gen : for M in 0 to (WB_MASTERS - 1) generate
    begin

        wb_master_interface_inst : entity work.wb_master_interface
        port map(
            wb_clk_i    => wb_clk_i,
            reset_i     => reset_i,
            wb_req_i    => wb_m_req_i(M),
            wb_req_o    => wb_from_m_req(M),
            wb_res_i    => wb_to_m_res(M),
            wb_res_o    => wb_m_res_o(M)
        );
        
    end generate;

    --==============--
    --== Arbitrer ==--
    --==============--
    
    wb_arbitrer_inst : entity work.wb_arbitrer
    port map(
        wb_clk_i    => wb_clk_i,
        reset_i     => reset_i,
        wb_req_i    => wb_from_m_req,
        wb_req_o    => wb_from_arb_req,
        wb_res_i    => wb_to_arb_res,
        wb_res_o    => wb_to_m_res
    );
   
    --======================--
    --== Slave interfaces ==--
    --======================--

    wb_slave_gen : for S in 0 to (WB_SLAVES - 1) generate
    begin

        wb_slave_interface_inst : entity work.wb_slave_interface
        port map(
            wb_clk_i    => wb_clk_i,
            reset_i     => reset_i,
            wb_req_i    => wb_from_arb_req(S),
            wb_req_o    => wb_s_req_o(S),
            wb_res_i    => wb_s_res_i(S),
            wb_res_o    => wb_to_arb_res(S)
        );
        
    end generate;
    
end Behavioral;