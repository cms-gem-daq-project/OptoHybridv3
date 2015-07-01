----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    13:13:21 03/12/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    seu_voter_vector - Behavioral 
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

entity seu_voter_vector is
generic(
    ASYNC       : boolean := true;
    WIDTH       : integer := 32
);
port(
    clk_i       : in std_logic;
    reset_i     : in std_logic;
    data_0_i    : in std_logic_vector((WIDTH - 1) downto 0);
    data_1_i    : in std_logic_vector((WIDTH - 1) downto 0);
    data_2_i    : in std_logic_vector((WIDTH - 1) downto 0);
    data_o      : out std_logic_vector((WIDTH - 1) downto 0)
);
end seu_voter_vector;

architecture Behavioral of seu_voter_vector is

    type arrayNx3 is array((WIDTH - 1) downto 0) of std_logic_vector(2 downto 0);
    
    signal comp : arrayNx3;

begin

    --== Reformat data ==--
    
    format_loop : for I in 0 to (WIDTH - 1) generate
    begin
        comp(I) <= data_2_i(I) & data_1_i(I) & data_0_i(I);
    end generate;    

    --== Asynchronous voter ==--
    
    async_gen : if ASYNC = true generate
    begin
        async_loop : for I in 0 to (WIDTH - 1) generate
        begin
            with comp(I) select data_o(I) <= 
                '0' when "000" | "001" | "010" | "100",
                '1' when "111" | "110" | "101" | "011",
                '0' when others;
        end generate;
    end generate;
    
    --== Synchronous voter ==--
    
    sync_gen : if ASYNC = false generate
    begin        
        process(clk_i)
        begin
            if (rising_edge(clk_i)) then
                if (reset_i = '1') then
                    data_o <= (others => '0');
                else  
                    sync_loop : for I in 0 to (WIDTH - 1) loop
                        case comp(I) is
                            when "000" | "001" | "010" | "100" => data_o(I) <= '0';
                            when "111" | "110" | "101" | "011" => data_o(I) <= '1';
                            when others => data_o(I) <= '0';
                        end case;  
                    end loop;         
                end if;
            end if;
        end process;
    end generate;
    
end Behavioral;