----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    11:22:49 06/30/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    tk_link - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description: 
--
-- Handles a tracking link
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

entity tk_link is
port(

    ref_clk_i           : in std_logic;
    reset_i             : in std_logic;

    vfat2_mclk_o        : out std_logic;
    vfat2_reset_o       : out std_logic;
    vfat2_t1_o          : out std_logic;
    vfat2_scl_o         : out std_logic_vector(1 downto 0);
    vfat2_sda_o         : out std_logic_vector(1 downto 0);
    vfat2_sda_i         : in std_logic_vector(1 downto 0);
    vfat2_sda_t         : out std_logic_vector(1 downto 0);
    vfat2_data_valid_i  : in std_logic_vector(1 downto 0);
    vfat2_data_out_i    : in std_logic_vector(7 downto 0)
    
);
end tk_link;

architecture Behavioral of tk_link is

    signal tk_valid_0, tk_valid_1, tk_valid_2, tk_valid_3   : std_logic;
    signal tk_valid_4, tk_valid_5, tk_valid_6, tk_valid_7   : std_logic;

    signal tk_data_0, tk_data_1, tk_data_2, tk_data_3       : tk_data_t;
    signal tk_data_4, tk_data_5, tk_data_6, tk_data_7       : tk_data_t;

    signal t1_0, t1_1, t1_2, t1_3                           : t1_t;
    signal t1_switched                                      : t1_t;
    signal t1_src_select                                    : std_logic_vector(1 downto 0);
    
begin

    --== Clocking ==--
    
    vfat2_mclk_o <= ref_clk_i;
    
    --== Reset ==--
    
    vfat2_reset_o <= reset_i;
    
    --== Tracking decoders ==--
    
    vfat2_data_decoder_seu_0_inst : entity work.vfat2_data_decoder_seu
    port map(
        ref_clk_i   => ref_clk_i,
        reset_i     => reset_i,
        data_i      => vfat2_data_out_i(0),
        valid_o     => tk_valid_0,
        data_o      => tk_data_0
    );    
    
--    vfat2_data_decoder_seu_1_inst : entity work.vfat2_data_decoder_seu
--    port map(
--        ref_clk_i   => ref_clk_i,
--        reset_i     => reset_i,
--        data_i      => vfat2_data_out_i(1),
--        valid_o     => tk_valid_1,
--        data_o      => tk_data_1
--    );    
--    
--    vfat2_data_decoder_seu_2_inst : entity work.vfat2_data_decoder_seu
--    port map(
--        ref_clk_i   => ref_clk_i,
--        reset_i     => reset_i,
--        data_i      => vfat2_data_out_i(2),
--        valid_o     => tk_valid_2,
--        data_o      => tk_data_2
--    );    
--    
--    vfat2_data_decoder_seu_3_inst : entity work.vfat2_data_decoder_seu
--    port map(
--        ref_clk_i   => ref_clk_i,
--        reset_i     => reset_i,
--        data_i      => vfat2_data_out_i(3),
--        valid_o     => tk_valid_3,
--        data_o      => tk_data_3
--    );    
--    
--    vfat2_data_decoder_seu_4_inst : entity work.vfat2_data_decoder_seu
--    port map(
--        ref_clk_i   => ref_clk_i,
--        reset_i     => reset_i,
--        data_i      => vfat2_data_out_i(4),
--        valid_o     => tk_valid_4,
--        data_o      => tk_data_4
--    );    
--    
--    vfat2_data_decoder_seu_5_inst : entity work.vfat2_data_decoder_seu
--    port map(
--        ref_clk_i   => ref_clk_i,
--        reset_i     => reset_i,
--        data_i      => vfat2_data_out_i(5),
--        valid_o     => tk_valid_5,
--        data_o      => tk_data_5
--    );    
--    
--    vfat2_data_decoder_seu_6_inst : entity work.vfat2_data_decoder_seu
--    port map(
--        ref_clk_i   => ref_clk_i,
--        reset_i     => reset_i,
--        data_i      => vfat2_data_out_i(6),
--        valid_o     => tk_valid_6,
--        data_o      => tk_data_6
--    );    
--    
--    vfat2_data_decoder_seu_7_inst : entity work.vfat2_data_decoder_seu
--    port map(
--        ref_clk_i   => ref_clk_i,
--        reset_i     => reset_i,
--        data_i      => vfat2_data_out_i(7),
--        valid_o     => tk_valid_7,
--        data_o      => tk_data_7
--    );    
    
    --== T1 switches ==--
    
    vfat2_t1_switch_inst : entity work.vfat2_t1_switch
    generic map(
        ASYNC           => false
    )
    port map(
        ref_clk_i       => ref_clk_i,
        reset_i         => reset_i,
        t1_0_i          => t1_0, -- From AMC 13
        t1_1_i          => t1_1, -- From Software
        t1_2_i          => t1_2, -- From Firmware
        t1_3_i          => t1_3,
        src_select_i    => t1_src_select,
        t1_o            => t1_switched
    );    
    
    --== T1 encoders ==--
    
    vfat2_t1_encoder_seu_inst : entity work.vfat2_t1_encoder_seu
    port map(
        ref_clk_i   => ref_clk_i,
        reset_i     => reset_i,
        t1_i        => t1_switched,
        t1_o        => vfat2_t1_o
    );

end Behavioral;