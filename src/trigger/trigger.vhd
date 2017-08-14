----------------------------------------------------------------------------------
-- CMS Muon Endcap
-- GEM Collaboration
-- Optohybrid v3 Firmware -- Trigger
-- A. Peck
----------------------------------------------------------------------------------
-- Description:
--   This module holds all the required functionality for the trigger S-bit alignment
--   and cluster building
----------------------------------------------------------------------------------
-- 2017/07/24 -- Initial
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

    delay_refclk_i : in std_logic;

    cluster_clk    : in std_logic;

    reset_i : in std_logic;

    mgt_tx_p : out std_logic_vector(3 downto 0);
    mgt_tx_n : out std_logic_vector(3 downto 0);

    -- ttc

    trig_stop_i : in std_logic;
    bxn_counter_i : in std_logic_vector(11 downto 0);
    ttc_bx0_i     : in std_logic;

    -- cluster packer

    sbit_mask_i             : in  std_logic_vector (23 downto 0);
    cluster_count_o         : out std_logic_vector (7 downto 0);
    trigger_deadtime_i      : in  std_logic_vector (3 downto 0);
    overflow_o              : out std_logic;

    active_vfats_o          : out std_logic_vector (23 downto 0);

    -- sbits
    vfat_sof_p     : in std_logic_vector (23 downto 0);
    vfat_sof_n     : in std_logic_vector (23 downto 0);

    vfat_sbits_p : in std_logic_vector (191 downto 0);
    vfat_sbits_n : in std_logic_vector (191 downto 0)
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

    signal reset : std_logic;

begin

    process (clk_40) begin
        if (rising_edge(clk_40)) then
            reset <= reset_i;
        end if;
    end process;

    overflow_o <= sbit_overflow;

    trigger_units_inst : entity work.trigger_units
    port map (

        -- sbits
        vfat_sof_p   => vfat_sof_p,
        vfat_sof_n   => vfat_sof_n,

        vfat_sbits_p => vfat_sbits_p,
        vfat_sbits_n => vfat_sbits_n,

        trigger_units_o => trigger_units
    );

    sbits_inst : entity work.sbits
    port map(

        trig_stop_i             => trig_stop_i,

        cluster_clk             => cluster_clk,
        clk40_i                 => clk_40,
        clk160_i                => clk_160,
        clk160_90_i             => clk_160_90,
        delay_refclk_i          => delay_refclk_i,

        reset_i                 => reset,

        trigger_unit_i          => trigger_units,

        sbit_mask_i             => (sbit_mask_i),

        active_vfats_o          => active_vfats_o,

        vfat_sbit_clusters_o    => sbit_clusters,
        trigger_deadtime_i      => trigger_deadtime_i,
        cluster_count_o         => cluster_count_o,
        overflow_o              => sbit_overflow

    );

    --=================================--
    --== Fixed latency trigger links ==--
    --=================================--

    trigger_links_inst : entity work.trigger_links
    port map (

        mgt_clk_p  => mgt_clk_p, -- 160 MHz Reference Clock Positive
        mgt_clk_n  => mgt_clk_n, -- 160 MHz Reference Clock Negative

        clk_40     => clk_40,  -- 40 MHz  Logic Clock
        clk_80     => clk_80,  -- 80 MHz  User Clock 2
        clk_160    => clk_160, -- 160 MHz User Clock

        bxn_counter => bxn_counter_i,
        ttc_bx0     => ttc_bx0_i    ,

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
