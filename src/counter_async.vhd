----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    15:17:59 07/09/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    counter - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description: 
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.types_pkg.all;

entity counter_async is
port(

    reset_i     : in std_logic;
    
    en_i        : in std_logic;
    
    data_o      : out std_logic_vector(31 downto 0)
    
);
end counter_async;

architecture Behavioral of counter_async is

    signal data : unsigned(31 downto 0);

begin

    process(en_i)
    begin
        if (reset_i = '1') then
            data <= (others => '0');
        elsif (en_i = '1' and en_i'last_value = '0') then
            data <= data + 1;
        end if;
    end process;
    
    data_o <= std_logic_vector(data);

end Behavioral;