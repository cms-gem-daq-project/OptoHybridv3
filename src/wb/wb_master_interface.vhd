----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    13:13:21 03/12/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    wb_master_interface - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description: 
--
-- This entity is the interface between the master and the arbitrer and keep the signals
-- asserted when the slaves are busy
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

entity wb_master_interface is
port(

    ref_clk_i   : in std_logic;
    reset_i     : in std_logic;
   
    -- Request forwarding
    wb_req_i    : in wb_req_t;
    wb_req_o    : out wb_req_t;
    
    -- Response forwarding
    wb_res_i    : in wb_res_t;
    wb_res_o    : out wb_res_t
    
);
end wb_master_interface;

architecture Behavioral of wb_master_interface is

    type state_t is (IDLE, ACK_WAIT);

    signal state    : state_t;
    
begin

    process(ref_clk_i)
    begin
        if (rising_edge(ref_clk_i)) then
            if (reset_i = '1') then
                wb_req_o <= (stb => '0', we => '0', addr => (others => '0'), data   => (others => '0'));
                wb_res_o <= (ack => '0', stat => (others => '0'), data => (others => '0'));
                state <= IDLE;
            else
                case state is
                    -- Wait for a request to forward
                    when IDLE =>
                        wb_res_o.ack <= '0';
                        if (wb_req_i.stb = '1') then
                            wb_req_o <= wb_req_i;
                            state <= ACK_WAIT;
                        else
                            wb_req_o.stb <= '0';
                        end if;
                    -- Wait for the response to forward
                    when ACK_WAIT =>
                        if (wb_res_i.ack = '1') then
                            wb_req_o.stb <= '0';
                            wb_res_o <= wb_res_i;
                            state <= IDLE;
                        end if;
                    --
                    when others => 
                        wb_req_o <= (stb => '0', we => '0', addr => (others => '0'), data   => (others => '0'));
                        wb_res_o <= (ack => '0', stat => (others => '0'), data => (others => '0'));
                        state <= IDLE;
                end case;
            end if;
        end if;
    end process;

end Behavioral;