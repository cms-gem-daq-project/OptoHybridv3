----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    13:13:21 03/12/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    seu_voter_vector_test - Behavioral 
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
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library work;
 
entity seu_voter_vector_test is
end seu_voter_vector_test;
 
architecture behavior of seu_voter_vector_test is     

    --Inputs
    signal clk_i         : std_logic;
    signal reset_i      : std_logic;
    signal data_0_i     : std_logic_vector(3 downto 0);
    signal data_1_i     : std_logic_vector(3 downto 0);
    signal data_2_i     : std_logic_vector(3 downto 0);

    --Outputs
    signal data_o       : std_logic_vector(3 downto 0);

    constant clk_period : time := 25 ns;
 
begin
 
    -- Instantiate the Unit Under Test (UUT)
    uut : entity work.seu_voter_vector 
    generic map(
        ASYNC       => false,
        WIDTH       => 4
    )
    port map(
        clk_i       => clk_i,
        reset_i     => reset_i,
        data_0_i    => data_0_i,
        data_1_i    => data_1_i,
        data_2_i    => data_2_i,
        data_o      => data_o
    );

    -- Clock process definitions
    clk_process : process
    begin
        clk_i <= '1';
        wait for clk_period / 2;
        clk_i <= '0';
        wait for clk_period / 2;
    end process;
    
    -- Reset process
    reset_proc : process
    begin		
        reset_i <= '1';
        wait for 100 ns;
        reset_i <= '0';
        wait;
    wait;
    end process;
    
    -- Data process
    data_proc : process
    begin
        wait for 120 ns;
        data_0_i <= "0111";
        data_1_i <= "1101";
        data_2_i <= "1011";
        wait for clk_period * 10;
        data_0_i <= "1000";
        data_1_i <= "0010";
        data_2_i <= "0100";
        wait for clk_period * 10;
        data_0_i <= "0110";
        data_1_i <= "0110";
        data_2_i <= "0110";
        wait;
    end process;

end;
