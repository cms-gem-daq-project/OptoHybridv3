----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
--
-- Create Date:    12:59:03 09/30/2015
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

library unisim;
use unisim.vcomponents.all;

library work;
use work.types_pkg.all;
use work.param_pkg.all;

entity clocking is
port(


    gbt_eclk_p  : in std_logic_vector (1 downto 0) ;
    gbt_eclk_n  : in std_logic_vector (1 downto 0) ;

    gbt_dclk_p : in std_logic_vector (1 downto 0) ;
    gbt_dclk_n : in std_logic_vector (1 downto 0);

    clk_1x_o        : out std_logic;
    clk_2x_o        : out std_logic;
    clk_4x_o        : out std_logic;
    clk_4x_90_o     : out std_logic;

    gbt_eclk_o      : out std_logic

);
end clocking;


architecture Behavioral of clocking is

    signal gbt_eclk : std_logic ;
    signal gbt_dclk : std_logic ;
    signal eclk_ibufgds : std_logic;
    signal dclk_ibufgds : std_logic;

begin

    --------- GBT EPORT Clock ---------

    ibufgds_eclk : IBUFGDS
    generic map(
        iostandard      => "lvds_25"
    )
    port map(
        I   => gbt_eclk_p(0),
        IB  => gbt_eclk_n(0),
        O   => eclk_ibufgds
    );

    bufg_eclk : BUFG
    port map(
        I   => eclk_ibufgds,
        O   => gbt_eclk_o
    );

    --------- GBT DSKW Clock ---------

    ibufgds_dclk : IBUFGDS
    generic map(
        iostandard      => "lvds_25"
    )
    port map(
        I   => gbt_dclk_p(0),
        IB  => gbt_dclk_n(0),
        O   => dclk_ibufgds
    );

    bufg_dclk : BUFG
    port map(
        I   => dclk_ibufgds,
        O   => gbt_dclk
    );

    --------- MMCM ---------

    clk_gen_inst : entity work.clk_gen
    port map(
        clk_i       => gbt_dclk,
        clk_1x_o    => clk_1x_o,
        clk_2x_o    => clk_2x_o,
        clk_4x_o    => clk_4x_o,
        clk_4x_90_o => clk_4x_90_o
    );


end Behavioral;

