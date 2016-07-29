----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    08:37:33 07/07/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    link_rx_tracking - Behavioral 
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

entity link_rx_tracking is
port(

    gtx_clk_i       : in std_logic;    
    reset_i         : in std_logic;
    
    vfat2_t1_o      : out t1_t;
    
    req_en_o        : out std_logic;
    req_data_o      : out std_logic_vector(64 downto 0);
    
    tk_error_o      : out std_logic;
    
    rx_kchar_i      : in std_logic_vector(1 downto 0);
    rx_data_i       : in std_logic_vector(15 downto 0)
    
);
end link_rx_tracking;

architecture Behavioral of link_rx_tracking is    

    type state_t is (FRAME_BEGIN, ADDR_0, ADDR_1, DATA_0, FRAME_MIDDLE, DATA_1, CRC, FRAME_END);
    
    signal state        : state_t;
    
    signal req_valid    : std_logic;
    signal req_data     : std_logic_vector(64 downto 0);
    signal req_crc      : std_logic_vector(15 downto 0);

begin  

    --== STATE ==--

    process(gtx_clk_i)
    begin
        if (rising_edge(gtx_clk_i)) then
            if (reset_i = '1') then
                state <= FRAME_BEGIN;
            else
                case state is
                    when FRAME_BEGIN => 
                        if (rx_kchar_i = "01" and rx_data_i(9 downto 0) = "1110111100") then -- "11" & x"BC"
                            state <= ADDR_0;
                        end if;
                    when ADDR_0 => state <= ADDR_1;
                    when ADDR_1 => state <= DATA_0;
                    when DATA_0 => state <= FRAME_MIDDLE;
                    when FRAME_MIDDLE => state <= DATA_1;
                    when DATA_1 => state <= CRC;
                    when CRC => state <= FRAME_END;
                    when FRAME_END => state <= FRAME_BEGIN;
                    when others => state <= FRAME_BEGIN;
                end case;
            end if;
        end if;
    end process;
    
    --== ERROR ==--

    process(gtx_clk_i)
    begin
        if (rising_edge(gtx_clk_i)) then
            if (reset_i = '1') then
                tk_error_o <= '0';
            else
                case state is
                    when FRAME_BEGIN =>
                        if (rx_kchar_i = "01" and rx_data_i(9 downto 0) = "1110111100") then
                            tk_error_o <= '0';
                        else
                            tk_error_o <= '1';
                        end if;
                    when others => tk_error_o <= '0';
                end case;
            end if;
        end if;
    end process;
    
    --== REQUEST ==--
    
    process(gtx_clk_i)
    begin
        if (rising_edge(gtx_clk_i)) then
            if (reset_i = '1') then
                req_en_o <= '0';
                req_data_o <= (others => '0');
                req_valid <= '0';
                req_data <= (others => '0');
                req_crc <= (others => '0');
            else
                case state is   
                    when FRAME_BEGIN =>            
                        req_en_o <= '0';
                        req_valid <= rx_data_i(11); 
                        req_data(64) <= rx_data_i(10); 
                        req_crc <= (others => '0');  
                        vfat2_t1_o <= (lv1a => rx_data_i(15), calpulse => rx_data_i(14), resync => rx_data_i(13), bc0 => rx_data_i(12));
                    when ADDR_0 => 
                        req_data(63 downto 48) <= rx_data_i;
                        req_crc <= req_crc xor rx_data_i;
                    when ADDR_1 => 
                        req_data(47 downto 32) <= rx_data_i;
                        req_crc <= req_crc xor rx_data_i;
                    when DATA_0 => 
                        req_data(31 downto 16) <= rx_data_i;
                        req_crc <= req_crc xor rx_data_i;
                    when FRAME_MIDDLE =>
                        vfat2_t1_o <= (lv1a => rx_data_i(15), calpulse => rx_data_i(14), resync => rx_data_i(13), bc0 => rx_data_i(12));                        
                    when DATA_1 => 
                        req_data(15 downto 0) <= rx_data_i;
                        req_crc <= req_crc xor rx_data_i;
                    when CRC => 
                        if (req_crc /= rx_data_i) then
                            req_valid <= '0';
                        end if;
                    when FRAME_END =>            
                        req_en_o <= req_valid;
                        req_data_o <= req_data;     
                    when others => 
                        req_en_o <= '0';
                        vfat2_t1_o <= (lv1a => '0', calpulse => '0', resync => '0', bc0 => '0');              
                end case;
            end if;
        end if;
    end process;  
    
end Behavioral;
