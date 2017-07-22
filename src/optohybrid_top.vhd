----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
--
-- Create Date:    13:13:21 03/12/2015
-- Design Name:    OptoHybrid v2
-- Module Name:    optohybrid_top - Behavioral
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description:
--
-- Top Level of the design
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

use IEEE.Numeric_STD.all;


library work;
use work.types_pkg.all;
use work.wb_pkg.all;

entity optohybrid_top is
port(

    --== Memory ==--

--    multiboot_rs_o          : out std_logic_vector(1 downto 0);

--    flash_address_o         : out std_logic_vector(22 downto 0);
--    flash_data_io           : inout std_logic_vector(15 downto 0);
--    flash_chip_enable_b_o   : out std_logic;
--    flash_out_enable_b_o    : out std_logic;
--    flash_write_enable_b_o  : out std_logic;
--    flash_latch_enable_b_o  : out std_logic;

    --== Clocking ==--

    gbt_eclk_p  : in std_logic_vector (1 downto 0) ;
    gbt_eclk_n  : in std_logic_vector (1 downto 0) ;

    gbt_dclk_p : in std_logic_vector (1 downto 0) ;
    gbt_dclk_n : in std_logic_vector (1 downto 0) ;

    --== Miscellaneous ==--

    elink_i : in std_logic_vector (1 downto 0) ;
    elink_o : in std_logic_vector (1 downto 0) ;

    sca_io     : inout  std_logic_vector (3 downto 0);

    hdmi_p                  : inout std_logic_vector (3 downto 0);
    hdmi_n                  : inout std_logic_vector (3 downto 0);

    led_o                   : out std_logic_vector (15 downto 0);

    gbt_txvalid : out std_logic;
    gbt_txready : in std_logic;

    gbt_rxvalid : in std_logic;
    gbt_rxready : in std_logic;

    ext_reset   : out std_logic_vector (11 downto 0);

    --== VFAT Mezzanine ==--


    --== GTX ==--

    mgt_clk_p_i             : in std_logic;
    mgt_clk_n_i             : in std_logic;

    mgt_tx_p_o              : out std_logic_vector(3 downto 0);
    mgt_tx_n_o              : out std_logic_vector(3 downto 0);

    --== VFAT2s Data ==--

    vfat0_SoT_p_i  : in std_logic;
    vfat0_SoT_n_i  : in std_logic;
    vfat1_SoT_p_i  : in std_logic;
    vfat1_SoT_n_i  : in std_logic;
    vfat2_SoT_p_i  : in std_logic;
    vfat2_SoT_n_i  : in std_logic;
    vfat3_SoT_p_i  : in std_logic;
    vfat3_SoT_n_i  : in std_logic;
    vfat4_SoT_p_i  : in std_logic;
    vfat4_SoT_n_i  : in std_logic;
    vfat5_SoT_p_i  : in std_logic;
    vfat5_SoT_n_i  : in std_logic;
    vfat6_SoT_p_i  : in std_logic;
    vfat6_SoT_n_i  : in std_logic;
    vfat7_SoT_p_i  : in std_logic;
    vfat7_SoT_n_i  : in std_logic;
    vfat8_SoT_p_i  : in std_logic;
    vfat8_SoT_n_i  : in std_logic;
    vfat9_SoT_p_i  : in std_logic;
    vfat9_SoT_n_i  : in std_logic;
    vfat10_SoT_p_i : in std_logic;
    vfat10_SoT_n_i : in std_logic;
    vfat11_SoT_p_i : in std_logic;
    vfat11_SoT_n_i : in std_logic;
    vfat12_SoT_p_i : in std_logic;
    vfat12_SoT_n_i : in std_logic;
    vfat13_SoT_p_i : in std_logic;
    vfat13_SoT_n_i : in std_logic;
    vfat14_SoT_p_i : in std_logic;
    vfat14_SoT_n_i : in std_logic;
    vfat15_SoT_p_i : in std_logic;
    vfat15_SoT_n_i : in std_logic;
    vfat16_SoT_p_i : in std_logic;
    vfat16_SoT_n_i : in std_logic;
    vfat17_SoT_p_i : in std_logic;
    vfat17_SoT_n_i : in std_logic;
    vfat18_SoT_p_i : in std_logic;
    vfat18_SoT_n_i : in std_logic;
    vfat19_SoT_p_i : in std_logic;
    vfat19_SoT_n_i : in std_logic;
    vfat20_SoT_p_i : in std_logic;
    vfat20_SoT_n_i : in std_logic;
    vfat21_SoT_p_i : in std_logic;
    vfat21_SoT_n_i : in std_logic;
    vfat22_SoT_p_i : in std_logic;
    vfat22_SoT_n_i : in std_logic;
    vfat23_SoT_p_i : in std_logic;
    vfat23_SoT_n_i : in std_logic;

    vfat0_sbits_p_i  : in std_logic_vector(7 downto 0);
    vfat0_sbits_n_i  : in std_logic_vector(7 downto 0);
    vfat1_sbits_p_i  : in std_logic_vector(7 downto 0);
    vfat1_sbits_n_i  : in std_logic_vector(7 downto 0);
    vfat2_sbits_p_i  : in std_logic_vector(7 downto 0);
    vfat2_sbits_n_i  : in std_logic_vector(7 downto 0);
    vfat3_sbits_p_i  : in std_logic_vector(7 downto 0);
    vfat3_sbits_n_i  : in std_logic_vector(7 downto 0);
    vfat4_sbits_p_i  : in std_logic_vector(7 downto 0);
    vfat4_sbits_n_i  : in std_logic_vector(7 downto 0);
    vfat5_sbits_p_i  : in std_logic_vector(7 downto 0);
    vfat5_sbits_n_i  : in std_logic_vector(7 downto 0);
    vfat6_sbits_p_i  : in std_logic_vector(7 downto 0);
    vfat6_sbits_n_i  : in std_logic_vector(7 downto 0);
    vfat7_sbits_p_i  : in std_logic_vector(7 downto 0);
    vfat7_sbits_n_i  : in std_logic_vector(7 downto 0);
    vfat8_sbits_p_i  : in std_logic_vector(7 downto 0);
    vfat8_sbits_n_i  : in std_logic_vector(7 downto 0);
    vfat9_sbits_p_i  : in std_logic_vector(7 downto 0);
    vfat9_sbits_n_i  : in std_logic_vector(7 downto 0);
    vfat10_sbits_p_i : in std_logic_vector(7 downto 0);
    vfat10_sbits_n_i : in std_logic_vector(7 downto 0);
    vfat11_sbits_p_i : in std_logic_vector(7 downto 0);
    vfat11_sbits_n_i : in std_logic_vector(7 downto 0);
    vfat12_sbits_p_i : in std_logic_vector(7 downto 0);
    vfat12_sbits_n_i : in std_logic_vector(7 downto 0);
    vfat13_sbits_p_i : in std_logic_vector(7 downto 0);
    vfat13_sbits_n_i : in std_logic_vector(7 downto 0);
    vfat14_sbits_p_i : in std_logic_vector(7 downto 0);
    vfat14_sbits_n_i : in std_logic_vector(7 downto 0);
    vfat15_sbits_p_i : in std_logic_vector(7 downto 0);
    vfat15_sbits_n_i : in std_logic_vector(7 downto 0);
    vfat16_sbits_p_i : in std_logic_vector(7 downto 0);
    vfat16_sbits_n_i : in std_logic_vector(7 downto 0);
    vfat17_sbits_p_i : in std_logic_vector(7 downto 0);
    vfat17_sbits_n_i : in std_logic_vector(7 downto 0);
    vfat18_sbits_p_i : in std_logic_vector(7 downto 0);
    vfat18_sbits_n_i : in std_logic_vector(7 downto 0);
    vfat19_sbits_p_i : in std_logic_vector(7 downto 0);
    vfat19_sbits_n_i : in std_logic_vector(7 downto 0);
    vfat20_sbits_p_i : in std_logic_vector(7 downto 0);
    vfat20_sbits_n_i : in std_logic_vector(7 downto 0);
    vfat21_sbits_p_i : in std_logic_vector(7 downto 0);
    vfat21_sbits_n_i : in std_logic_vector(7 downto 0);
    vfat22_sbits_p_i : in std_logic_vector(7 downto 0);
    vfat22_sbits_n_i : in std_logic_vector(7 downto 0);
    vfat23_sbits_p_i : in std_logic_vector(7 downto 0);
    vfat23_sbits_n_i : in std_logic_vector(7 downto 0)

);
end optohybrid_top;

architecture Behavioral of optohybrid_top is

    --== SBit cluster packer ==--

    signal sbit_overflow : std_logic;
    signal sbit_mask     : std_logic_vector     (23 downto 0);
    signal sbit_clusters : sbit_cluster_array_t (7  downto 0);
    signal cluster_count : std_logic_vector     (7  downto 0);
    signal trigger_units : trigger_unit_array_t (23 downto 0);

    --== Global signals ==--

    signal mmcm_locked          : std_logic;

    signal clock                : std_logic;
    signal gbt_eclk             : std_logic;

    signal clk_1x               : std_logic;
    signal clk_2x               : std_logic;
    signal clk_4x               : std_logic;
    signal clk_4x_90            : std_logic;

    signal mgt_refclk           : std_logic;
    signal reset                : std_logic;

begin

    reset       <= '0';
    gbt_txvalid <= '1';
    ext_reset   <= (others => reset);
    sbit_mask   <= (others => '0');
    clock       <= clk_1x;

    --==============--
    --== Clocking ==--
    --==============--

    clocking_inst : entity work.clocking
    port map(
        gbt_eclk_p      => gbt_eclk_p,
        gbt_eclk_n      => gbt_eclk_n,

        gbt_dclk_p      => gbt_dclk_p,
        gbt_dclk_n      => gbt_dclk_n,

        gbt_eclk_o      => gbt_eclk,

        mmcm_locked_o   => mmcm_locked,

        clk_1x_o        => clk_1x,
        clk_2x_o        => clk_2x,
        clk_4x_o        => clk_4x,
        clk_4x_90_o     => clk_4x_90
    );

    --=================================--
    --== Fixed latency trigger links ==--
    --=================================--

    trigger_links_inst : entity work.trigger_links
    port map (
        mgt_clk_p => mgt_clk_p_i, -- 160 MHz Reference Clock
        mgt_clk_n => mgt_clk_n_i, -- 160 MHz Reference Clock

        clk_40     => clk_1x, -- 40 MHz  Logic Clock
        clk_80     => clk_2x, -- 80 MHz  User Clock 2
        clk_160    => clk_4x, -- 160 MHz User CLock

        reset      => reset,

        trg_tx_p   => mgt_tx_p_o (3 downto 0),
        trg_tx_n   => mgt_tx_n_o (3 downto 0),

        cluster0   => sbit_clusters(0),
        cluster1   => sbit_clusters(1),
        cluster2   => sbit_clusters(2),
        cluster3   => sbit_clusters(3),
        cluster4   => sbit_clusters(4),
        cluster5   => sbit_clusters(5),
        cluster6   => sbit_clusters(6),
        cluster7   => sbit_clusters(7),

        overflow   => sbit_overflow
    );

    --=========================--
    --== SBit cluster packer ==--
    --=========================--

    trigger_units_inst : entity work.trigger_units
    port map (
        vfat0_sbits_p_i  => vfat0_sbits_p_i,
        vfat0_sbits_n_i  => vfat0_sbits_n_i,
        vfat1_sbits_p_i  => vfat1_sbits_p_i,
        vfat1_sbits_n_i  => vfat1_sbits_n_i,
        vfat2_sbits_p_i  => vfat2_sbits_p_i,
        vfat2_sbits_n_i  => vfat2_sbits_n_i,
        vfat3_sbits_p_i  => vfat3_sbits_p_i,
        vfat3_sbits_n_i  => vfat3_sbits_n_i,
        vfat4_sbits_p_i  => vfat4_sbits_p_i,
        vfat4_sbits_n_i  => vfat4_sbits_n_i,
        vfat5_sbits_p_i  => vfat5_sbits_p_i,
        vfat5_sbits_n_i  => vfat5_sbits_n_i,
        vfat6_sbits_p_i  => vfat6_sbits_p_i,
        vfat6_sbits_n_i  => vfat6_sbits_n_i,
        vfat7_sbits_p_i  => vfat7_sbits_p_i,
        vfat7_sbits_n_i  => vfat7_sbits_n_i,
        vfat8_sbits_p_i  => vfat8_sbits_p_i,
        vfat8_sbits_n_i  => vfat8_sbits_n_i,
        vfat9_sbits_p_i  => vfat9_sbits_p_i,
        vfat9_sbits_n_i  => vfat9_sbits_n_i,
        vfat10_sbits_p_i => vfat10_sbits_p_i,
        vfat10_sbits_n_i => vfat10_sbits_n_i,
        vfat11_sbits_p_i => vfat11_sbits_p_i,
        vfat11_sbits_n_i => vfat11_sbits_n_i,
        vfat12_sbits_p_i => vfat12_sbits_p_i,
        vfat12_sbits_n_i => vfat12_sbits_n_i,
        vfat13_sbits_p_i => vfat13_sbits_p_i,
        vfat13_sbits_n_i => vfat13_sbits_n_i,
        vfat14_sbits_p_i => vfat14_sbits_p_i,
        vfat14_sbits_n_i => vfat14_sbits_n_i,
        vfat15_sbits_p_i => vfat15_sbits_p_i,
        vfat15_sbits_n_i => vfat15_sbits_n_i,
        vfat16_sbits_p_i => vfat16_sbits_p_i,
        vfat16_sbits_n_i => vfat16_sbits_n_i,
        vfat17_sbits_p_i => vfat17_sbits_p_i,
        vfat17_sbits_n_i => vfat17_sbits_n_i,
        vfat18_sbits_p_i => vfat18_sbits_p_i,
        vfat18_sbits_n_i => vfat18_sbits_n_i,
        vfat19_sbits_p_i => vfat19_sbits_p_i,
        vfat19_sbits_n_i => vfat19_sbits_n_i,
        vfat20_sbits_p_i => vfat20_sbits_p_i,
        vfat20_sbits_n_i => vfat20_sbits_n_i,
        vfat21_sbits_p_i => vfat21_sbits_p_i,
        vfat21_sbits_n_i => vfat21_sbits_n_i,
        vfat22_sbits_p_i => vfat22_sbits_p_i,
        vfat22_sbits_n_i => vfat22_sbits_n_i,
        vfat23_sbits_p_i => vfat23_sbits_p_i,
        vfat23_sbits_n_i => vfat23_sbits_n_i,

        vfat0_SoT_p_i   => vfat0_SoT_p_i ,
        vfat0_SoT_n_i   => vfat0_SoT_n_i ,
        vfat1_SoT_p_i   => vfat1_SoT_p_i ,
        vfat1_SoT_n_i   => vfat1_SoT_n_i ,
        vfat2_SoT_p_i   => vfat2_SoT_p_i ,
        vfat2_SoT_n_i   => vfat2_SoT_n_i ,
        vfat3_SoT_p_i   => vfat3_SoT_p_i ,
        vfat3_SoT_n_i   => vfat3_SoT_n_i ,
        vfat4_SoT_p_i   => vfat4_SoT_p_i ,
        vfat4_SoT_n_i   => vfat4_SoT_n_i ,
        vfat5_SoT_p_i   => vfat5_SoT_p_i ,
        vfat5_SoT_n_i   => vfat5_SoT_n_i ,
        vfat6_SoT_p_i   => vfat6_SoT_p_i ,
        vfat6_SoT_n_i   => vfat6_SoT_n_i ,
        vfat7_SoT_p_i   => vfat7_SoT_p_i ,
        vfat7_SoT_n_i   => vfat7_SoT_n_i ,
        vfat8_SoT_p_i   => vfat8_SoT_p_i ,
        vfat8_SoT_n_i   => vfat8_SoT_n_i ,
        vfat9_SoT_p_i   => vfat9_SoT_p_i ,
        vfat9_SoT_n_i   => vfat9_SoT_n_i ,
        vfat10_SoT_p_i  => vfat10_SoT_p_i,
        vfat10_SoT_n_i  => vfat10_SoT_n_i,
        vfat11_SoT_p_i  => vfat11_SoT_p_i,
        vfat11_SoT_n_i  => vfat11_SoT_n_i,
        vfat12_SoT_p_i  => vfat12_SoT_p_i,
        vfat12_SoT_n_i  => vfat12_SoT_n_i,
        vfat13_SoT_p_i  => vfat13_SoT_p_i,
        vfat13_SoT_n_i  => vfat13_SoT_n_i,
        vfat14_SoT_p_i  => vfat14_SoT_p_i,
        vfat14_SoT_n_i  => vfat14_SoT_n_i,
        vfat15_SoT_p_i  => vfat15_SoT_p_i,
        vfat15_SoT_n_i  => vfat15_SoT_n_i,
        vfat16_SoT_p_i  => vfat16_SoT_p_i,
        vfat16_SoT_n_i  => vfat16_SoT_n_i,
        vfat17_SoT_p_i  => vfat17_SoT_p_i,
        vfat17_SoT_n_i  => vfat17_SoT_n_i,
        vfat18_SoT_p_i  => vfat18_SoT_p_i,
        vfat18_SoT_n_i  => vfat18_SoT_n_i,
        vfat19_SoT_p_i  => vfat19_SoT_p_i,
        vfat19_SoT_n_i  => vfat19_SoT_n_i,
        vfat20_SoT_p_i  => vfat20_SoT_p_i,
        vfat20_SoT_n_i  => vfat20_SoT_n_i,
        vfat21_SoT_p_i  => vfat21_SoT_p_i,
        vfat21_SoT_n_i  => vfat21_SoT_n_i,
        vfat22_SoT_p_i  => vfat22_SoT_p_i,
        vfat22_SoT_n_i  => vfat22_SoT_n_i,
        vfat23_SoT_p_i  => vfat23_SoT_p_i,
        vfat23_SoT_n_i  => vfat23_SoT_n_i,

        trigger_units_o => trigger_units
    );

    sbits_inst : entity work.sbits
    port map(

        clk40_i                 => clk_1x,
        clk160_i                => clk_4x,
        clk160_90_i             => clk_4x_90,

        reset_i                 => reset,
        oneshot_en_i            => ('1'),

        trigger_unit_i          => trigger_units,

        sbit_mask_i             => (sbit_mask),

        vfat_sbit_clusters_o    => sbit_clusters,
        cluster_count_o         => cluster_count,
        overflow_o              => sbit_overflow
    );

    led_control : entity work.led_control
    port map (
        -- clocks
        clock         => clock,
        gbt_eclk      => gbt_eclk,

        -- signals
        mmcm_locked   => mmcm_locked,
        gbt_rxready   => gbt_rxready ,
        gbt_rxvalid   => gbt_rxvalid,
        cluster_count => cluster_count,

        -- led outputs
        led_out       => led_o
    );

end Behavioral;
