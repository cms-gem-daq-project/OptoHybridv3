----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
--
-- Create Date:    11:22:49 06/30/2015
-- Design Name:    OptoHybrid v2
-- Module Name:    vfat2_t1_selector - Behavioral
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description:
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.types_pkg.all;

entity trigger is
port(

    -- links
    mgt_clk_p : in std_logic; -- 160 MHz Reference Clock
    mgt_clk_n : in std_logic; -- 160 MHz Reference Clock

    clk_40 : in std_logic;
    clk_80 : in std_logic;
    clk_160 : in std_logic;
    clk_160_90 : in std_logic;

    reset : in std_logic;

    mgt_tx_p : out std_logic_vector(3 downto 0);
    mgt_tx_n : out std_logic_vector(3 downto 0);

    -- cluster packer

    oneshot_en_i            : in std_logic;
    vfat_sbit_clusters_o    : out sbit_cluster_array_t(7 downto 0);
    sbit_mask_i             : in std_logic_vector (23 downto 0);
    cluster_count_o         : out std_logic_vector (7 downto 0);
    overflow_o              : out std_logic;

    -- sbits
    vfat0_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat0_sbits_n_i       : in std_logic_vector(7 downto 0);

    vfat1_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat1_sbits_n_i       : in std_logic_vector(7 downto 0);

    vfat2_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat2_sbits_n_i       : in std_logic_vector(7 downto 0);

    vfat3_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat3_sbits_n_i       : in std_logic_vector(7 downto 0);

    vfat4_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat4_sbits_n_i       : in std_logic_vector(7 downto 0);

    vfat5_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat5_sbits_n_i       : in std_logic_vector(7 downto 0);

    vfat6_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat6_sbits_n_i       : in std_logic_vector(7 downto 0);

    vfat7_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat7_sbits_n_i       : in std_logic_vector(7 downto 0);

    vfat8_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat8_sbits_n_i       : in std_logic_vector(7 downto 0);

    vfat9_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat9_sbits_n_i       : in std_logic_vector(7 downto 0);

    vfat10_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat10_sbits_n_i      : in std_logic_vector(7 downto 0);

    vfat11_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat11_sbits_n_i      : in std_logic_vector(7 downto 0);

    vfat12_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat12_sbits_n_i      : in std_logic_vector(7 downto 0);

    vfat13_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat13_sbits_n_i      : in std_logic_vector(7 downto 0);

    vfat14_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat14_sbits_n_i      : in std_logic_vector(7 downto 0);

    vfat15_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat15_sbits_n_i      : in std_logic_vector(7 downto 0);

    vfat16_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat16_sbits_n_i      : in std_logic_vector(7 downto 0);

    vfat17_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat17_sbits_n_i      : in std_logic_vector(7 downto 0);

    vfat18_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat18_sbits_n_i      : in std_logic_vector(7 downto 0);

    vfat19_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat19_sbits_n_i      : in std_logic_vector(7 downto 0);

    vfat20_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat20_sbits_n_i      : in std_logic_vector(7 downto 0);

    vfat21_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat21_sbits_n_i      : in std_logic_vector(7 downto 0);

    vfat22_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat22_sbits_n_i      : in std_logic_vector(7 downto 0);

    vfat23_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat23_sbits_n_i      : in std_logic_vector(7 downto 0);

    vfat0_sof_p_i  : in std_logic;
    vfat0_sof_n_i  : in std_logic;
    vfat1_sof_p_i  : in std_logic;
    vfat1_sof_n_i  : in std_logic;
    vfat2_sof_p_i  : in std_logic;
    vfat2_sof_n_i  : in std_logic;
    vfat3_sof_p_i  : in std_logic;
    vfat3_sof_n_i  : in std_logic;
    vfat4_sof_p_i  : in std_logic;
    vfat4_sof_n_i  : in std_logic;
    vfat5_sof_p_i  : in std_logic;
    vfat5_sof_n_i  : in std_logic;
    vfat6_sof_p_i  : in std_logic;
    vfat6_sof_n_i  : in std_logic;
    vfat7_sof_p_i  : in std_logic;
    vfat7_sof_n_i  : in std_logic;
    vfat8_sof_p_i  : in std_logic;
    vfat8_sof_n_i  : in std_logic;
    vfat9_sof_p_i  : in std_logic;
    vfat9_sof_n_i  : in std_logic;
    vfat10_sof_p_i : in std_logic;
    vfat10_sof_n_i : in std_logic;
    vfat11_sof_p_i : in std_logic;
    vfat11_sof_n_i : in std_logic;
    vfat12_sof_p_i : in std_logic;
    vfat12_sof_n_i : in std_logic;
    vfat13_sof_p_i : in std_logic;
    vfat13_sof_n_i : in std_logic;
    vfat14_sof_p_i : in std_logic;
    vfat14_sof_n_i : in std_logic;
    vfat15_sof_p_i : in std_logic;
    vfat15_sof_n_i : in std_logic;
    vfat16_sof_p_i : in std_logic;
    vfat16_sof_n_i : in std_logic;
    vfat17_sof_p_i : in std_logic;
    vfat17_sof_n_i : in std_logic;
    vfat18_sof_p_i : in std_logic;
    vfat18_sof_n_i : in std_logic;
    vfat19_sof_p_i : in std_logic;
    vfat19_sof_n_i : in std_logic;
    vfat20_sof_p_i : in std_logic;
    vfat20_sof_n_i : in std_logic;
    vfat21_sof_p_i : in std_logic;
    vfat21_sof_n_i : in std_logic;
    vfat22_sof_p_i : in std_logic;
    vfat22_sof_n_i : in std_logic;
    vfat23_sof_p_i : in std_logic;
    vfat23_sof_n_i : in std_logic

);
end trigger;

architecture Behavioral of trigger is

    signal trigger_units : trigger_unit_array_t (23 downto 0);

    signal cluster0 : std_logic_vector (13 downto 0);
    signal cluster1 : std_logic_vector (13 downto 0);
    signal cluster2 : std_logic_vector (13 downto 0);
    signal cluster3 : std_logic_vector (13 downto 0);
    signal cluster4 : std_logic_vector (13 downto 0);
    signal cluster5 : std_logic_vector (13 downto 0);
    signal cluster6 : std_logic_vector (13 downto 0);
    signal cluster7 : std_logic_vector (13 downto 0);

    signal sbit_overflow : std_logic;
    signal sbit_clusters : sbit_cluster_array_t (7  downto 0);

begin

    overflow_o <= sbit_overflow;

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

        vfat0_sof_p_i   => vfat0_sof_p_i,
        vfat0_sof_n_i   => vfat0_sof_n_i,
        vfat1_sof_p_i   => vfat1_sof_p_i,
        vfat1_sof_n_i   => vfat1_sof_n_i,
        vfat2_sof_p_i   => vfat2_sof_p_i,
        vfat2_sof_n_i   => vfat2_sof_n_i,
        vfat3_sof_p_i   => vfat3_sof_p_i,
        vfat3_sof_n_i   => vfat3_sof_n_i,
        vfat4_sof_p_i   => vfat4_sof_p_i,
        vfat4_sof_n_i   => vfat4_sof_n_i,
        vfat5_sof_p_i   => vfat5_sof_p_i,
        vfat5_sof_n_i   => vfat5_sof_n_i,
        vfat6_sof_p_i   => vfat6_sof_p_i,
        vfat6_sof_n_i   => vfat6_sof_n_i,
        vfat7_sof_p_i   => vfat7_sof_p_i,
        vfat7_sof_n_i   => vfat7_sof_n_i,
        vfat8_sof_p_i   => vfat8_sof_p_i,
        vfat8_sof_n_i   => vfat8_sof_n_i,
        vfat9_sof_p_i   => vfat9_sof_p_i,
        vfat9_sof_n_i   => vfat9_sof_n_i,
        vfat10_sof_p_i  => vfat10_sof_p_i,
        vfat10_sof_n_i  => vfat10_sof_n_i,
        vfat11_sof_p_i  => vfat11_sof_p_i,
        vfat11_sof_n_i  => vfat11_sof_n_i,
        vfat12_sof_p_i  => vfat12_sof_p_i,
        vfat12_sof_n_i  => vfat12_sof_n_i,
        vfat13_sof_p_i  => vfat13_sof_p_i,
        vfat13_sof_n_i  => vfat13_sof_n_i,
        vfat14_sof_p_i  => vfat14_sof_p_i,
        vfat14_sof_n_i  => vfat14_sof_n_i,
        vfat15_sof_p_i  => vfat15_sof_p_i,
        vfat15_sof_n_i  => vfat15_sof_n_i,
        vfat16_sof_p_i  => vfat16_sof_p_i,
        vfat16_sof_n_i  => vfat16_sof_n_i,
        vfat17_sof_p_i  => vfat17_sof_p_i,
        vfat17_sof_n_i  => vfat17_sof_n_i,
        vfat18_sof_p_i  => vfat18_sof_p_i,
        vfat18_sof_n_i  => vfat18_sof_n_i,
        vfat19_sof_p_i  => vfat19_sof_p_i,
        vfat19_sof_n_i  => vfat19_sof_n_i,
        vfat20_sof_p_i  => vfat20_sof_p_i,
        vfat20_sof_n_i  => vfat20_sof_n_i,
        vfat21_sof_p_i  => vfat21_sof_p_i,
        vfat21_sof_n_i  => vfat21_sof_n_i,
        vfat22_sof_p_i  => vfat22_sof_p_i,
        vfat22_sof_n_i  => vfat22_sof_n_i,
        vfat23_sof_p_i  => vfat23_sof_p_i,
        vfat23_sof_n_i  => vfat23_sof_n_i,

        trigger_units_o => trigger_units
    );

    sbits_inst : entity work.sbits
    port map(

        clk40_i                 => clk_40,
        clk160_i                => clk_160,
        clk160_90_i             => clk_160_90,

        reset_i                 => reset,
        oneshot_en_i            => ('1'),

        trigger_unit_i          => trigger_units,

        sbit_mask_i             => (sbit_mask_i),

        vfat_sbit_clusters_o    => sbit_clusters,
        cluster_count_o         => cluster_count_o,
        overflow_o              => sbit_overflow

    );

    --=================================--
    --== Fixed latency trigger links ==--
    --=================================--

    trigger_links_inst : entity work.trigger_links
    port map (

        mgt_clk_p => mgt_clk_p, -- 160 MHz Reference Clock Positive
        mgt_clk_n => mgt_clk_n, -- 160 MHz Reference Clock Negative

        clk_40     => clk_40, -- 40 MHz  Logic Clock
        clk_80     => clk_80, -- 80 MHz  User Clock 2
        clk_160    => clk_160, -- 160 MHz User Clock

        reset      => reset,

        trg_tx_p   => mgt_tx_p (3 downto 0),
        trg_tx_n   => mgt_tx_n (3 downto 0),

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


end Behavioral;
