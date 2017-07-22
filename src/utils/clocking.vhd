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

    -- fixed phase 320 MHz e-port clocks
    gbt_eclk_p  : in std_logic_vector (1 downto 0);
    gbt_eclk_n  : in std_logic_vector (1 downto 0);

    -- programmable frequency/phase deskew clocks
    gbt_dclk_p : in std_logic_vector(1 downto 0);
    gbt_dclk_n : in std_logic_vector(1 downto 0);

    -- eport 40/320 serdes clocks
    gbt_clk1x_o     : out std_logic;
    gbt_clk8x_o     : out std_logic;

    -- logic clocks
    clk_1x_o        : out std_logic;
    clk_2x_o        : out std_logic;
    clk_4x_o        : out std_logic;
    clk_4x_90_o     : out std_logic;

    -- mmcm locked status monitors
    dskw_mmcm_locked_o   : out std_logic;
    eprt_mmcm_locked_o   : out std_logic;

    mmcms_locked_o   : out std_logic

);
end clocking;


architecture Behavioral of clocking is

    signal gbt_dclk     : std_logic_vector (1 downto 0);
    signal dclk_ibufgds : std_logic_vector (1 downto 0);

    signal mmcm_locked : std_logic_vector(1 downto 0);

begin

    --------- GBT DSKW TTC Clock 0 ---------

    ibufgds_dclk0 : IBUFGDS
    generic map(
        iostandard      => "lvds_25"
    )
    port map(
        I   => gbt_dclk_p(0),
        IB  => gbt_dclk_n(0),
        O   => dclk_ibufgds(0)
    );

    bufg_dclk0 : BUFG
    port map(
        I   => dclk_ibufgds(0),
        O   => gbt_dclk(0)
    );

    --------- GBT DSKW TTC Clock 1 ---------

    ibufgds_dclk1 : IBUFGDS
    generic map(
        iostandard      => "lvds_25"
    )
    port map(
        I   => gbt_dclk_p(1),
        IB  => gbt_dclk_n(1),
        O   => dclk_ibufgds(1)
    );

    bufg_dclk1 : BUFG
    port map(
        I   => dclk_ibufgds(1),
        O   => gbt_dclk(1)
    );

    --------- MMCMs ---------

    clk_gen0 : entity work.clk_gen
    port map(

        clk40_i     => gbt_dclk(0),

        clk40_o     => clk_1x_o,
        clk80_o     => clk_2x_o,
        clk160_o    => clk_4x_o,
        clk160_90_o => clk_4x_90_o,
        locked_o    => mmcm_locked(0)
    );

    clk_gen1 : entity work.eprt_clk_gen
    port map(

        clk40_i     => gbt_dclk(1),

        clk40_o     => gbt_clk1x_o,
        clk320_o    => gbt_clk8x_o,
        locked_o    => mmcm_locked(1)
    );

    mmcms_locked_o <= mmcm_locked(0) and mmcm_locked(1);

    dskw_mmcm_locked_o <= mmcm_locked(0);
    eprt_mmcm_locked_o <= mmcm_locked(1);

end Behavioral;
