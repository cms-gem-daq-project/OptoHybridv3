----------------------------------------------------------------------------------
-- CMS Muon Endcap
-- GEM Collaboration
-- Optohybrid v3 Firmware -- Clocking
-- 2017/07/21 -- Initial port to version 3 electronics
-- 2017/07/22 -- Additional MMCM added to monitor and dejitter the eport clock
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

    clock_source_i : in std_logic;

    gbt_eclk_p  : in std_logic_vector (1 downto 0) ;
    gbt_eclk_n  : in std_logic_vector (1 downto 0) ;

    gbt_dclk_p : in std_logic_vector (1 downto 0) ;
    gbt_dclk_n : in std_logic_vector (1 downto 0);

    clk_1x_o        : out std_logic;
    clk_2x_o        : out std_logic;
    clk_4x_o        : out std_logic;
    clk_4x_90_o     : out std_logic;

    dskw_mmcm_locked_o   : out std_logic;
    eprt_mmcm_locked_o   : out std_logic;

    mmcms_locked_o   : out std_logic;

    gbt_eclk_o : out std_logic

);
end clocking;


architecture Behavioral of clocking is

    signal gbt_eclk : std_logic ;
    signal gbt_dclk : std_logic ;
    signal eclk_ibufgds : std_logic;
    signal dclk_ibufgds : std_logic;

    signal eprt_clk40       : std_logic;
    signal eprt_clk80       : std_logic;
    signal eprt_clk160      : std_logic;
    signal eprt_clk160_90   : std_logic;
    signal eprt_mmcm_locked : std_logic;

    signal dskw_clk40       : std_logic;
    signal dskw_clk80       : std_logic;
    signal dskw_clk160      : std_logic;
    signal dskw_clk160_90   : std_logic;
    signal dskw_mmcm_locked : std_logic;

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
        O   => gbt_eclk
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

    --------- Deskew Clock ---------

    clk_gen_inst : entity work.clk_gen
    port map(
        clk40_i     => gbt_dclk,
        clk40_o     => dskw_clk40,
        clk80_o     => dskw_clk80,
        clk160_o    => dskw_clk160,
        clk160_90_o => dskw_clk160_90,
        locked_o    => dskw_mmcm_locked_o
    );

    --------- Eport Clock ---------

    eclk_gen_inst : entity work.eprt_clk_gen
    port map(
        clk80_i     => gbt_eclk,
        clk40_o     => dskw_clk40,
        clk80_o     => dskw_clk80,
        clk160_o    => dskw_clk160,
        clk160_90_o => dskw_clk160_90,
        locked_o    => eprt_mmcm_locked_o
    );

    clk_1x_o    <= eprt_clk40      when (clock_source_i='1') else dskw_clk40;
    clk_2x_o    <= eprt_clk80      when (clock_source_i='1') else dskw_clk80;
    clk_4x_o    <= eprt_clk160     when (clock_source_i='1') else dskw_clk160;
    clk_4x_90_o <= eprt_clk160_90  when (clock_source_i='1') else dskw_clk160_90;

    mmcms_locked_o <= dskw_mmcm_locked and eprt_mmcm_locked;
    dskw_mmcm_locked_o <= dskw_mmcm_locked;
    eprt_mmcm_locked_o <= eprt_mmcm_locked;

end Behavioral;

