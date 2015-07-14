----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    08:37:33 07/07/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    qpll - Behavioral 
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

entity qpll is
port(

    --== QPLL raw ==--

    qpll_ref_40MHz_o    : out std_logic;
    qpll_reset_o        : out std_logic;
    
    qpll_locked_i       : in std_logic;
    qpll_error_i        : in std_logic;
    
    qpll_clk_p_i        : in std_logic;
    qpll_clk_n_i        : in std_logic

    --== QPLL packed ==--
    
);
end qpll;

architecture Behavioral of qpll is

    signal qpll_ref_40MHz   : std_logic;
    signal qpll_reset       : std_logic;
    signal qpll_locked      : std_logic;
    signal qpll_error       : std_logic;
    signal qpll_clk         : std_logic;

begin    

    --==================--
    --== QPLL buffers ==--
    --==================--
    
    qpll_buffers_inst : entity work.qpll_buffers
    port map(
        -- Raw
        qpll_ref_40MHz_o    => qpll_ref_40MHz_o,
        qpll_reset_o        => qpll_reset_o,
        qpll_locked_i       => qpll_locked_i,
        qpll_error_i        => qpll_error_i,
        qpll_clk_p_i        => qpll_clk_p_i,
        qpll_clk_n_i        => qpll_clk_n_i,
        -- Buffered
        qpll_ref_40MHz_i    => qpll_ref_40MHz,
        qpll_reset_i        => qpll_reset,
        qpll_locked_o       => qpll_locked,
        qpll_error_o        => qpll_error,
        qpll_clk_o          => qpll_clk
    );

end Behavioral;

