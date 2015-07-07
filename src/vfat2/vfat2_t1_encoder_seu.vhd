----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    11:22:49 06/30/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    vfat2_t1_encoder_seu - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description: 
--
-- SEU version of the T1 encoder
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library work;
use work.types_pkg.all;

entity vfat2_t1_encoder_seu is
port(

    ref_clk_i   : in std_logic;
    reset_i     : in std_logic;
    
    t1_i        : in t1_t;
    
    t1_o        : out std_logic
    
);
end vfat2_t1_encoder_seu;

architecture Behavioral of vfat2_t1_encoder_seu is

    signal t1_0, t1_1, t1_2 : std_logic;

begin
    
    --== T1 encoders ==--

    vfat2_t1_encoder_0_inst : entity work.vfat2_t1_encoder
    port map(
        ref_clk_i   => ref_clk_i,
        reset_i     => reset_i,
        t1_i        => t1_i,
        t1_o        => t1_0
    );

    vfat2_t1_encoder_1_inst : entity work.vfat2_t1_encoder
    port map(
        ref_clk_i   => ref_clk_i,
        reset_i     => reset_i,
        t1_i        => t1_i,
        t1_o        => t1_1
    );

    vfat2_t1_encoder_2_inst : entity work.vfat2_t1_encoder
    port map(
        ref_clk_i   => ref_clk_i,
        reset_i     => reset_i,
        t1_i        => t1_i,
        t1_o        => t1_2
    );  
    
    --== SEU voter ==--
    
    t1_seu_voter : entity work.seu_voter_bit
    generic map(
        ASYNC       => false, 
        WIDTH       => 1
    )
    port map(
        clk_i       => ref_clk_i, 
        reset_i     => reset_i, 
        data_0_i    => t1_0, 
        data_1_i    => t1_1, 
        data_2_i    => t1_2, 
        data_o      => t1_o
    );  
    
end Behavioral;