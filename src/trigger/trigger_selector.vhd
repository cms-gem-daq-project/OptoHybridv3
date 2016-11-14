----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    11:22:49 06/30/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    trigger_selector - Behavioral 
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

entity trigger_selector is
port(

    ref_clk_i       : in std_logic;
    reset_i         : in std_logic;
    
    -- Input T1 commands
    vfat2_t1_gtx_i  : in t1_t;    
    vfat2_t1_gbt_i  : in t1_t; 
    vfat2_t1_int_i  : in t1_t; 
    vfat2_t1_ext_i  : in t1_t; 
    vfat2_t1_loop_i : in t1_t; 
    
    vfat2_t1_sel_i  : in std_logic_vector(2 downto 0);    
    trigger_lim_i   : in std_logic_vector(31 downto 0);
    
    -- VFAT2 T1 line
    vfat2_t1_mux_o  : out t1_t
    
);
end trigger_selector;

architecture Behavioral of trigger_selector is
    
    -- Non throttled t1
    signal vfat2_t1 : t1_t;

    -- Trigger counter
    signal t1_cnt   : unsigned(31 downto 0);

begin

    process(ref_clk_i)
    begin    
        if (rising_edge(ref_clk_i)) then
            -- Reset & default values
            if (reset_i = '1') then
                vfat2_t1 <= (lv1a => '0', calpulse => '0', resync => '0', bc0 => '0');
            else
                case vfat2_t1_sel_i is
                    when "000" => vfat2_t1 <= vfat2_t1_gtx_i; -- GTX
                    when "001" => vfat2_t1 <= vfat2_t1_int_i; -- Internal
                    when "010" => vfat2_t1 <= vfat2_t1_ext_i; -- External
                    when "011" => vfat2_t1 <= vfat2_t1_loop_i; -- Loop
                    when "100" => vfat2_t1 <= vfat2_t1_gtx_i or vfat2_t1_ext_i or vfat2_t1_int_i or vfat2_t1_loop_i or vfat2_t1_gbt_i; -- All
                    when "101" => vfat2_t1 <= vfat2_t1_gbt_i; -- GBT
                    when "110" => vfat2_t1 <= vfat2_t1_gbt_i or vfat2_t1_gtx_i; -- GBT or GTX
                    when "111" => vfat2_t1 <= vfat2_t1_int_i or vfat2_t1_ext_i; -- Internal or External
                    when others => vfat2_t1 <= (lv1a => '0', calpulse => '0', resync => '0', bc0 => '0');
                end case;
            end if;
        end if;
    end process;

    process(ref_clk_i)
    begin    
        if (rising_edge(ref_clk_i)) then
            -- Reset & default values
            if (reset_i = '1') then
                vfat2_t1_mux_o <= (lv1a => '0', calpulse => '0', resync => '0', bc0 => '0');
                t1_cnt <= (others => '0');
            else
                if (vfat2_t1.lv1a = '1') then
                    if (trigger_lim_i = x"00000000") then
                        vfat2_t1_mux_o.lv1a <= '1';
                    elsif (t1_cnt >= unsigned(trigger_lim_i)) then
                        vfat2_t1_mux_o.lv1a <= '1';
                        t1_cnt <= x"00000001";
                    else
                        vfat2_t1_mux_o.lv1a <= '0';
                        t1_cnt <= t1_cnt + 1;
                    end if;
                else
                    vfat2_t1_mux_o.lv1a <= '0';
                end if;
                vfat2_t1_mux_o.calpulse <= vfat2_t1.calpulse;
                vfat2_t1_mux_o.resync <= vfat2_t1.resync;
                vfat2_t1_mux_o.bc0 <= vfat2_t1.bc0;
            end if;
        end if;
    end process;
    
end Behavioral;