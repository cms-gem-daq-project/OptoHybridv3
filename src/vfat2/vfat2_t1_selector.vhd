----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    11:22:49 06/30/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    vfat2_t1_selector - Behavioral 
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

entity vfat2_t1_selector is
port(

    ref_clk_i       : in std_logic;
    reset_i         : in std_logic;
    
    -- Input T1 commands
    vfat2_t1_i      : in t1_array_t(3 downto 0);    
    vfat2_t1_sel_i  : in std_logic_vector(2 downto 0);
    
    -- VFAT2 T1 line
    vfat2_t1_o      : out t1_t
    
);
end vfat2_t1_selector;

architecture Behavioral of vfat2_t1_selector is
begin

    process(ref_clk_i)
    begin    
        if (rising_edge(ref_clk_i)) then
            -- Reset & default values
            if (reset_i = '1') then
                vfat2_t1_o <= (lv1a => '0', calpulse => '0', resync => '0', bc0 => '0');
            else
                case vfat2_t1_sel_i is
                    when "000" => vfat2_t1_o <= vfat2_t1_i(0);
                    when "001" => vfat2_t1_o <= vfat2_t1_i(1);
                    when "010" => vfat2_t1_o <= vfat2_t1_i(2);
                    when "011" => vfat2_t1_o <= vfat2_t1_i(3);
                    when "100" => vfat2_t1_o <= vfat2_t1_i(0) or vfat2_t1_i(1) or vfat2_t1_i(2) or vfat2_t1_i(3);
                    when others => vfat2_t1_o <= (lv1a => '0', calpulse => '0', resync => '0', bc0 => '0');
                end case;
            end if;
        end if;
    end process;
    
end Behavioral;