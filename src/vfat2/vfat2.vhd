----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    13:30:05 07/13/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    vfat2 - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description: 
--
-- Handles the VFAT2s basic functions: data readout, T1 encoding, I2C communication.
-- This module is the link between the OH high-level functions and the VFAT2s. It 
-- doesn't operate complex operations but only handles the low-level signals of the VFAT2s.
-- 
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library work;
use work.types_pkg.all;

entity vfat2 is      
port(        

    ref_clk_i           : in std_logic;
    reset_i             : in std_logic;
        
    -- VFAT2 T1 control
    vfat2_t1_i          : in t1_t;
    
    -- VFAT2 control
    vfat2_mclk_o        : out std_logic;
    vfat2_t1_o          : out std_logic;
    vfat2_reset_o       : out std_logic;
    
    -- VFAT2 raw tracking data
    vfat2_data_out_i    : in std_logic_vector(23 downto 0);
        
    -- VFAT2 formated tracking data
    vfat2_tk_data_o     : out tk_data_array_t(23 downto 0);
    
    -- Wishbone I2C slave
    wb_slv_i2c_req_i    : in wb_req_array_t(5 downto 0);
    wb_slv_i2c_res_o    : out wb_res_array_t(5 downto 0);
    
    -- VFAT2 I2C signals
    vfat2_scl_o         : out std_logic_vector(5 downto 0);
    vfat2_sda_miso_i    : in std_logic_vector(5 downto 0);
    vfat2_sda_mosi_o    : out std_logic_vector(5 downto 0);
    vfat2_sda_tri_o     : out std_logic_vector(5 downto 0)
    
);
end vfat2;

architecture Behavioral of vfat2 is
begin

    --=====================--
    --== Clock and reset ==--
    --=====================--
    
    vfat2_mclk_o <= ref_clk_i;
    vfat2_reset_o <= '1';
    
    --==================================--
    --== VFAT2 tracking data decoders ==--
    --==================================--
    
    vfat2_data_decoder_gen : for I in 0 to 23 generate
    begin
    
        vfat2_data_decoder_inst : entity work.vfat2_data_decoder
        port map(
            ref_clk_i           => ref_clk_i,
            reset_i             => reset_i,
            vfat2_data_out_i    => vfat2_data_out_i(I),
            tk_data_o           => vfat2_tk_data_o(I)
        );

    end generate;

    --================--
    --== T1 encoder ==--
    --================--
    
    vfat2_t1_encoder_inst : entity work.vfat2_t1_encoder
    port map(
        ref_clk_i   => ref_clk_i,
        reset_i     => reset_i,
        vfat2_t1_i  => vfat2_t1_i,
        vfat2_t1_o  => vfat2_t1_o
    );

    --========================--
    --== VFAT2 I2C handlers ==--
    --========================--
    
    vfat2_i2c_gen : for I in 0 to 5 generate
    begin
    
        vfat2_i2c_inst : entity work.vfat2_i2c
        port map(
            ref_clk_i           => ref_clk_i,
            reset_i             => reset_i,
            wb_slv_req_i        => wb_slv_i2c_req_i(I),
            wb_slv_res_o        => wb_slv_i2c_res_o(I),
            vfat2_scl_o         => vfat2_scl_o(I),
            vfat2_sda_miso_i    => vfat2_sda_miso_i(I),
            vfat2_sda_mosi_o    => vfat2_sda_mosi_o(I),
            vfat2_sda_tri_o     => vfat2_sda_tri_o(I)
        );

    end generate;

end Behavioral;
