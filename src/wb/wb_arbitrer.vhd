----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    09:18:05 07/09/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    wb_arbitrer - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description: 
--
-- Transfers the requests from the masters to the slaves
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

entity wb_arbitrer is
port(

    wb_clk_i    : in std_logic;
    reset_i     : in std_logic;
   
    wb_req_i    : in wb_req_array_t((WB_MASTERS - 1) downto 0); -- From masters requests
    wb_req_o    : out wb_req_array_t((WB_SLAVES - 1) downto 0); -- To slaves requests
    
    wb_res_i    : in wb_res_array_t((WB_SLAVES - 1) downto 0); -- From slaves responses
    wb_res_o    : out wb_res_array_t((WB_MASTERS - 1) downto 0) -- To masters responses
    
);
end wb_arbitrer;

architecture Behavioral of wb_arbitrer is

    type state_t is (IDLE, TESTING, WAITING, ACK_WAIT);
    type state_array_t is array(integer range <>) of state_t;
    
    signal states       : state_array_t((WB_MASTERS - 1) downto 0);
    
    signal ctrl_master  : integer range 0 to (WB_MASTERS - 1);
   
    signal sel_slave    : int_array_t((WB_MASTERS - 1) downto 0); -- for each master, the slave it is addressing 
    signal sel_master   : int_array_t((WB_SLAVES - 1) downto 0); -- for each slave, the master that is controllign it
    signal wb_req       : wb_req_array_t((WB_MASTERS - 1) downto 0);
    
begin
    
    --====================--
    --== Switch masters ==--
    --====================--

    process(wb_clk_i)
    begin
        if (rising_edge(wb_clk_i)) then
            if (reset_i = '1') then
                ctrl_master <= 0;
            else
                if (ctrl_master = (WB_MASTERS - 1)) then
                    ctrl_master <= 0;
                else
                    ctrl_master <= ctrl_master + 1;
                end if;
            end if;
        end if;
    end process;
    
    --========================--
    --== Request forwarding ==--
    --========================--

    process(wb_clk_i)
    begin
        if (rising_edge(wb_clk_i)) then
            if (reset_i = '1') then
                wb_req_o <= (others => (stb  => '0',
                                        we   => '0',
                                        addr => (others => '0'),
                                        data => (others => '0')));
                wb_res_o <= (others => (ack  => '0',
                                        stat => (others => '0'),
                                        data => (others => '0')));
                states <= (others => IDLE);
                wb_req <= (others => (stb  => '0',
                                      we   => '0',
                                      addr => (others => '0'),
                                      data => (others => '0')));
                sel_slave <= (others => 99);
                sel_master <= (others => 99);
            else
                case states(ctrl_master) is
                    when IDLE =>
                        wb_res_o(ctrl_master).ack <= '0';
                        if (wb_req_i(ctrl_master).stb = '1') then
                            wb_req(ctrl_master) <= wb_req_i(ctrl_master);
                            sel_slave(ctrl_master) <= wb_addr_sel(wb_req_i(ctrl_master).addr);
                            states(ctrl_master) <= TESTING;
                        end if;
                    when TESTING =>
                         if (sel_slave(ctrl_master) = 99) then
                            wb_res_o(ctrl_master) <= (ack   => '1',
                                                      stat  => "11",
                                                      data  => (others => '0'));
                            states(ctrl_master) <= IDLE;
                        else
                            states(ctrl_master) <= WAITING;
                        end if;                          
                    when WAITING =>
                        if (sel_master(sel_slave(ctrl_master)) = 99) then
                            wb_req_o(sel_slave(ctrl_master)) <= wb_req(ctrl_master);
                            sel_master(sel_slave(ctrl_master)) <= ctrl_master;
                            states(ctrl_master) <= ACK_WAIT;
                        end if;                        
                    when ACK_WAIT => 
                        if (wb_res_i(sel_slave(ctrl_master)).ack = '1') then
                            wb_req_o(sel_slave(ctrl_master)).stb <= '0';
                            wb_res_o(ctrl_master) <= wb_res_i(sel_slave(ctrl_master));
                            sel_master(sel_slave(ctrl_master)) <= 99;
                            states(ctrl_master) <= IDLE;
                        end if;
                    when others =>                
                        wb_req_o(ctrl_master) <= (stb  => '0',
                                                  we   => '0',
                                                  addr => (others => '0'),
                                                  data => (others => '0'));
                        wb_res_o(ctrl_master) <= (ack  => '0',
                                                  stat => (others => '0'),
                                                  data => (others => '0'));
                        states(ctrl_master) <= IDLE;
                end case;
            end if;
        end if;
    end process;    
    
end Behavioral;

