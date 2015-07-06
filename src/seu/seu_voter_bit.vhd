----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    13:13:21 03/12/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    seu_voter_bit - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description: 
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

entity seu_voter_bit is
generic(

    ASYNC       : boolean := true;
    WIDTH       : integer := 1 -- for implementation compatibility with seu_voter_vector
    
);
port(

    clk_i       : in std_logic;
    reset_i     : in std_logic;
    
    data_0_i    : in std_logic;
    data_1_i    : in std_logic;
    data_2_i    : in std_logic;
    
    data_o      : out std_logic
    
);
end seu_voter_bit;

architecture Behavioral of seu_voter_bit is

    signal comp : std_logic_vector(2 downto 0);

begin

    --== Reformat data ==--
    
    comp <= data_2_i & data_1_i & data_0_i;
        
    --== Asynchronous voter ==--
    
    async_gen : if ASYNC = true generate
    begin
        with comp select data_o <= 
            '0' when "000" | "001" | "010" | "100",
            '1' when "111" | "110" | "101" | "011",
            '0' when others;
    end generate;
    
    --== Synchronous voter ==--
    
    sync_gen : if ASYNC = false generate
    begin
        process(clk_i)
        begin
            if (rising_edge(clk_i)) then
                if (reset_i = '1') then
                    data_o <= '0';
                else
                    case comp is
                        when "000" | "001" | "010" | "100" => data_o <= '0';
                        when "111" | "110" | "101" | "011" => data_o <= '1';
                        when others => data_o <= '0';
                    end case;            
                end if;
            end if;
        end process;
    end generate;
    
end Behavioral;