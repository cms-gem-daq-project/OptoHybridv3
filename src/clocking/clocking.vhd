----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    09:10:11 09/15/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    clocking - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description: 
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.types_pkg.all;

entity clocking is
port(

    reset_i             : in std_logic;

    -- Input clocks
    clk_onboard_i       : in std_logic;
    clk_gtx_rec_i       : in std_logic;
    clk_ext_i           : in std_logic;

    cdce_pll_locked_i   : in std_logic;
    sys_clk_sel_i       : in std_logic_vector(1 downto 0);

    -- Output reference clock
    ref_clk_o           : out std_logic;
    rec_pll_locked_o    : out std_logic;
    switch_mode_o       : out std_logic
    
);
end clocking;

architecture Behavioral of clocking is

    signal clk_rec          : std_logic;
    signal rec_pll_locked   : std_logic;
    signal operate_switch   : std_logic;

begin    

    rec_pll_locked_o <= rec_pll_locked;
    switch_mode_o <= operate_switch;
    
    --== GTX PLL ==--
    
    gtx_rec_pll_inst : entity work.gtx_rec_pll
    port map(
        clk_160MHz_i    => clk_gtx_rec_i,
        clk_40MHz_o     => clk_rec,
        reset_i         => '0',
        locked_o        => rec_pll_locked
    );
    
    --== Clock mux ==--

    ref_clk_o <= clk_rec when sys_clk_sel_i= "01" else
                 clk_ext_i when sys_clk_sel_i = "10" else
                 clk_onboard_i when sys_clk_sel_i = "11" else
                 clk_onboard_i when (sys_clk_sel_i = "00" and operate_switch = '0') else
                 clk_rec when (sys_clk_sel_i = "00" and operate_switch = '1') else
                 clk_onboard_i;
                 
    --== Clock switch ==--             
                 
    clock_switch_inst : entity work.clock_switch 
    port map(
        start           => rec_pll_locked,
        c_lock          => cdce_pll_locked_i,
        clk1            => clk_onboard_i,
        clk2            => clk_rec,
        clk3            => clk_gtx_rec_i,
        clk_edge        => open,
        state           => open,
        done            => operate_switch,
        counter         => open,
        clk_condition   => open,
        reset           => open
    );
                 
                 
end Behavioral;

