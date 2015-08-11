----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    11:22:49 06/30/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    vfat2_i2c - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description:
--
-- Whishbone slave that handles the I2C communication with the VFAT2s
--
-- Register map:
-- 0..151 : VFAT2 registers
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

entity vfat2_i2c is
port(

    ref_clk_i           : in std_logic;
    reset_i             : in std_logic;
    
    wb_slv_req_i        : in wb_req_t;
    wb_slv_res_o        : out wb_res_t;
    
    vfat2_scl_o         : out std_logic;
    vfat2_sda_miso_i    : in std_logic;
    vfat2_sda_mosi_o    : out std_logic;
    vfat2_sda_tri_o     : out std_logic
    
);
end vfat2_i2c;

architecture Behavioral of vfat2_i2c is

    signal i2c_en       : std_logic;
    signal i2c_address  : std_logic_vector(6 downto 0);
    signal i2c_rw       : std_logic;
    signal i2c_din      : std_logic_vector(7 downto 0);
    
    signal i2c_valid    : std_logic;
    signal i2c_error    : std_logic;
    signal i2c_dout     : std_logic_vector(7 downto 0);
    
begin

    --========================================--
    --== Wishbone VFAT2 I2C request handler ==--
    --========================================--

    vfat2_i2c_req_inst : entity work.vfat2_i2c_req
    port map(
        ref_clk_i       => ref_clk_i,
        reset_i         => reset_i,
        wb_slv_req_i    => wb_slv_req_i,
        wb_slv_res_o    => wb_slv_res_o,
        i2c_en_o        => i2c_en,
        i2c_address_o   => i2c_address,
        i2c_rw_o        => i2c_rw,
        i2c_data_o      => i2c_din,
        i2c_valid_i     => i2c_valid,
        i2c_error_i     => i2c_error,
        i2c_data_i      => i2c_dout
    );
    
    --==========================--
    --== I2C protocol handler ==--
    --==========================--
    
    i2c_inst : entity work.i2c
    generic map(
        CLK_DIV     => 400
    )
    port map(    
        clk_i       => ref_clk_i,
        reset_i     => reset_i,
        en_i        => i2c_en,
        address_i   => i2c_address,
        rw_i        => i2c_rw,
        data_i      => i2c_din,
        valid_o     => i2c_valid,
        error_o     => i2c_error,
        data_o      => i2c_dout,
        scl_o       => vfat2_scl_o,
        sda_miso_i  => vfat2_sda_miso_i,
        sda_mosi_o  => vfat2_sda_mosi_o,
        sda_tri_o   => vfat2_sda_tri_o
    );

end Behavioral;