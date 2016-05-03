----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    08:37:33 07/07/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    qpll_buffers - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library unisim;
use unisim.vcomponents.all;

entity qpll_buffers is
port(

    --== QPLL raw ==--

    qpll_clk_p_i            : in std_logic;
    qpll_clk_n_i            : in std_logic;
    qpll_reset_o            : out std_logic;    
    qpll_locked_i           : in std_logic;    
        
    --== QPLL buffered ==--
    
    qpll_clk_o              : out std_logic;
    qpll_reset_i            : in std_logic;    
    qpll_locked_o           : out std_logic
    
);
end qpll_buffers;

architecture Behavioral of qpll_buffers is
begin    
    
    -- qpll_reset

    qpll_reset_obufds : obuf
    generic map(
        drive       => 12,
        iostandard  => "lvcmos25",
        slew        => "slow"
    )
    port map(
        i           => qpll_reset_i,
        o           => qpll_reset_o
    );
    
    -- qpll_locked_i
    
    qpll_locked_ibuf : ibuf
    generic map(
        ibuf_low_pwr    => true,
        iostandard      => "lvcmos25"
    )
    port map(
        i               => qpll_locked_i,
        o               => qpll_locked_o
    );
    
    -- qpll_clk
    
    qpll_clk_ibufgds : ibufgds
    generic map(
        diff_term       => true,
        ibuf_low_pwr    => false,
        iostandard      => "lvds_25"
    )
    port map(
        i               => qpll_clk_p_i,
        ib              => qpll_clk_n_i,
        o               => qpll_clk_o
    );
     
end Behavioral;

