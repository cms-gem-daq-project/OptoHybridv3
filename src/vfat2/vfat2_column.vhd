----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    09:06:35 08/12/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    vfat2_column - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description: 
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

entity vfat2_column is
port(
    -- System referenc clock
    ref_clk_i               : in std_logic;
    -- System reset
    reset_i                 : in std_logic;
    -- Wishbone request to the I2C slave
    wb_slv_i2c_req_i        : in wb_req_array_t(1 downto 0);
    -- Wishbone response from the I2C slave
    wb_slv_i2c_res_o        : out wb_res_array_t(1 downto 0);
    -- Wishbone request to the Threshold Scan slave 
    wb_slv_threshold_req_i  : in wb_req_array_t(1 downto 0);
    -- Wishbone response from the Threshold Scan slave 
    wb_slv_threshold_res_o  : out wb_res_array_t(1 downto 0);
    -- Wishbone request to the Latency Scan slave 
    wb_slv_latency_req_i    : in wb_req_array_t(1 downto 0);
    -- Wishbone response from the Latency Scan slave 
    wb_slv_latency_res_o    : out wb_res_array_t(1 downto 0);
    -- Wishbone request from the Threshold Scan master to the I2C slaves 
    wb_mst_thr_req_o        : out wb_req_array_t(1 downto 0);
    -- Wishbone response from the I2C slaves to the Threshold Scan master 
    wb_mst_thr_res_i        : in wb_res_array_t(1 downto 0);
    -- Wishbone request from the Latency Scan master to the I2C slaves 
    wb_mst_lat_req_o        : out wb_req_array_t(1 downto 0);
    -- Wishbone response from the I2C slaves to the Latency Scan master 
    wb_mst_lat_res_i        : in wb_res_array_t(1 downto 0);
    -- VFAT2 data out
    vfat2_data_out_i        : in std_logic_vector(7 downto 0);
    -- VFAT2 sbits
    vfat2_sbits_i           : in sbits_array_t(7 downto 0);
    -- VFAT2 T1 signal
    vfat2_t1_o              : out std_logic;
    -- VFAT2 I2C signals
    vfat2_scl_o             : out std_logic_vector(1 downto 0);
    vfat2_sda_miso_i        : in std_logic_vector(1 downto 0);
    vfat2_sda_mosi_o        : out std_logic_vector(1 downto 0);
    vfat2_sda_tri_o         : out std_logic_vector(1 downto 0)
);
end vfat2_column;

architecture Behavioral of vfat2_column is

    signal local_t1 : t1_t;

begin

    --===================--
    --== VFAT2 sectors ==--
    --===================--
    
    vfat2_sector_gen : for I in 0 to 1 generate
    begin
    
        vfat2_sector_inst : entity work.vfat2_sector      
        port map(        
            ref_clk_i               => ref_clk,
            reset_i                 => reset,
            wb_slv_i2c_req_i        => wb_slv_i2c_req(I),
            wb_slv_i2c_res_o        => wb_slv_i2c_res(I),
            wb_slv_threshold_req_i  => wb_slv_threshold_req(I),
            wb_slv_threshold_res_o  => wb_slv_threshold_res(I),
            wb_slv_latency_req_i    => wb_slv_latency_req(I),
            wb_slv_latency_res_o    => wb_slv_latency_res(I),
            wb_mst_thr_req_o        => wb_mst_thr_req(I),
            wb_mst_thr_res_i        => wb_mst_thr_res(I),
            wb_mst_lat_req_o        => wb_mst_lat_req(I),
            wb_mst_lat_res_i        => wb_mst_lat_res(I),
            vfat2_data_out_i        => vfat2_data_out((4 * I + 3) downto (4 * I)),
            vfat2_sbits_i           => vfat2_sbits((4 * I + 3) downto (4 * I)),
            vfat2_scl_o             => vfat2_scl(I),
            vfat2_sda_miso_i        => vfat2_sda_miso(I),
            vfat2_sda_mosi_o        => vfat2_sda_mosi(I),
            vfat2_sda_tri_o         => vfat2_sda_tri(I)
        );    
    
    end generate;

end Behavioral;

