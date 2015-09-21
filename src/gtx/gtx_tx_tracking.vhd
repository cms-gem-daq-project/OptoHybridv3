----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    08:37:33 07/07/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    gtx_tx_tracking - Behavioral 
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

entity gtx_tx_tracking is
port(

    gtx_clk_i       : in std_logic;    
    reset_i         : in std_logic;
    
    req_en_i        : in std_logic;
    req_ack_o       : out std_logic;
    req_data_i      : in std_logic_vector(31 downto 0);
    
    tx_kchar_o      : out std_logic_vector(1 downto 0);
    tx_data_o       : out std_logic_vector(15 downto 0)
    
);
end gtx_tx_tracking;

architecture Behavioral of gtx_tx_tracking is    

    type state_t is (COMMA, HEADER, TK_DATA, DATA_0, DATA_1);
    
    signal state        : state_t;
    
    signal tk_counter   : integer range 0 to 287;
    
    signal req_ack      : std_logic;
    signal req_data     : std_logic_vector(47 downto 0);

begin  

    req_ack_o <= req_ack;

    --== Transitions between states ==--

    process(gtx_clk_i)
    begin
        if (rising_edge(gtx_clk_i)) then
            if (reset_i = '1') then
                state <= COMMA;
                tk_counter <= 0;
            else
                case state is
                    when COMMA => state <= HEADER;
                    when HEADER => 
                        tk_counter <= 0;
                        state <= DATA_0;
--                    when TK_DATA =>
--                        if (tk_counter = 287) then
--                            state <= DATA_0;
--                        else
--                            tk_counter <= tk_counter + 1;
--                            state <= TK_DATA;
--                        end if;
                    when DATA_0 => state <= DATA_1;
                    when DATA_1 => state <= COMMA;
                    when others => 
                        state <= COMMA;
                        tk_counter <= 0;
                end case;
            end if;
        end if;
    end process;

    --== Handle new data ==--
    
    process(gtx_clk_i)
    begin
        if (rising_edge(gtx_clk_i)) then
            if (reset_i = '1') then
                req_ack <= '0';
                req_data <= (others => '0');
            else
                if (state = COMMA) then
                    if (req_en_i = '1' and req_ack = '0') then                    
                        req_ack <= '1';
                        req_data <= "1000000000000000" & req_data_i;
                    else
                        req_data <= (others => '0');
                    end if;
                end if;
                if (req_en_i = '0' and req_ack = '1') then
                    req_ack <= '0';
                end if;
            end if;
        end if;
    end process;
        
    --== Send data ==--    
    
    process(gtx_clk_i)
    begin
        if (rising_edge(gtx_clk_i)) then
            if (reset_i = '1') then
                tx_kchar_o <= "00";
                tx_data_o <= (others => '0');
            else
                case state is
                    when COMMA => 
                        tx_kchar_o <= "01";
                        tx_data_o <= x"00BC";
                    when HEADER => 
                        tx_kchar_o <= "00";
                        tx_data_o <= req_data(47 downto 32);                        
                    when DATA_0 => 
                        tx_kchar_o <= "00";
                        tx_data_o <= req_data(31 downto 16);
                    when DATA_1 => 
                        tx_kchar_o <= "00";
                        tx_data_o <= req_data(15 downto 0);
                    when others => 
                        tx_kchar_o <= "00";
                        tx_data_o <= x"0000";
                end case;
            end if;
        end if;
    end process;
    
end Behavioral;
