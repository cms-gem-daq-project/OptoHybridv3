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
-- Controls the QPLL
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

entity qpll is
port(

    qpll_ref_40MHz_o    : out std_logic;
    qpll_reset_o        : out std_logic;
    
    qpll_locked_i       : in std_logic;
    qpll_error_i        : in std_logic;
    
    qpll_clk_p_i        : in std_logic;
    qpll_clk_n_i        : in std_logic
    
);
end qpll;

architecture Behavioral of qpll is

    signal qpll_ref_clk : std_logic;

begin    

    --==========================--
    --== Output clock buffers ==--
    --==========================--
    
    cdce_clk_pri_oddr : oddr
    generic map(
        ddr_clk_edge    => "opposite_edge",
        init            => '0',
        srtype          => "sync"
    )
    port map (
        q               => qpll_ref_clk,
        c               => '0', -- clock
        ce              => '1',
        d1              => '1',
        d2              => '0',
        r               => '0',
        s               => '0'
    );    

    cdce_clk_pri_obuf : obuf
    generic map(
        drive       => 12,
        iostandard  => "lvcmos25",
        slew        => "fast"
    )
    port map(
        i           => qpll_ref_clk,
        o           => qpll_ref_40MHz_o
    );

    --================--
    --== NULL logic ==--
    --================--

    qpll_reset_o <= '0';

end Behavioral;

