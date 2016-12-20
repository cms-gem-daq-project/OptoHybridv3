----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    08:37:33 07/07/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    link_tkdata - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description: 
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.types_pkg.all;

entity link_tracking is
port(

    ref_clk_i       : in std_logic;
    link_clk_i      : in std_logic;
    reset_i         : in std_logic;
    
    vfat2_t1_i      : in t1_t;
    vfat2_tk_data_i : in tk_data_array_t(23 downto 0);
    vfat2_tk_mask_i : in std_logic_vector(23 downto 0);
    zero_suppress_i : in std_logic;
    
    evt_en_i        : in std_logic;
    evt_valid_o     : out std_logic;
    evt_data_o      : out std_logic_vector(223 downto 0)
    
);
end link_tracking;

architecture Behavioral of link_tracking is
      
    signal ec_bc_rd     : std_logic;
    signal ec_bc_valid  : std_logic;
    signal ec_bc_error  : std_logic;
    signal ec_bc_data   : std_logic_vector(31 downto 0);
    
    signal evt_wr       : std_logic;
    signal evt_data     : std_logic_vector(223 downto 0);
    
begin

    --== Tracking data concentrator ==--

    tracking_concentrator_inst : entity work.tracking_concentrator    
    port map(
        ref_clk_i       => ref_clk_i,
        reset_i         => reset_i,
        vfat2_tk_data_i => vfat2_tk_data_i,
        vfat2_tk_mask_i => vfat2_tk_mask_i,
        zero_suppress_i => zero_suppress_i,        
        ec_bc_rd_o      => ec_bc_rd,
        ec_bc_valid_i   => ec_bc_valid,
        ec_bc_error_i   => ec_bc_error,
        ec_bc_data_i    => ec_bc_data,
        evt_wr_o        => evt_wr,
        evt_data_o      => evt_data
    );
    
    --== FIFO ==--
    
    fifo_tracking_inst : entity work.fifo_tracking
    port map(
        rst     => reset_i,
        wr_clk  => ref_clk_i,
        wr_en   => evt_wr,
        din     => evt_data,        
        rd_clk  => link_clk_i,
        rd_en   => evt_en_i,
        valid   => evt_valid_o,
        dout    => evt_data_o,
        full    => open,
        empty   => open
    );
    
    --== BX and EC FIFO ==--
    
    ec_bc_inst : entity work.ec_bc
    port map(
        ref_clk_i   => ref_clk_i,
        reset_i     => reset_i,        
        vfat2_t1_i  => vfat2_t1_i,   
        rd_i        => ec_bc_rd,
        valid_o     => ec_bc_valid,
        error_o     => ec_bc_error,
        data_o      => ec_bc_data   
    );
       
    
    
end Behavioral;