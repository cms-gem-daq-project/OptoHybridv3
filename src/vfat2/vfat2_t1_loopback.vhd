----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    11:22:49 06/30/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    vfat2_t1_loopback - Behavioral 
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

entity vfat2_t1_loopback is
port(

    ref_clk_i       : in std_logic;
    reset_i         : in std_logic;
    
    -- SBits
    vfat2_sbits_i   : in sbits_array_t(23 downto 0);
    sys_loop_sbit_i : in std_logic_vector(4 downto 0);
    
    -- VFAT2 T1 line
    vfat2_t1_o      : out t1_t
    
);
end vfat2_t1_loopback;

architecture Behavioral of vfat2_t1_loopback is
begin

    process(ref_clk_i)
    begin    
        if (rising_edge(ref_clk_i)) then
            -- Reset & default values
            if (reset_i = '1') then
                vfat2_t1_o <= (lv1a => '0', calpulse => '0', resync => '0', bc0 => '0');
            else                
                if (vfat2_sbits_i(to_integer(unsigned(sys_loop_sbit_i))) /= "00000000") then
                    vfat2_t1_o <= (lv1a => '1', calpulse => '0', resync => '0', bc0 => '0');
                else
                    vfat2_t1_o <= (lv1a => '0', calpulse => '0', resync => '0', bc0 => '0');
                end if;                    
            end if;
        end if;
    end process;
    
end Behavioral;