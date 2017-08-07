----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Evaldas Juska
--
-- Create Date:    13:13:21 05/13/2016
-- Design Name:    OptoHybrid v2
-- Module Name:    sbits - Behavioral
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description:
--
-- Sbits handling
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;

library work;
use work.types_pkg.all;

entity sbits is
port(

    clk160_i                : in std_logic;
    clk160_90_i             : in std_logic;
    clk40_i                 : in std_logic;
    delay_refclk_i          : in std_logic;

    reset_i                 : in std_logic;

    oneshot_en_i            : in std_logic;

    vfat_sbit_clusters_o    : out sbit_cluster_array_t(7 downto 0);

    sbit_mask_i             : in std_logic_vector (23 downto 0);

    cluster_count_o         : out std_logic_vector (7 downto 0);

    trigger_unit_i          : in trigger_unit_array_t (23 downto 0);

    active_vfats_o          : out std_logic_vector (23 downto 0);

    overflow_o              : out std_logic

);
end sbits;

architecture Behavioral of sbits is

    signal vfat_sbits               : sbits_array_t(23 downto 0);

    signal sbits_p                  : std_logic_vector (191 downto 0);
    signal sbits_n                  : std_logic_vector (191 downto 0);

    signal start_of_frame_p         : std_logic_vector (23 downto 0);
    signal start_of_frame_n         : std_logic_vector (23 downto 0);

    signal clk160_180               : std_logic;

    signal sbits                    : std_logic_vector (1535 downto 0);

    signal active_vfats_s1          : std_logic_vector (191 downto 0);

begin

    -- don't need to do a 180 on the clock-- use local inverters for deserialization to save 1 global clock
    clk160_180 <= not clk160_i;

    sbits_p <=  trigger_unit_i(23).trig_data_p
              & trigger_unit_i(22).trig_data_p
              & trigger_unit_i(21).trig_data_p
              & trigger_unit_i(20).trig_data_p
              & trigger_unit_i(19).trig_data_p
              & trigger_unit_i(18).trig_data_p
              & trigger_unit_i(17).trig_data_p
              & trigger_unit_i(16).trig_data_p
              & trigger_unit_i(15).trig_data_p
              & trigger_unit_i(14).trig_data_p
              & trigger_unit_i(13).trig_data_p
              & trigger_unit_i(12).trig_data_p
              & trigger_unit_i(11).trig_data_p
              & trigger_unit_i(10).trig_data_p
              &  trigger_unit_i(9).trig_data_p
              &  trigger_unit_i(8).trig_data_p
              &  trigger_unit_i(7).trig_data_p
              &  trigger_unit_i(6).trig_data_p
              &  trigger_unit_i(5).trig_data_p
              &  trigger_unit_i(4).trig_data_p
              &  trigger_unit_i(3).trig_data_p
              &  trigger_unit_i(2).trig_data_p
              &  trigger_unit_i(1).trig_data_p
              &  trigger_unit_i(0).trig_data_p;

    sbits_n <=  trigger_unit_i(23).trig_data_n
              & trigger_unit_i(22).trig_data_n
              & trigger_unit_i(21).trig_data_n
              & trigger_unit_i(20).trig_data_n
              & trigger_unit_i(19).trig_data_n
              & trigger_unit_i(18).trig_data_n
              & trigger_unit_i(17).trig_data_n
              & trigger_unit_i(16).trig_data_n
              & trigger_unit_i(15).trig_data_n
              & trigger_unit_i(14).trig_data_n
              & trigger_unit_i(13).trig_data_n
              & trigger_unit_i(12).trig_data_n
              & trigger_unit_i(11).trig_data_n
              & trigger_unit_i(10).trig_data_n
              &  trigger_unit_i(9).trig_data_n
              &  trigger_unit_i(8).trig_data_n
              &  trigger_unit_i(7).trig_data_n
              &  trigger_unit_i(6).trig_data_n
              &  trigger_unit_i(5).trig_data_n
              &  trigger_unit_i(4).trig_data_n
              &  trigger_unit_i(3).trig_data_n
              &  trigger_unit_i(2).trig_data_n
              &  trigger_unit_i(1).trig_data_n
              &  trigger_unit_i(0).trig_data_n;

    start_of_frame_p <=  trigger_unit_i(23).start_of_frame_p
                       & trigger_unit_i(22).start_of_frame_p
                       & trigger_unit_i(21).start_of_frame_p
                       & trigger_unit_i(20).start_of_frame_p
                       & trigger_unit_i(19).start_of_frame_p
                       & trigger_unit_i(18).start_of_frame_p
                       & trigger_unit_i(17).start_of_frame_p
                       & trigger_unit_i(16).start_of_frame_p
                       & trigger_unit_i(15).start_of_frame_p
                       & trigger_unit_i(14).start_of_frame_p
                       & trigger_unit_i(13).start_of_frame_p
                       & trigger_unit_i(12).start_of_frame_p
                       & trigger_unit_i(11).start_of_frame_p
                       & trigger_unit_i(10).start_of_frame_p
                       & trigger_unit_i(9).start_of_frame_p
                       & trigger_unit_i(8).start_of_frame_p
                       & trigger_unit_i(7).start_of_frame_p
                       & trigger_unit_i(6).start_of_frame_p
                       & trigger_unit_i(5).start_of_frame_p
                       & trigger_unit_i(4).start_of_frame_p
                       & trigger_unit_i(3).start_of_frame_p
                       & trigger_unit_i(2).start_of_frame_p
                       & trigger_unit_i(1).start_of_frame_p
                       & trigger_unit_i(0).start_of_frame_p;

    start_of_frame_n <=  trigger_unit_i(23).start_of_frame_n
                       & trigger_unit_i(22).start_of_frame_n
                       & trigger_unit_i(21).start_of_frame_n
                       & trigger_unit_i(20).start_of_frame_n
                       & trigger_unit_i(19).start_of_frame_n
                       & trigger_unit_i(18).start_of_frame_n
                       & trigger_unit_i(17).start_of_frame_n
                       & trigger_unit_i(16).start_of_frame_n
                       & trigger_unit_i(15).start_of_frame_n
                       & trigger_unit_i(14).start_of_frame_n
                       & trigger_unit_i(13).start_of_frame_n
                       & trigger_unit_i(12).start_of_frame_n
                       & trigger_unit_i(11).start_of_frame_n
                       & trigger_unit_i(10).start_of_frame_n
                       & trigger_unit_i(9).start_of_frame_n
                       & trigger_unit_i(8).start_of_frame_n
                       & trigger_unit_i(7).start_of_frame_n
                       & trigger_unit_i(6).start_of_frame_n
                       & trigger_unit_i(5).start_of_frame_n
                       & trigger_unit_i(4).start_of_frame_n
                       & trigger_unit_i(3).start_of_frame_n
                       & trigger_unit_i(2).start_of_frame_n
                       & trigger_unit_i(1).start_of_frame_n
                       & trigger_unit_i(0).start_of_frame_n;


    trig_alignment : entity work.trig_alignment
    port map (

        sbit_mask  => sbit_mask_i,

        reset => reset_i,

        sbits_p => sbits_p,
        sbits_n => sbits_n,

        start_of_frame_p => start_of_frame_p,
        start_of_frame_n => start_of_frame_n,


        fastclk_0    => clk160_i,
        fastclk_90   => clk160_90_i,
        fastclk_180  => clk160_180,
        clock        => clk40_i,
        delay_refclk => delay_refclk_i,

        phase_err => open,
        sbits => sbits
    );

    -- combinatorial renaming for input to module

    vfat_sbits (0)  <= sbits (63   downto 0);
    vfat_sbits (1)  <= sbits (127  downto 64);
    vfat_sbits (2)  <= sbits (191  downto 128);
    vfat_sbits (3)  <= sbits (255  downto 192);
    vfat_sbits (4)  <= sbits (319  downto 256);
    vfat_sbits (5)  <= sbits (383  downto 320);
    vfat_sbits (6)  <= sbits (447  downto 384);
    vfat_sbits (7)  <= sbits (511  downto 448);
    vfat_sbits (8)  <= sbits (575  downto 512);
    vfat_sbits (9)  <= sbits (639  downto 576);
    vfat_sbits (10) <= sbits (703  downto 640);
    vfat_sbits (11) <= sbits (767  downto 704);
    vfat_sbits (12) <= sbits (831  downto 768);
    vfat_sbits (13) <= sbits (895  downto 832);
    vfat_sbits (14) <= sbits (959  downto 896);
    vfat_sbits (15) <= sbits (1023 downto 960);
    vfat_sbits (16) <= sbits (1087 downto 1024);
    vfat_sbits (17) <= sbits (1151 downto 1088);
    vfat_sbits (18) <= sbits (1215 downto 1152);
    vfat_sbits (19) <= sbits (1279 downto 1216);
    vfat_sbits (20) <= sbits (1343 downto 1280);
    vfat_sbits (21) <= sbits (1407 downto 1344);
    vfat_sbits (22) <= sbits (1471 downto 1408);
    vfat_sbits (23) <= sbits (1535 downto 1472);

    -- I don't want to do 64 bit reduction in 1 clock... split it over 2 to add slack to PAR and timing

    active_vfat_s1 : for I in 0 to (191) generate
    begin
    process (clk40_i)
    begin
        if (rising_edge(clk40_i)) then
            active_vfats_s1 (I)   <= or_reduce (sbits (8*(I+1)-1 downto (8*I)));
        end if;
    end process;
    end generate;

    active_vfat_s2 : for I in 0 to (23) generate
    begin
    process (clk40_i)
    begin
        if (rising_edge(clk40_i)) then
            active_vfats_o (I)   <= or_reduce (active_vfats_s1 (8*(I+1)-1 downto (8*I)));
        end if;
    end process;
    end generate;

    cluster_packer_inst : entity work.cluster_packer
    port map(
        clock4x             => clk160_i,
        clock1x             => clk40_i,
        global_reset        => reset_i,
        cluster_count_o     => cluster_count_o,
        truncate_clusters   => '0',
        oneshot_en          => oneshot_en_i,
        vfat0               => vfat_sbits(0),
        vfat1               => vfat_sbits(1),
        vfat2               => vfat_sbits(2),
        vfat3               => vfat_sbits(3),
        vfat4               => vfat_sbits(4),
        vfat5               => vfat_sbits(5),
        vfat6               => vfat_sbits(6),
        vfat7               => vfat_sbits(7),
        vfat8               => vfat_sbits(8),
        vfat9               => vfat_sbits(9),
        vfat10              => vfat_sbits(10),
        vfat11              => vfat_sbits(11),
        vfat12              => vfat_sbits(12),
        vfat13              => vfat_sbits(13),
        vfat14              => vfat_sbits(14),
        vfat15              => vfat_sbits(15),
        vfat16              => vfat_sbits(16),
        vfat17              => vfat_sbits(17),
        vfat18              => vfat_sbits(18),
        vfat19              => vfat_sbits(19),
        vfat20              => vfat_sbits(20),
        vfat21              => vfat_sbits(21),
        vfat22              => vfat_sbits(22),
        vfat23              => vfat_sbits(23),
        cluster0            => vfat_sbit_clusters_o(0),
        cluster1            => vfat_sbit_clusters_o(1),
        cluster2            => vfat_sbit_clusters_o(2),
        cluster3            => vfat_sbit_clusters_o(3),
        cluster4            => vfat_sbit_clusters_o(4),
        cluster5            => vfat_sbit_clusters_o(5),
        cluster6            => vfat_sbit_clusters_o(6),
        cluster7            => vfat_sbit_clusters_o(7),
        overflow            => overflow_o
    );

end Behavioral;
