----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    08:37:33 07/07/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    link_tx_trigger - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description: 
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library unisim;
use unisim.vcomponents.all;

use work.types_pkg.all;

entity gtx_tx_trigger is
port(

    gtx_clk_i           : in std_logic;    
    reset_i             : in std_logic;
    
    sbit_clusters_i     : in sbit_cluster_array_t(7 downto 0);
    
    tx_kchar_link_0_o   : out std_logic_vector(1 downto 0);
    tx_data_link_0_o    : out std_logic_vector(15 downto 0);
    
    tx_kchar_link_1_o   : out std_logic_vector(1 downto 0);
    tx_data_link_1_o    : out std_logic_vector(15 downto 0)

);
end gtx_tx_trigger;

architecture Behavioral of gtx_tx_trigger is    

    type state_t is (COMMA, DATA_0, DATA_1, DATA_2);
    
    signal state    : state_t;
    
    signal cluster_0123_data : std_logic_vector(55 downto 0);
    signal cluster_4567_data : std_logic_vector(55 downto 0);
    
begin  

    cluster_0123_data <= sbit_clusters_i(3) & sbit_clusters_i(2) & sbit_clusters_i(1) & sbit_clusters_i(0);
    cluster_4567_data <= sbit_clusters_i(7) & sbit_clusters_i(6) & sbit_clusters_i(5) & sbit_clusters_i(4);

    --== STATE ==--

    process(gtx_clk_i)
    begin
        if (rising_edge(gtx_clk_i)) then
            if (reset_i = '1') then
                state <= COMMA;
            else
                case state is
                    when COMMA => state <= DATA_0;
                    when DATA_0 => state <= DATA_1;
                    when DATA_1 => state <= DATA_2;
                    when DATA_2 => state <= COMMA;
                    when others => state <= COMMA;
                end case;
            end if;
        end if;
    end process;
        
    --== TRIGGER COMMANDS ==--    
    
    process(gtx_clk_i)
    begin
        if (rising_edge(gtx_clk_i)) then
            if (reset_i = '1') then
                tx_kchar_link_0_o <= "00";
                tx_data_link_0_o <= x"ffff";
                tx_kchar_link_1_o <= "00";
                tx_data_link_1_o <= x"ffff";
            else
                case state is
                    when COMMA => 
                        tx_kchar_link_0_o <= "01";
                        tx_data_link_0_o <= cluster_0123_data(7 downto 0) & x"BC";
                        tx_kchar_link_1_o <= "01";
                        tx_data_link_1_o <= cluster_4567_data(7 downto 0) & x"BC";
                    when DATA_0 => 
                        tx_kchar_link_0_o <= "00";
                        tx_data_link_0_o <= cluster_0123_data(23 downto 8);
                        tx_kchar_link_1_o <= "00";
                        tx_data_link_1_o <= cluster_4567_data(23 downto 8);
                    when DATA_1 => 
                        tx_kchar_link_0_o <= "00";
                        tx_data_link_0_o <= cluster_0123_data(39 downto 24);
                        tx_kchar_link_1_o <= "00";
                        tx_data_link_1_o <= cluster_4567_data(39 downto 24);
                    when DATA_2 => 
                        tx_kchar_link_0_o <= "00";
                        tx_data_link_0_o <= cluster_0123_data(55 downto 40);
                        tx_kchar_link_1_o <= "00";
                        tx_data_link_1_o <= cluster_4567_data(55 downto 40);
                    when others => 
                        tx_kchar_link_0_o <= "00";
                        tx_data_link_0_o <= x"ffff";
                        tx_kchar_link_1_o <= "00";
                        tx_data_link_1_o <= x"ffff";
                end case;
            end if;
        end if;
    end process;   
    
end Behavioral;
