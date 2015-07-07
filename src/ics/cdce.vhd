----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    08:37:33 07/07/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    cdce - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description: 
--
-- Controls the CDCE registers
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

entity cdce is
port(
    
    cdce_clk_p_i        : in std_logic;
    cdce_clk_n_i        : in std_logic;
    
    cdce_clk_pri_p_o    : out std_logic;
    cdce_clk_pri_n_o    : out std_logic;

    cdce_aux_o          : out std_logic;
    cdce_aux_i          : in std_logic;
    cdce_ref_o          : out std_logic;
    cdce_pwrdown_o      : out std_logic;
    cdce_sync_o         : out std_logic;
    cdce_locked_i       : in std_logic;
    
    cdce_sck_o          : out std_logic;
    cdce_mosi_o         : out std_logic;
    cdce_le_o           : out std_logic;
    cdce_miso_i         : in std_logic
    
);
end cdce;

architecture Behavioral of cdce is

    signal cdce_clk_pri : std_logic;

begin

    --== CDCE primary clock ==--
    
    cdce_clk_pri_oddr : oddr
    generic map(
        ddr_clk_edge => "opposite_edge",
        init => '0',
        srtype => "sync"
    )
    port map (
        q   => cdce_clk_pri,
        c   => '0', -- clock
        ce  => '1',
        d1  => '1',
        d2  => '0',
        r   => '0',
        s   => '0'
    );    

    cdce_clk_pri_obufds : obufds
    port map(
        i   => cdce_clk_pri,
        o   => cdce_clk_pri_p_o,
        ob  => cdce_clk_pri_n_o
    );

    --== ==--
    
    cdce_aux_o <= '1';
    cdce_ref_o <= '1';
    cdce_pwrdown_o <= '1';
    cdce_sync_o <= '1';
    
    --== SPI ==--

    cdce_sck_o <= '1';
    cdce_mosi_o <= '1';
    cdce_le_o <= '1';

end Behavioral;

