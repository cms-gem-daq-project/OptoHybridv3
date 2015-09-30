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
    
    req_en_o        : out std_logic;
    req_valid_i     : in std_logic;
    req_data_i      : in std_logic_vector(31 downto 0);
    
    evt_rd_en_o     : out std_logic;
    evt_rd_valid_i  : in std_logic;
    evt_rd_data_i   : in std_logic_vector(15 downto 0);
    evt_rd_ready_i  : in std_logic;
    
    tx_kchar_o      : out std_logic_vector(1 downto 0);
    tx_data_o       : out std_logic_vector(15 downto 0)
    
);
end gtx_tx_tracking;

architecture Behavioral of gtx_tx_tracking is    

    type state_t is (COMMA, HEADER, TK_DATA, DATA_0, DATA_1, CRC);
    
    signal state        : state_t;
    
    signal tk_counter   : integer range 0 to 287;
    
    signal evt_valid    : std_logic;
    signal req_valid    : std_logic;
    signal req_data     : std_logic_vector(31 downto 0);
    signal req_crc      : std_logic_vector(15 downto 0);
    
begin  

    --== STATE ==--

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
                        state <= TK_DATA;
                        tk_counter <= 0;
                    when TK_DATA =>
                        if (tk_counter = 287) then
                            state <= DATA_0;
                        else
                            tk_counter <= tk_counter + 1;
                        end if;
                    when DATA_0 => state <= DATA_1;
                    when DATA_1 => state <= CRC;
                    when CRC => state <= COMMA;
                    when others => 
                        state <= COMMA;
                        tk_counter <= 0;
                end case;
            end if;
        end if;
    end process;

    --== TRACKING DATA ==--

    process(gtx_clk_i)
    begin
        if (rising_edge(gtx_clk_i)) then
            if (reset_i = '1') then
                evt_rd_en_o <= '0';
                evt_valid <= '0';
            else
                case state is         
                    when COMMA => 
                        evt_rd_en_o <= evt_rd_ready_i;      
                        evt_valid <= evt_rd_ready_i;              
                    when HEADER => evt_rd_en_o <= evt_valid;
                    when TK_DATA => evt_rd_en_o <= evt_valid;
                    when others => 
                        evt_rd_en_o <= '0';
                        evt_valid <= '0';
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
                req_valid <= '0';
                req_data <= (others => '0');
                req_crc <= (others => '0');
            else
                case state is   
                    when COMMA => 
                        req_en_o <= '0';
                        req_valid <= req_valid_i;
                        req_data <= req_data_i;
                        req_crc <= req_data_i(31 downto 16) xor req_data_i(15 downto 0);
                    when DATA_1 => req_en_o <= '1';
                    when others => req_en_o <= '0';
                end case;
            end if;
        end if;
    end process; 
    
    --== SEND ==--    
    
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
                        tx_data_o <= req_valid & evt_valid & "00" & x"000";   
                    when TK_DATA => 
                        tx_kchar_o <= "00";
                        if (evt_rd_valid_i = '1') then
                            tx_data_o <= evt_rd_data_i;   
                        else
                            tx_data_o <= (others => '0');                                
                        end if;
                    when DATA_0 => 
                        tx_kchar_o <= "00";
                        tx_data_o <= req_data(31 downto 16);
                    when DATA_1 => 
                        tx_kchar_o <= "00";
                        tx_data_o <= req_data(15 downto 0);
                    when CRC =>
                        tx_kchar_o <= "00";
                        tx_data_o <= req_crc;
                    when others => 
                        tx_kchar_o <= "00";
                        tx_data_o <= x"0000";
                end case;
            end if;
        end if;
    end process;
    
end Behavioral;
