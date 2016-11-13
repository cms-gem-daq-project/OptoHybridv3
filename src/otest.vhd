library ieee;
use ieee.std_logic_1164.all;

library work;
 
entity otest is
end otest;
 
architecture behavior of otest is     

    --inputs
    signal data_out_from_device : std_logic_vector(31 downto 0) := (others => '0');
    signal clk_in : std_logic := '0';
    signal clk_div_in : std_logic := '0';
    signal io_reset : std_logic := '0';

    --outputs
    signal data_out_to_pins_p : std_logic_vector(3 downto 0);
    signal data_out_to_pins_n : std_logic_vector(3 downto 0);

    -- clock period definitions
    constant clk_in_period : time := 3.125 ns;
    constant clk_div_in_period : time := 25 ns;
 
begin
 
    -- instantiate the unit under test (uut)
    uut : entity work.to_gbt_ser
    port map (
        data_out_from_device    => data_out_from_device,
        data_out_to_pins_p      => data_out_to_pins_p,
        data_out_to_pins_n      => data_out_to_pins_n,
        clk_in                  => clk_in,
        clk_div_in              => clk_div_in,
        io_reset                => '0'
    );

    -- clock process definitions
    clk_in_process : process
    begin
        clk_in <= '0';
        wait for clk_in_period/2;
        clk_in <= '1';
        wait for clk_in_period/2;
    end process;
 
    clk_div_in_process : process
    begin
        clk_div_in <= '0';
        wait for clk_div_in_period/2;
        clk_div_in <= '1';
        wait for clk_div_in_period/2;
    end process;


    -- stimulus process
    stim_proc: process
    begin		
        data_out_from_device <= x"ffffffff";
        wait for 100 ns;	        
        data_out_from_device <= x"00000001";
        wait for clk_div_in_period;
        data_out_from_device <= x"00000002";
        wait for clk_div_in_period;
        data_out_from_device <= x"00000004";
        wait for clk_div_in_period;
        data_out_from_device <= x"00000008";
        
        wait for clk_div_in_period;
        data_out_from_device <= x"00000010";
        wait for clk_div_in_period;
        data_out_from_device <= x"00000020";
        wait for clk_div_in_period;
        data_out_from_device <= x"00000040";
        wait for clk_div_in_period;
        data_out_from_device <= x"00000080";        
        
        wait for clk_div_in_period;
        data_out_from_device <= x"00000100";
        wait for clk_div_in_period;
        data_out_from_device <= x"00000200";
        wait for clk_div_in_period;
        data_out_from_device <= x"00000400";
        wait for clk_div_in_period;
        data_out_from_device <= x"00000800";
                
        wait for clk_div_in_period;
        data_out_from_device <= x"00001000";
        wait for clk_div_in_period;
        data_out_from_device <= x"00002000";
        wait for clk_div_in_period;
        data_out_from_device <= x"00004000";
        wait for clk_div_in_period;
        data_out_from_device <= x"00008000";        
        
        wait for clk_div_in_period * 10;
        data_out_from_device <= x"00010000";
        wait for clk_div_in_period;
        data_out_from_device <= x"00020000";
        wait for clk_div_in_period;
        data_out_from_device <= x"00040000";
        wait for clk_div_in_period;
        data_out_from_device <= x"00080000";
        
        wait for clk_div_in_period;
        data_out_from_device <= x"00100000";
        wait for clk_div_in_period;
        data_out_from_device <= x"00200000";
        wait for clk_div_in_period;
        data_out_from_device <= x"00400000";
        wait for clk_div_in_period;
        data_out_from_device <= x"00800000";        
        
        wait for clk_div_in_period;
        data_out_from_device <= x"01000000";
        wait for clk_div_in_period;
        data_out_from_device <= x"02000000";
        wait for clk_div_in_period;
        data_out_from_device <= x"04000000";
        wait for clk_div_in_period;
        data_out_from_device <= x"08000000";
                
        wait for clk_div_in_period;
        data_out_from_device <= x"10000000";
        wait for clk_div_in_period;
        data_out_from_device <= x"20000000";
        wait for clk_div_in_period;
        data_out_from_device <= x"40000000";
        wait for clk_div_in_period;
        data_out_from_device <= x"80000000";

    wait;
    end process;

end;
