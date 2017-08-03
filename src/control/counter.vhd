----------------------------------------------------------------------------------
-- CMS Muon Endcap
-- GEM Collaboration
-- Optohybrid v3 Firmware -- Counter
-- T. Lenzi
----------------------------------------------------------------------------------
-- Description:
--   This module implements base level functionality for a single counter
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.types_pkg.all;

entity counter is
port(

    ref_clk_i   : in std_logic;
    reset_i     : in std_logic;

    en_i        : in std_logic;

    data_o      : out std_logic_vector(31 downto 0)

);
end counter;

architecture Behavioral of counter is

    signal data : unsigned(31 downto 0) := x"ffffffff";

begin

    process(ref_clk_i)
    begin
        if (rising_edge(ref_clk_i)) then
            if (reset_i = '1') then
                data_o <= (others => '0');
                data <= (others => '0');
            else
                if (en_i = '1') then
                    data <= data + 1;
                end if;
                data_o <= std_logic_vector(data);
            end if;
        end if;
    end process;

end Behavioral;
