----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    08:37:20 07/07/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    adc - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description: 
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library work;
use work.types_pkg.all;

entity adc is
port(

    ref_clk_i           : in std_logic;
    reset_i             : in std_logic;

    -- Wishbone slave
    wb_slv_req_i        : in wb_req_t;
    wb_slv_res_o        : out wb_res_t;

    -- ADC lines
    adc_chip_select_o   : out std_logic;
    adc_din_i           : in std_logic;
    adc_dout_o          : out std_logic;
    adc_clk_o           : out std_logic;
    adc_eoc_i           : in std_logic
    
);
end adc;

architecture Behavioral of adc is

    -- I2C transaction parameters 
    signal adc_en       : std_logic;
    signal adc_din      : std_logic_vector(7 downto 0);
    signal adc_valid    : std_logic;
    signal adc_dout     : std_logic_vector(15 downto 0);
    
begin

    --==================================--
    --== Wishbone ADC request handler ==--
    --==================================--
    
    -- 0..150 : VFAT2 registers

    adc_req_inst : entity work.adc_req
    port map(
        ref_clk_i       => ref_clk_i,
        reset_i         => reset_i,
        wb_slv_req_i    => wb_slv_req_i,
        wb_slv_res_o    => wb_slv_res_o,
        adc_en_o        => adc_en,
        adc_data_o      => adc_din,
        adc_valid_i     => adc_valid,
        adc_data_i      => adc_dout
    );
    
    --==========================--
    --== ADC protocol handler ==--
    --==========================--
    
    adc_readout_inst : entity work.adc_readout
    generic map(
        IN_FREQ             => 40_000_000,
        OUT_FREQ            => 2_000_000
    )
    port map(    
        ref_clk_i           => ref_clk_i,
        reset_i             => reset_i,
        en_i                => adc_en,        
        data_i              => adc_din,
        valid_o             => adc_valid,       
        data_o              => adc_dout,
        adc_chip_select_o   => adc_chip_select_o,
        adc_din_i           => adc_din_i,
        adc_dout_o          => adc_dout_o,
        adc_clk_o           => adc_clk_o,
        adc_eoc_i           => adc_eoc_i
    );

end Behavioral;