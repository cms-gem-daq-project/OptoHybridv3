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
    
    ref_clk_i               : in std_logic;
    reset_i                 : in std_logic;
    
    vfat2_sbits_i           : in sbits_array_t(23 downto 0);    
    vfat2_sbit_mask_i       : in std_logic_vector(23 downto 0);
    
    vfat_sbit_clusters_o    : out sbit_cluster_array_t(7 downto 0)
    
);
end sbits;

architecture Behavioral of sbits is        
    
    signal vfat2_sbits_masked   : sbits_array_t(23 downto 0); 
    signal vfat3_sbits          : std64_array_t(23 downto 0);
    
begin

    -- Apply SBit mask
    vfat2_sbit_mask_gen : for I in 0 to 23 generate
    begin
    
        vfat2_sbits_masked(I) <= vfat2_sbits_i(I) when vfat2_sbit_mask_i(I) = '0' else (others => '0');
        
    end generate;

    -- Map the VFAT2 SBits (8 per VFAT) to VFAT3 like structure (64 per VFAT) that is expected by the cluster packer
    vfat2_to_vfat3_sbit_map_gen : for I in 0 to 23 generate
    begin
    
        vfat2_sbit_loop: for J in 0 to 7 generate
        begin
        
            vfat3_sbits(I)((J * 8) + 7 downto (J * 8)) <= (others => vfat2_sbits_masked(I)(J));
            
        end generate;
        
    end generate;

    cluster_packer_inst : entity work.cluster_packer 
    port map(
        clock4x             => ref_clk_i,
        global_reset        => reset_i,
        truncate_clusters   => '0',
        vfat0               => vfat3_sbits(0),
        vfat1               => vfat3_sbits(1),
        vfat2               => vfat3_sbits(2),
        vfat3               => vfat3_sbits(3),
        vfat4               => vfat3_sbits(4),
        vfat5               => vfat3_sbits(5),
        vfat6               => vfat3_sbits(6),
        vfat7               => vfat3_sbits(7),
        vfat8               => vfat3_sbits(8),
        vfat9               => vfat3_sbits(9),
        vfat10              => vfat3_sbits(10),
        vfat11              => vfat3_sbits(11),
        vfat12              => vfat3_sbits(12),
        vfat13              => vfat3_sbits(13),
        vfat14              => vfat3_sbits(14),
        vfat15              => vfat3_sbits(15),
        vfat16              => vfat3_sbits(16),
        vfat17              => vfat3_sbits(17),
        vfat18              => vfat3_sbits(18),
        vfat19              => vfat3_sbits(19),
        vfat20              => vfat3_sbits(20),
        vfat21              => vfat3_sbits(21),
        vfat22              => vfat3_sbits(22),
        vfat23              => vfat3_sbits(23),       
        cluster0            => vfat_sbit_clusters_o(0),
        cluster1            => vfat_sbit_clusters_o(1),
        cluster2            => vfat_sbit_clusters_o(2),
        cluster3            => vfat_sbit_clusters_o(3),
        cluster4            => vfat_sbit_clusters_o(4),
        cluster5            => vfat_sbit_clusters_o(5),
        cluster6            => vfat_sbit_clusters_o(6),
        cluster7            => vfat_sbit_clusters_o(7)
    );
 
end Behavioral;
