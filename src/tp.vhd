----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    08:37:20 07/07/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    adc - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description: 
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library unisim;
use unisim.vcomponents.all;

library work;
use work.types_pkg.all;
use work.wb_pkg.all;

entity tp is
port(

    gbt_clk_i   : in std_logic;

    tp_1p_o     : out std_logic;
    tp_1n_o     : out std_logic;
    tp_4p_o     : out std_logic;
    tp_4n_o     : out std_logic;
    tp_5p_o     : out std_logic;
    tp_5n_o     : out std_logic;
    tp_20p_o    : out std_logic;
    tp_20n_o    : out std_logic
    
);
end tp;

architecture Behavioral of tp is  

    signal tmp_clk  : std_logic;
    signal tmp_clk2  : std_logic;

begin

    tp_1p_o  <= '0';
    tp_1n_o  <= '0';
--    tp_4p_o  <= '0';
    tp_4n_o  <= '0';
    tp_5p_o  <= '0';
    tp_5n_o  <= '0';
    tp_20p_o <= '0';
    tp_20n_o <= '0';

--    tmp_clk_oddr : oddr
--    generic map(
--        ddr_clk_edge    => "opposite_edge",
--        init            => '0',
--        srtype          => "sync"
--    )
--    port map (
--        q               => tmp_clk,
--        c               => gbt_clk_i,
--        ce              => '1',
--        d1              => '1',
--        d2              => '0',
--        r               => '0',
--        s               => '0'
--    ); 
--    
--    tmp_clk_obufds : obufds
--    port map(
--        i   => tmp_clk,
--        o   => tp_1p_o,
--        ob  => tp_1n_o
--    );   
        
    tmp_clk_oddr2 : oddr
    generic map(
        ddr_clk_edge    => "opposite_edge",
        init            => '0',
        srtype          => "sync"
    )
    port map (
        q               => tmp_clk2,
        c               => gbt_clk_i,
        ce              => '1',
        d1              => '1',
        d2              => '0',
        r               => '0',
        s               => '0'
    );    
    
    tp_4p_o <= tmp_clk2;
    
end Behavioral;