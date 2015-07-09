----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    10:39:42 07/07/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    rx_controller - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description: 
--
-- Handles the data that is received from the GBT core
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

entity rx_controller is
port(

    gbt_rx_frameclk_i   : in std_logic;
    reset_i             : in std_logic;
    
    gbt_rx_i            : in gbt_data_t;
    
    t1_o                : out t1_t;
    wb_reqs_o           : out wb_req_array_t((WB_SLAVES - 1) downto 0)

);
end rx_controller;

architecture Behavioral of rx_controller is
begin

    --===============--
    --== Decode T1 ==--
    --===============--

    process(gbt_rx_frameclk_i)
    begin
        if (rising_edge(gbt_rx_frameclk_i)) then
            if (reset_i = '1') then
                t1_o <= (others => '0');
            else
                case gbt_rx_i.data(83 downto 80) is
                    when "0000" => t1_o <= (others => '0');
                    when "0001" => t1_o <= (lv1a => '1', others => '0');
                    when "0010" => t1_o <= (calpulse => '1', others => '0');
                    when "0011" => t1_o <= (resync => '1', others => '0');
                    when "0100" => t1_o <= (bc0 => '1', others => '0');
                    when others => t1_o <= (others => '0');
                end case;
            end if;
        end if;
    end process;
    
    --=============================--
    --== Decode WishBone request ==--
    --=============================--
    
    process(gbt_rx_frameclk_i)
    
        variable rw     : std_logic;
        variable addr   : std_logic_vector(31 downto 0);
        variable data   : std_logic_vector(31 downto 0);
        variable sel    : integer;
        
    begin
        if (rising_edge(gbt_rx_frameclk_i)) then
            if (reset_i = '1') then
                wb_reqs_o <= (others => (others => (others => '0')));
            else
                if (gbt_rx_i.is_data = '1') then
                    rw := gbt_rx_i.data(64);
                    addr := gbt_rx_i.data(63 downto 32);
                    data := gbt_rx_i.data(31 downto 0);
                    sel := wb_addr_sel(addr);
                    wb_reqs_o(sel) <= (valid <= '1',
                                       rw => rw,
                                       addr => addr,
                                       data => data);
                else
                    wb_reqs_o <= (others => (valid => '0'));
                end if;
            end if;
        end if;
    end process;
end Behavioral;

