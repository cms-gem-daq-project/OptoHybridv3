----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    08:37:33 07/07/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    gtx_rx_tracking - Behavioral 
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

entity gtx_rx_tracking is
port(

    gtx_clk_i       : in std_logic;    
    reset_i         : in std_logic;
    
    req_en_o        : out std_logic;
    req_ack_i       : in std_logic;
    req_data_o      : out std_logic_vector(64 downto 0);
    req_error_o     : out std_logic;
    
    rx_kchar_i      : in std_logic_vector(1 downto 0);
    rx_data_i       : in std_logic_vector(15 downto 0)
    
);
end gtx_rx_tracking;

architecture Behavioral of gtx_rx_tracking is    

    type state_t is (COMMA, HEADER, ADDR_0, ADDR_1, DATA_0, DATA_1);    
    
    signal state        : state_t;
    
    signal req_en       : std_logic;
    signal req_data     : std_logic_vector(79 downto 0);

begin  

    req_en_o <= req_en;

    --== Transitions between states ==--

    process(gtx_clk_i)
    begin
        if (rising_edge(gtx_clk_i)) then
            if (reset_i = '1') then
                state <= COMMA;
            else
                case state is
                    when COMMA =>
                        if (rx_kchar_i = "01" and rx_data_i = x"00BC") then
                            state <= HEADER;
                        end if;
                    when HEADER => state <= ADDR_0;
                    when ADDR_0 => state <= ADDR_1;
                    when ADDR_1 => state <= DATA_0;
                    when DATA_0 => state <= DATA_1;
                    when DATA_1 => state <= COMMA;
                    when others => state <= COMMA;
                end case;
            end if;
        end if;
    end process;
    
    --== Detect errors on the link ==--

    process(gtx_clk_i)
    begin
        if (rising_edge(gtx_clk_i)) then
            if (reset_i = '1') then
                req_error_o <= '0';
            else
                case state is
                    when COMMA =>
                        if (rx_kchar_i = "01" and rx_data_i = x"00BC") then
                            req_error_o <= '0';
                        else
                            req_error_o <= '1';
                        end if;
                    when others => req_error_o <= '0';
                end case;
            end if;
        end if;
    end process;
    
    --== Receive data ==--
    
    process(gtx_clk_i)
    begin
        if (rising_edge(gtx_clk_i)) then
            if (reset_i = '1') then
                req_data <= (others => '0');
            else
                case state is                    
                    when HEADER => req_data(79 downto 64) <= rx_data_i;
                    when ADDR_0 => req_data(63 downto 48) <= rx_data_i;
                    when ADDR_1 => req_data(47 downto 32) <= rx_data_i;
                    when DATA_0 => req_data(31 downto 16) <= rx_data_i;
                    when DATA_1 => req_data(15 downto 0) <= rx_data_i;
                    when others => null;
                end case;
            end if;
        end if;
    end process;   
    
    --== Forward valid data ==--    
    
    process(gtx_clk_i)
    begin
        if (rising_edge(gtx_clk_i)) then
            if (reset_i = '1') then
                req_en <= '0';
                req_data_o <= (others => '0');
            else
                if (state = COMMA and req_data(79) = '1') then
                    if (req_en = '0' and req_ack_i = '0') then
                        req_en <= '1';
                        req_data_o <= req_data(64 downto 0);
                    end if;  
                end if;
                if (req_en = '1' and req_ack_i = '1') then
                    req_en <= '0';
                end if;
            end if;
        end if;
    end process;
    
end Behavioral;
