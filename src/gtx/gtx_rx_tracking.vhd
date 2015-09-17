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
generic(
    
    RECEIVE_SIZE    : integer   := 5
    
);
port(

    gtx_clk_i       : in std_logic;    
    reset_i         : in std_logic;
    
    req_en_o        : out std_logic;
    req_ack_i       : in std_logic;
    req_data_o      : out std_logic_vector(64 downto 0);
    
    rx_kchar_i      : in std_logic_vector(1 downto 0);
    rx_data_i       : in std_logic_vector(15 downto 0)
    
);
end gtx_rx_tracking;

architecture Behavioral of gtx_rx_tracking is    

    type state_t is (COMMA, RECEIVE);
    
    signal state        : state_t;
    
    signal receive_pos  : integer range 0 to (RECEIVE_SIZE - 1);
    
    signal req_en       : std_logic;
    signal req_data     : std_logic_vector(79 downto 0);

begin  

    req_en_o <= req_en;
    
    process(gtx_clk_i)
    begin
        if (rising_edge(gtx_clk_i)) then
            if (reset_i = '1') then
                req_en <= '0';
                req_data_o <= (others => '0');
                state <= COMMA;
                receive_pos <= 0;
            else
                -- Reset the acknowledgment whenever it has been seen
                if (req_en = '1' and req_ack_i = '1') then
                    req_en <= '0';
                end if;
                -- Handle the data
                case state is
                    -- Send a comma and look for valid data to receive
                    when COMMA => 
                        -- Look for comma
                        if (rx_kchar_i = "01" and rx_data_i = x"00BC") then
                            state <= RECEIVE;
                            receive_pos <= (RECEIVE_SIZE - 1);
                        end if;
                        -- Look if valid data
                        if (req_data(79) = '1') then
                            if (req_en = '0' and req_ack_i = '0') then
                                req_en <= '1';
                                req_data_o <= req_data(64 downto 0);
                            end if;
                        end if;
                    -- Receive data
                    when RECEIVE => 
                        req_data((receive_pos * 16 + 15) downto (receive_pos * 16)) <= rx_data_i;                        
                        -- Data receive limit
                        if (receive_pos = 0) then
                            state <= COMMA;
                        else
                            receive_pos <= receive_pos - 1;
                        end if;
                    when others =>
                        req_en <= '0';
                        req_data_o <= (others => '0');
                        state <= COMMA;
                end case;
            end if;
        end if;
    end process;
    
end Behavioral;
