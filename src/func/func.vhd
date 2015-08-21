----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:48:46 08/19/2015 
-- Design Name: 
-- Module Name:    func - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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

entity func is
port(

    ref_clk_i           : in std_logic;
    reset_i             : in std_logic;
    
    -- Wishbone scan slave
    wb_slv_scan_req_i   : in wb_req_t;
    wb_slv_scan_res_o   : out wb_res_t;
    
    -- Wishbone scan master
    wb_mst_scan_req_o   : out wb_req_t;
    wb_mst_scan_res_i   : in wb_res_t;
    
    -- Wishbone T1 slave
    wb_slv_t1_req_i     : in wb_req_t;
    wb_slv_t1_res_o     : out wb_res_t;
    
    -- Wishbone ext i2c slave
    wb_slv_ei2c_req_i   : in wb_req_array_t(1 downto 0);
    wb_slv_ei2c_res_o   : out wb_res_array_t(1 downto 0);
    
    -- Wishbone ext i2c master
    wb_mst_ei2c_req_o   : out wb_req_t;
    wb_mst_ei2c_res_i   : in wb_res_t;
        
    -- VFAT2 data
    vfat2_tk_data_i     : in tk_data_array_t(23 downto 0);
    vfat2_sbits_i       : in sbits_array_t(23 downto 0);
    
    -- VFAT2 T1 command
    vfat2_t1_o          : out t1_t
    
);
end func;

architecture Behavioral of func is
    
    -- Running modes
    signal scan_running         : std_logic_vector(1 downto 0);
    signal t1_running           : std_logic_vector(1 downto 0);

begin
    
    --=========================--
    --== VFAT2 scan routines ==--
    --=========================--
    
    func_scan_inst : entity work.func_scan
    port map(
        ref_clk_i       => ref_clk_i,
        reset_i         => reset_i,
        wb_slv_req_i    => wb_slv_scan_req_i,
        wb_slv_res_o    => wb_slv_scan_res_o,
        wb_mst_req_o    => wb_mst_scan_req_o,
        wb_mst_res_i    => wb_mst_scan_res_i,
        vfat2_sbits_i   => vfat2_sbits_i,
        vfat2_tk_data_i => vfat2_tk_data_i, 
        scan_running_o  => scan_running
    );

    --===================--
    --== T1 controller ==--
    --===================--
 
   func_t1_inst : entity work.func_t1
    port map(
        ref_clk_i       => ref_clk_i,
        reset_i         => reset_i,
        wb_slv_req_i    => wb_slv_t1_req_i,
        wb_slv_res_o    => wb_slv_t1_res_o,
        vfat2_t1_0      => vfat2_t1_o,
        t1_running_o    => t1_running
    );

    --==================--
    --== Extended I2C ==--
    --==================--
    
    func_i2c_inst : entity work.func_i2c
    port map(
        ref_clk_i       => ref_clk_i,
        reset_i         => reset_i,
        wb_slv_req_i    => wb_slv_ei2c_req_i,
        wb_slv_res_o    => wb_slv_ei2c_res_o,
        wb_mst_req_o    => wb_mst_ei2c_req_o,
        wb_mst_res_i    => wb_mst_ei2c_res_i
    );

end Behavioral;
