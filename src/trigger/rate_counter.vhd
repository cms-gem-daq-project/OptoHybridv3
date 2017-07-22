------------------------------------------------------------------------------------------------------------------------------------------------------
-- Company: TAMU
-- Engineer: Evaldas Juska (evaldas.juska@cern.ch, evka85@gmail.com)
-- 
-- Create Date:    15:04 2016-05-10
-- Module Name:    rate_counter
-- Description:    this module counts the rate in Hz of a given signal  
------------------------------------------------------------------------------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rate_counter is
    generic(
        g_CLK_FREQUENCY         : std_logic_vector(31 downto 0) := x"02638e98";
        g_COUNTER_WIDTH         : integer := 26;
        g_INCREMENTER_WIDTH     : integer := 8;
        g_PROGRESS_BAR_WIDTH    : integer := 13;
        g_PROGRESS_BAR_STEP     : integer := 20_000;
        g_SPEEDUP_FACTOR        : integer := 4 -- shifts the wait period to the right by this amount, then shifts the count to the left by the same amount (so step size still represents true value)
    );
    port(
        clk_i           : in  std_logic;
        reset_i         : in  std_logic;
        increment_i     : in  std_logic_vector(g_INCREMENTER_WIDTH - 1 downto 0);
        rate_o          : out std_logic_vector(g_COUNTER_WIDTH - 1 downto 0);
        progress_bar_o  : out std_logic_vector(g_PROGRESS_BAR_WIDTH - 1 downto 0)
    );
end rate_counter;

architecture rate_counter_arch of rate_counter is
    
    constant max_count  : unsigned(g_COUNTER_WIDTH - 1 downto 0) := (others => '1');
    signal count        : unsigned(g_COUNTER_WIDTH - 1 downto 0) := (others => '0');
    signal increment    : std_logic_vector(g_COUNTER_WIDTH - 1 downto 0) := (others => '0');
    signal timer        : unsigned(31 downto 0);
    
begin

    increment(g_INCREMENTER_WIDTH - 1 downto 0) <= increment_i;

    p_count:
    process (clk_i) is
    begin
        if rising_edge(clk_i) then
            if reset_i = '1' then
                count <= (others => '0');
                timer <= (others => '0');
            else
                if timer < unsigned(unsigned(g_CLK_FREQUENCY) srl g_SPEEDUP_FACTOR) then -- sll divides by speedup
                    timer <= timer + 1;
                    count <= unsigned(count + unsigned(increment)) sll g_SPEEDUP_FACTOR ;
                else
                    timer <= (others => '0');
                    count <= (others => '0');
                    rate_o <= std_logic_vector(count);
                    for i in 0 to g_PROGRESS_BAR_WIDTH - 1 loop
                        if (count > to_unsigned(g_PROGRESS_BAR_STEP * (i + 1), g_COUNTER_WIDTH)) then
                            progress_bar_o(i) <= '1';
                        else
                            progress_bar_o(i) <= '0';
                        end if;
                    end loop;
                end if;
            end if;
        end if;
    end process;
    

end rate_counter_arch;
