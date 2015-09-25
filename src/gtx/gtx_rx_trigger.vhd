----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    08:37:33 07/07/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    gtx_rx_trigger - Behavioral 
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

entity gtx_rx_trigger is
port(

    gtx_clk_i       : in std_logic;    
    reset_i         : in std_logic;
    
    vfat2_t1_o      : out t1_t;
    tr_error_o      : out std_logic;
    
    rx_kchar_i      : in std_logic_vector(1 downto 0);
    rx_data_i       : in std_logic_vector(15 downto 0)
    
);
end gtx_rx_trigger;

architecture Behavioral of gtx_rx_trigger is    

    type state_t is (COMMA, DATA_0, DATA_1, DATA_2);    
    
    signal state    : state_t;

begin  

    --== STATE ==--

    process(gtx_clk_i)
    begin
        if (rising_edge(gtx_clk_i)) then
            if (reset_i = '1') then
                state <= COMMA;
            else
                case state is
                    when COMMA =>
                        if (rx_kchar_i = "01" and rx_data_i = x"00BC") then
                            state <= DATA_0;
                        end if;
                    when DATA_0 => state <= DATA_1;
                    when DATA_1 => state <= DATA_2;
                    when DATA_2 => state <= COMMA;
                    when others => state <= COMMA;
                end case;
            end if;
        end if;
    end process;
    
    --== ERROR ==--

    process(gtx_clk_i)
    begin
        if (rising_edge(gtx_clk_i)) then
            if (reset_i = '1') then
                tr_error_o <= '0';
            else
                case state is
                    when COMMA =>
                        if (rx_kchar_i = "01" and rx_data_i = x"00BC") then
                            tr_error_o <= '0';
                        else
                            tr_error_o <= '1';
                        end if;
                    when others => tr_error_o <= '0';
                end case;
            end if;
        end if;
    end process;
    
    --== TRIGGER COMMANDS ==--
    
    process(gtx_clk_i)
    begin
        if (rising_edge(gtx_clk_i)) then
            if (reset_i = '1') then
                vfat2_t1_o <= (lv1a => '0', calpulse => '0', resync => '0', bc0 => '0');
            else
                case state is                    
                    when DATA_0 => vfat2_t1_o <= (lv1a => rx_data_i(15), calpulse => rx_data_i(14), resync => rx_data_i(13), bc0 => rx_data_i(12));
                    when others => null;
                end case;
            end if;
        end if;
    end process;   
    
end Behavioral;
