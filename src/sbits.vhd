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

library work;
use work.types_pkg.all;

entity sbits is
port(

    clk160_i                : in std_logic;
    clk40_i                 : in std_logic;

    gtx_clk_i               : in std_logic;
   
    reset_i                 : in std_logic;

    oneshot_en_i            : in std_logic;

    vfat2_sbits_i           : in sbits_array_t(23 downto 0);
    vfat2_sbit_mask_i       : in std_logic_vector(23 downto 0);
   
    vfat_sbit_clusters_o    : out sbit_cluster_array_t(7 downto 0);

    overflow_o              : out std_logic

);
end sbits;

architecture Behavioral of sbits is        
    
    signal vfat2_sbits_masked   : sbits_array_t(23 downto 0); 
    
begin

    -- Apply SBit mask
    vfat2_sbit_mask_gen : for I in 0 to 23 generate
    begin
        vfat2_sbits_masked(I) <= vfat2_sbits_i(I) when vfat2_sbit_mask_i(I) = '0' else (others => '0');
    end generate;

    cluster_packer_inst : entity work.cluster_packer_vfat2
    port map(
        clock4x             => clk160_i,
        clock1x             => clk40_i,
        global_reset        => reset_i,
        truncate_clusters   => '0',
        oneshot_en          => oneshot_en_i,
        vfat0               => vfat2_sbits_masked(0),
        vfat1               => vfat2_sbits_masked(1),
        vfat2               => vfat2_sbits_masked(2),
        vfat3               => vfat2_sbits_masked(3),
        vfat4               => vfat2_sbits_masked(4),
        vfat5               => vfat2_sbits_masked(5),
        vfat6               => vfat2_sbits_masked(6),
        vfat7               => vfat2_sbits_masked(7),
        vfat8               => vfat2_sbits_masked(8),
        vfat9               => vfat2_sbits_masked(9),
        vfat10              => vfat2_sbits_masked(10),
        vfat11              => vfat2_sbits_masked(11),
        vfat12              => vfat2_sbits_masked(12),
        vfat13              => vfat2_sbits_masked(13),
        vfat14              => vfat2_sbits_masked(14),
        vfat15              => vfat2_sbits_masked(15),
        vfat16              => vfat2_sbits_masked(16),
        vfat17              => vfat2_sbits_masked(17),
        vfat18              => vfat2_sbits_masked(18),
        vfat19              => vfat2_sbits_masked(19),
        vfat20              => vfat2_sbits_masked(20),
        vfat21              => vfat2_sbits_masked(21),
        vfat22              => vfat2_sbits_masked(22),
        vfat23              => vfat2_sbits_masked(23),
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
    
--    gen_con : for i in 0 to 23 generate
--    begin
--    
--        trig0(((i + 1) * 8 - 1) downto (i * 8)) <= vfat2_sbits_i(i);
--        
--    end generate;
 
end Behavioral;
