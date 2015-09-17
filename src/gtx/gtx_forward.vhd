----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    08:37:33 07/07/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    gtx_forward - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description: 
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library work;
use work.types_pkg.all;

entity gtx_forward is
port(

	ref_clk_i       : in std_logic;
	reset_i         : in std_logic;
    
	wb_mst_req_o    : out wb_req_t;
	wb_mst_res_i    : in wb_res_t;
    
    rx_en_i         : in std_logic;
    rx_ack_o        : out std_logic;
    rx_data_i       : in std_logic_vector(64 downto 0);
    
    tx_en_o         : out std_logic;
    tx_ack_i        : in std_logic;
    tx_data_o       : out std_logic_vector(31 downto 0)
    
);
end gtx_forward;

architecture Behavioral of gtx_forward is
    
    signal rx_ack   : std_logic;  
    signal tx_en    : std_logic;
    
begin

    rx_ack_o <= rx_ack;
    tx_en_o <= tx_en;
    
    --== RX process ==--
    
    process(ref_clk_i)
    begin    
        if (rising_edge(ref_clk_i)) then        
            if (reset_i = '1') then
                rx_ack <= '0';
                wb_mst_req_o <= (stb => '0', we => '0', addr => (others => '0'), data => (others => '0'));
            else   
                -- Incoming data
                if (rx_en_i = '1' and rx_ack <= '0') then
                    rx_ack <= '1';
                    -- WB request
                    wb_mst_req_o <= (stb => '1', we => rx_data_i(64), addr => rx_data_i(63 downto 32), data => rx_data_i(31 downto 0));
                -- 
                elsif (rx_en_i = '0' and rx_ack <= '1') then
                    rx_ack <= '0';
                    wb_mst_req_o.stb <= '0';    
                -- No data
                else
                    wb_mst_req_o.stb <= '0';    
                end if;
            end if;
        end if;
    end process;      

    --== TX process ==--

    process(ref_clk_i)       
    begin    
        if (rising_edge(ref_clk_i)) then      
            if (reset_i = '1') then                
                tx_en <= '0';                
                tx_data_o <= (others => '0');              
            else         
                -- GTX module is free
                if (tx_en = '0' and tx_ack_i = '0') then
                    -- Request to forward
                    if (wb_mst_res_i.ack = '1') then 
                        -- Format request
                        tx_en <= '1';
                        tx_data_o <= wb_mst_res_i.data;
                    -- No request
                    else                    
                        tx_en <= '0';
                    end if;      
                -- GTX module sent request
                elsif (tx_en = '1' and tx_ack_i = '1') then
                    -- Reset the strobe
                    tx_en <= '0';
                end if;          
            end if;        
        end if;        
    end process;
        
end Behavioral;