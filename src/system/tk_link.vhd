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

    --== Tracking data signals ==--

    signal tk_valid         : std_logic_vector(7 downto 0);
    signal tk_data          : tk_data_array_t(7 downto 0);

    --== T1 signals ==--

    signal t1_array         : t1_array_t; -- 0 : AMC13 triggers
                                          -- 1 : software triggers
                                          -- 2 : latency scan
                                          -- 3 : threshold scan
    signal t1_switched      : t1_t;
    signal t1_src_select    : std_logic_vector(3 downto 0);
    
begin

    --== Clocking ==--
    
    vfat2_mclk_o <= ref_clk_i;
    
    --== Reset ==--
    
    vfat2_reset_o <= reset_i;
    
    --== Tracking decoders ==--
    
    vfat2_data_decoder_loop : for I in 0 to 7 generate
    begin
    
        vfat2_data_decoder_seu_inst : entity work.vfat2_data_decoder_seu
        port map(
            ref_clk_i   => ref_clk_i,
            reset_i     => reset_i,
            data_i      => vfat2_data_out_i(I),
            valid_o     => tk_valid(I),
            data_o      => tk_data(I)
        );    
        
    end generate;
    
    --== T1 switches ==--
    
    t1_switch_inst : entity work.t1_switch
    generic map(
        ASYNC       => false,
        WIDTH       => 4
    )
    port map(
        ref_clk_i   => ref_clk_i,
        reset_i     => reset_i,
        t1_i        => t1_amc13,
        mask_i      => t1_src_select,
        t1_o        => t1_switched
    );    
    
    --== T1 encoders ==--
    
    vfat2_t1_encoder_seu_inst : entity work.vfat2_t1_encoder_seu
    port map(
        ref_clk_i   => ref_clk_i,
        reset_i     => reset_i,
        t1_i        => t1_switched,
        t1_o        => vfat2_t1_o
    );
    
    --== Event builder ==--
   
    event_builder_inst : entity work.event_builder
    port map(
        ref_clk_i   => ref_clk_i,
        reset_i     => reset_i,
        tk_valid_i  => tk_valid,
        tk_data_i   => tk_data
    );    
    
    --== Latency scan ==--
    
    latency_scan_inst : entity work.latency_scan
    port map(
        ref_clk_i   => ref_clk_i,
        reset_i     => reset_i,
        t1_o        => t1_array(2),
        tk_valid_i  => tk_valid,
        tk_data_i   => tk_data
    );    
    
    --== Threshold scan ==--
    
    threshold_scan_inst : entity work.threshold_scan
    port map(
        ref_clk_i   => ref_clk_i,
        reset_i     => reset_i,
        t1_o        => t1_array(3),
        tk_valid_i  => tk_valid,
        tk_data_i   => tk_data
    );   

end Behavioral;