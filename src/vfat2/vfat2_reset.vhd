----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    11:22:49 06/30/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    vfat2_reset - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description: 
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library work;
use work.types_pkg.all;

entity vfat2_reset is
port(

    ref_clk_i       : in std_logic;
    reset_i         : in std_logic;
    
    vfat2_reset_i   : in std_logic;
    
    vfat2_reset_o   : out std_logic
    
);
end vfat2_reset;

architecture Behavioral of vfat2_reset is

    signal delay    : integer range 0 to 255;

begin

    process(ref_clk_i)
    begin    
        if (rising_edge(ref_clk_i)) then
            if (reset_i = '1') then
                vfat2_reset_o <= '1';
                delay <= 0;
            else
                if (vfat2_reset_i = '1') then
                    vfat2_reset_o <= '0';
                    delay <= 255;
                elsif (delay /= 0) then
                    vfat2_reset_o <= '0';
                    delay <= delay - delay;
                else
                    vfat2_reset_o <= '1';
                end if;
            end if;
        end if;
    end process;
    
end Behavioral;