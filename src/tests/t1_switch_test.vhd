----------------------------------------------------------------------------------
-- company:        iihe - ulb
-- engineer:       thomas lenzi (thomas.lenzi@cern.ch)
-- 
-- create date:    08:31:58 07/03/2015
-- design name:    optohybrid v2
-- module name:    t1_switch_test - behavioral 
-- project name:   optohybrid v2
-- target devices: xc6vlx130t-1ff1156
-- tool versions:  ise  p.20131013
-- description:    
-- 
-- dependencies:
-- 
-- revision:
-- revision 0.01 - file created
-- additional comments:
--
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
 
library work;
use work.types_pkg.all;

entity t1_switch_test is
end t1_switch_test;
 
architecture behavior of t1_switch_test is 
  
    --inputs
    signal ref_clk_i        : std_logic;
    signal reset_i          : std_logic;
    signal t1_i             : t1_array_t(3 downto 0);
    signal mask_i           : std_logic_vector(3 downto 0);

    --outputs
    signal t1_o             : t1_t;

    constant ref_clk_period : time := 10 ns;
 
begin
 
    -- instantiate the unit under test (uut)
    uut: entity work.t1_switch 
    generic map(
        ASYNC       => false,
        WIDTH       => 4
    )
    port map (
        ref_clk_i   => ref_clk_i,
        reset_i     => reset_i,
        t1_i        => t1_i,
        mask_i      => mask_i,
        t1_o        => t1_o
    );

    -- Clock process definitions
    ref_clk_process : process
    begin
        ref_clk_i <= '1';
        wait for ref_clk_period / 2;
        ref_clk_i <= '0';
        wait for ref_clk_period / 2;
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
        t1_i <= (others => (others => '0'));
        wait for 150 ns;
        --
        mask_i <= "0000";
        t1_i(0).lv1a <= '1';
        wait for ref_clk_period;
        t1_i(0).lv1a <= '0';
        wait for ref_clk_period * 2;
        --
        mask_i <= "0001";
        t1_i(0).lv1a <= '1';
        wait for ref_clk_period;
        t1_i(0).lv1a <= '0';
        wait for ref_clk_period * 2;
        --
        mask_i <= "0001";
        t1_i(2).lv1a <= '1';
        wait for ref_clk_period;
        t1_i(2).lv1a <= '0';
        wait for ref_clk_period * 2;
        --
        mask_i <= "0110";
        t1_i(3).lv1a <= '1';
        wait for ref_clk_period;
        t1_i(3).lv1a <= '0';
        wait for ref_clk_period * 2;
        --
        mask_i <= "0110";
        t1_i(1).lv1a <= '1';
        wait for ref_clk_period;
        t1_i(1).lv1a <= '0';
        wait for ref_clk_period * 2;
        --
    end process;

end;
