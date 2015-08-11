----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    13:30:05 07/13/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    vfat2_sector - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description: 
--
-- Handles one VFAT2 sector of I2C and tracking data (= 4 VFAT2s)
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

entity vfat2_sector is      
port(        
    -- System referenc clock
    ref_clk_i               : in std_logic;
    -- System reset
    reset_i                 : in std_logic;
    -- Wishbone request to the I2C slave
    wb_slv_i2c_req_i        : in wb_req_t;
    -- Wishbone response from the I2C slave
    wb_slv_i2c_res_o        : out wb_res_t;
    -- Wishbone request to the Threshold Scan slave 
    wb_slv_threshold_req_i  : in wb_req_t;
    -- Wishbone response from the Threshold Scan slave 
    wb_slv_threshold_res_o  : out wb_res_t;
    -- Wishbone request to the Latency Scan slave 
    wb_slv_latency_req_i  : in wb_req_t;
    -- Wishbone response from the Latency Scan slave 
    wb_slv_latency_res_o  : out wb_res_t;
    -- Wishbone request from the Threshold Scan master to the I2C slaves 
    wb_mst_thr_req_o        : out wb_req_t;
    -- Wishbone response from the I2C slaves to the Threshold Scan master 
    wb_mst_thr_res_i        : in wb_res_t;
    -- Wishbone request from the Latency Scan master to the I2C slaves 
    wb_mst_lat_req_o        : out wb_req_t;
    -- Wishbone response from the I2C slaves to the Latency Scan master 
    wb_mst_lat_res_i        : in wb_res_t;
    -- VFAT2 data out
    vfat2_data_out_i        : in std_logic_vector(3 downto 0);
    -- VFAT2 sbits
    vfat2_sbits_i           : in sbits_array_t(3 downto 0);
    -- VFAT2 I2C signals
    vfat2_scl_o             : out std_logic;
    vfat2_sda_miso_i        : in std_logic;
    vfat2_sda_mosi_o        : out std_logic;
    vfat2_sda_tri_o         : out std_logic
);
end vfat2_sector;

architecture Behavioral of vfat2_sector is

    signal vfat2_tk_data    : tk_data_array_t(3 downto 0);

begin

    --========================--
    --== VFAT2 I2C handlers ==--
    --========================--
    
    vfat2_i2c_inst : entity work.vfat2_i2c
    port map(
        ref_clk_i           => ref_clk_i,
        reset_i             => reset_i,
        wb_slv_req_i        => wb_slv_i2c_req_i,
        wb_slv_res_o        => wb_slv_i2c_res_o,
        vfat2_scl_o         => vfat2_scl_o,
        vfat2_sda_miso_i    => vfat2_sda_miso_i,
        vfat2_sda_mosi_o    => vfat2_sda_mosi_o,
        vfat2_sda_tri_o     => vfat2_sda_tri_o
    );
    
    --==================================--
    --== VFAT2 tracking data decoders ==--
    --==================================--
    
    vfat2_data_decoder_gen : for I in 0 to 3 generate
    begin
    
        vfat2_data_decoder_inst : entity work.vfat2_data_decoder
        port map(
            vfat2_mclk_i        => ref_clk_i,
            reset_i             => reset_i,
            vfat2_data_out_i    => vfat2_data_out_i(I),
            tk_data_o           => vfat2_tk_data(I)
        );

    end generate;
    
    --==========================--
    --== VFAT2 threshold scan ==--
    --==========================--
    
    vfat2_threshold_scan_inst : entity work.vfat2_threshold_scan
    port map(
        ref_clk_i       => ref_clk_i,
        reset_i         => reset_i,
        wb_slv_req_i    => wb_slv_threshold_req_i,
        wb_slv_res_o    => wb_slv_threshold_res_o,
        wb_mst_req_o    => wb_mst_thr_req_o,
        wb_mst_res_i    => wb_mst_thr_res_i,
        vfat2_sbits_i   => vfat2_sbits_i
    );
    
    --==========================--
    --== VFAT2 latency scan ==--
    --==========================--
    
    vfat2_latency_scan_inst : entity work.vfat2_latency_scan
    port map(
        ref_clk_i       => ref_clk_i,
        reset_i         => reset_i,
        wb_slv_req_i    => wb_slv_latency_req_i,
        wb_slv_res_o    => wb_slv_latency_res_o,
        wb_mst_req_o    => wb_mst_lat_req_o,
        wb_mst_res_i    => wb_mst_lat_res_i,
        vfat2_tk_data_i => vfat2_tk_data
    );

end Behavioral;











