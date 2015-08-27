----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    09:18:05 07/09/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    wb_switch - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description: 
--
-- Switching system for the Wishbone transactions between masters and slaves.
-- This module allows multiple masters to communicate with the slaves by forwarding 
-- the requests and automatically route the reponses between masters and slaves.
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.types_pkg.all;
use work.wb_pkg.all;

entity wb_switch is
port(

    ref_clk_i   : in std_logic;
    reset_i     : in std_logic;
   
    -- Requests
    wb_req_i    : in wb_req_array_t((WB_MASTERS - 1) downto 0); -- From masters requests
    wb_req_o    : out wb_req_array_t((WB_SLAVES - 1) downto 0); -- To slaves requests
    
    -- Responses
    wb_res_i    : in wb_res_array_t((WB_SLAVES - 1) downto 0); -- From slaves responses
    wb_res_o    : out wb_res_array_t((WB_MASTERS - 1) downto 0) -- To masters responses
    
);
end wb_switch;

architecture Behavioral of wb_switch is

    type state_t is (IDLE, WAITING, ACK_WAIT);
    type state_array_t is array(integer range <>) of state_t;
    
    signal states       : state_array_t((WB_MASTERS - 1) downto 0);
    
    signal wb_req       : wb_req_array_t((WB_MASTERS - 1) downto 0);  
    signal timeouts     : u32_array_t((WB_MASTERS - 1) downto 0);  
       
    -- For each master, the slave it is addressing 
    signal sel_slave    : int_array_t((WB_MASTERS - 1) downto 0); 
    
begin

    --========================--
    --== Request forwarding ==--
    --========================--

    process(ref_clk_i)        
        -- For each slave, the master that is controllign it  
        variable sel_master : int_array_t((WB_SLAVES - 1) downto 0);     
    begin
        if (rising_edge(ref_clk_i)) then
            -- Reset & default values
            if (reset_i = '1') then
                wb_req_o <= (others => (stb => '0', we => '0', addr => (others => '0'), data => (others => '0')));
                wb_res_o <= (others => (ack => '0', stat => (others => '0'), data => (others => '0')));
                states <= (others => IDLE);
                wb_req <= (others => (stb => '0', we => '0', addr => (others => '0'), data => (others => '0')));
                timeouts <= (others => (others => '0'));
                sel_slave <= (others => 99);
                sel_master := (others => 99);
            else
                -- Loop over the masters
                for I in 0 to (WB_MASTERS - 1) loop
                    -- Each master has its own state machine
                    case states(I) is
                        -- Wait for a request
                        when IDLE =>
                            -- Reset the acknowledgment
                            wb_res_o(I).ack <= '0';
                            -- Incoming request
                            if (wb_req_i(I).stb = '1') then
                                -- Save the request
                                wb_req(I) <= wb_req_i(I);
                                -- Select the slave to address
                                sel_slave(I) <= wb_addr_sel(wb_req_i(I).addr);
                                -- Set the timeout
                                timeouts(I) <= to_unsigned(WB_TIMEOUT, 32);
                                -- Change state
                                states(I) <= WAITING;
                            end if;
                        -- Wait to transfer request
                        when WAITING =>
                            -- Check the timeout
                            if (timeouts(I) = 0) then
                                -- Set error on timeout
                                wb_res_o(I) <= (ack => '1', stat => WB_ERR_TIMEOUT, data => (others => '0'));
                                states(I) <= IDLE;
                            else
                                -- Decrement timeout
                                timeouts(I) <= timeouts(I) - 1;
                                -- Unknown slave
                                if (sel_slave(I) = 99) then
                                    -- Error
                                    wb_res_o(I) <= (ack => '1', stat => WB_ERR_SLAVE, data => (others => '0'));
                                    states(I) <= IDLE;
                                -- Slave is free
                                elsif (sel_master(sel_slave(I)) = 99) then
                                    -- Send request to slave
                                    wb_req_o(sel_slave(I)) <= wb_req(I);
                                    sel_master(sel_slave(I)) := I;
                                    states(I) <= ACK_WAIT;
                                end if;   
                            end if;
                        -- Wait for acknowledgment
                        when ACK_WAIT => 
                            -- Reset the strobe
                            wb_req_o(sel_slave(I)).stb <= '0';
                            -- Check the timeout
                            if (timeouts(I) = 0) then
                                -- Set error on timeout
                                wb_res_o(I) <= (ack => '1', stat => WB_ERR_TIMEOUT, data => (others => '0'));
                                states(I) <= IDLE;
                            else
                                -- Decrement timeout
                                timeouts(I) <= timeouts(I) - 1;
                                -- Incoming response
                                if (wb_res_i(sel_slave(I)).ack = '1') then
                                    -- Transfer the response
                                    wb_res_o(I) <= wb_res_i(sel_slave(I));
                                    -- Free the slave
                                    sel_master(sel_slave(I)) := 99;
                                    states(I) <= IDLE;
                                end if;
                            end if;
                        --
                        when others =>            
                            wb_req_o(I) <= (stb => '0', we  => '0', addr => (others => '0'), data => (others => '0'));
                            wb_res_o(I) <= (ack => '0', stat => (others => '0'), data => (others => '0'));
                            states(I) <= IDLE;
                            wb_req(I) <= (stb => '0', we => '0', addr => (others => '0'), data => (others => '0'));
                            timeouts(I) <= (others => '0');
                            sel_slave(I) <= 99;
                            sel_master(I) := 99;
                    end case;
                end loop;
            end if;
        end if;
    end process;    
    
end Behavioral;

