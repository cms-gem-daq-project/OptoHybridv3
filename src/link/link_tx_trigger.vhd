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

library work;
use work.types_pkg.all;

entity link_tx_trigger is
port(

    gtx_clk_i           : in std_logic;    
    reset_i             : in std_logic;
    
    sbit_clusters_i     : in sbit_cluster_array_t(7 downto 0);
    
    tx_kchar_o          : out std_logic_vector(1 downto 0);
    tx_data_o           : out std_logic_vector(15 downto 0)
    
);
end link_tx_trigger;

architecture Behavioral of link_tx_trigger is    

    type state_t is (COMMA, DATA_0, DATA_1, DATA_2);
    
    signal state    : state_t;
    
    signal cluster_data : std_logic_vector(55 downto 0);
    
begin  

    cluster_data <= sbit_clusters_i(0) & sbit_clusters_i(1) & sbit_clusters_i(2) & sbit_clusters_i(3);

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
                tx_kchar_o <= "00";
                tx_data_o <= x"0000";
            else
                case state is
                    when COMMA => 
                        tx_kchar_o <= "01";
                        tx_data_o <= cluster_data(55 downto 48) & x"BC";
                    when DATA_0 => 
                        tx_kchar_o <= "00";
                        tx_data_o <= cluster_data(47 downto 32);
                    when DATA_1 => 
                        tx_kchar_o <= "00";
                        tx_data_o <= cluster_data(31 downto 16);
                    when DATA_2 => 
                        tx_kchar_o <= "00";
                        tx_data_o <= cluster_data(15 downto 0);
                    when others => 
                        tx_kchar_o <= "00";
                        tx_data_o <= x"0000";
                end case;
            end if;
        end if;
    end process;   
    
end Behavioral;
