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
use ieee.numeric_std.all;

library work;
use work.types_pkg.all;

entity trigger is
port(
        
    ref_clk_i       : in std_logic;
    reset_i         : in std_logic;
    
    vfat2_sbits_i   : in sbits_array_t(23 downto 0);
    
    vfat2_t1_sel_i  : in std_logic_vector(2 downto 0);   
    sys_loop_sbit_i : in std_logic_vector(4 downto 0);   
    trigger_lim_i   : in std_logic_vector(31 downto 0);
    
    vfat2_t1_gtx_i  : in t1_t;    
    vfat2_t1_gbt_i  : in t1_t; 
    vfat2_t1_int_i  : in t1_t; 
    vfat2_t1_ext_i  : in t1_t; 
    
    vfat2_t1_loop_o : out t1_t;
    vfat2_t1_mux_o  : out t1_t

);
end trigger;

architecture Behavioral of trigger is

    signal vfat2_t1_loop    : t1_t;

begin

    --=================--
    --== T1 loopback ==--
    --=================--
    
    trigger_loopback_inst : entity work.trigger_loopback
    port map(
        ref_clk_i       => ref_clk_i,
        reset_i         => reset_i,
        vfat2_sbits_i   => vfat2_sbits_i,
        sys_loop_sbit_i => sys_loop_sbit_i,
        vfat2_t1_o      => vfat2_t1_loop
    );
    
    vfat2_t1_loop_o <= vfat2_t1_loop;
    
    --=================--
    --== T1 selector ==--
    --=================--
    
    trigger_selector_inst : entity work.trigger_selector
    port map(
        ref_clk_i       => ref_clk_i,
        reset_i         => reset_i,
        vfat2_t1_gtx_i  => vfat2_t1_gtx_i,   
        vfat2_t1_gbt_i  => vfat2_t1_gbt_i,
        vfat2_t1_int_i  => vfat2_t1_int_i,
        vfat2_t1_ext_i  => vfat2_t1_ext_i, 
        vfat2_t1_loop_i => vfat2_t1_loop, 
        vfat2_t1_sel_i  => vfat2_t1_sel_i,   
        trigger_lim_i   => trigger_lim_i,
        vfat2_t1_mux_o  => vfat2_t1_mux_o   
    );

end Behavioral;
