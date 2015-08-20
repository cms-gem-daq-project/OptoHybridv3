----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    09:40:27 08/05/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    buffers - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description: 
-- 
-- Implements the design's buffers
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

entity buffers is
port(
    
    --===========--
    --== VFAT2 ==--
    --===========--
    
    --== VFAT2s raw control ==--

    vfat2_mclk_p_o          : out std_logic_vector(2 downto 0);
    vfat2_mclk_n_o          : out std_logic_vector(2 downto 0);

    vfat2_resb_o            : out std_logic_vector(2 downto 0);
    vfat2_resh_o            : out std_logic_vector(2 downto 0);

    vfat2_t1_p_o            : out std_logic_vector(2 downto 0);
    vfat2_t1_n_o            : out std_logic_vector(2 downto 0);

    vfat2_scl_o             : out std_logic_vector(5 downto 0);
    vfat2_sda_io            : inout std_logic_vector(5 downto 0);

    vfat2_data_valid_p_i    : in std_logic_vector(5 downto 0);
    vfat2_data_valid_n_i    : in std_logic_vector(5 downto 0);

    --== VFAT2s raw data ==--

    vfat2_0_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat2_0_sbits_n_i       : in std_logic_vector(7 downto 0);
    vfat2_0_data_out_p_i    : in std_logic;
    vfat2_0_data_out_n_i    : in std_logic;

    vfat2_1_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat2_1_sbits_n_i       : in std_logic_vector(7 downto 0);
    vfat2_1_data_out_p_i    : in std_logic;
    vfat2_1_data_out_n_i    : in std_logic;

    vfat2_2_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat2_2_sbits_n_i       : in std_logic_vector(7 downto 0);
    vfat2_2_data_out_p_i    : in std_logic;
    vfat2_2_data_out_n_i    : in std_logic;

    vfat2_3_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat2_3_sbits_n_i       : in std_logic_vector(7 downto 0);
    vfat2_3_data_out_p_i    : in std_logic;
    vfat2_3_data_out_n_i    : in std_logic;

    vfat2_4_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat2_4_sbits_n_i       : in std_logic_vector(7 downto 0);
    vfat2_4_data_out_p_i    : in std_logic;
    vfat2_4_data_out_n_i    : in std_logic;

    vfat2_5_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat2_5_sbits_n_i       : in std_logic_vector(7 downto 0);
    vfat2_5_data_out_p_i    : in std_logic;
    vfat2_5_data_out_n_i    : in std_logic;

    vfat2_6_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat2_6_sbits_n_i       : in std_logic_vector(7 downto 0);
    vfat2_6_data_out_p_i    : in std_logic;
    vfat2_6_data_out_n_i    : in std_logic;

    vfat2_7_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat2_7_sbits_n_i       : in std_logic_vector(7 downto 0);
    vfat2_7_data_out_p_i    : in std_logic;
    vfat2_7_data_out_n_i    : in std_logic;

    vfat2_8_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat2_8_sbits_n_i       : in std_logic_vector(7 downto 0);
    vfat2_8_data_out_p_i    : in std_logic;
    vfat2_8_data_out_n_i    : in std_logic;

    vfat2_9_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat2_9_sbits_n_i       : in std_logic_vector(7 downto 0);
    vfat2_9_data_out_p_i    : in std_logic;
    vfat2_9_data_out_n_i    : in std_logic;

    vfat2_10_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat2_10_sbits_n_i      : in std_logic_vector(7 downto 0);
    vfat2_10_data_out_p_i   : in std_logic;
    vfat2_10_data_out_n_i   : in std_logic;

    vfat2_11_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat2_11_sbits_n_i      : in std_logic_vector(7 downto 0);
    vfat2_11_data_out_p_i   : in std_logic;
    vfat2_11_data_out_n_i   : in std_logic;

    vfat2_12_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat2_12_sbits_n_i      : in std_logic_vector(7 downto 0);
    vfat2_12_data_out_p_i   : in std_logic;
    vfat2_12_data_out_n_i   : in std_logic;

    vfat2_13_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat2_13_sbits_n_i      : in std_logic_vector(7 downto 0);
    vfat2_13_data_out_p_i   : in std_logic;
    vfat2_13_data_out_n_i   : in std_logic;

    vfat2_14_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat2_14_sbits_n_i      : in std_logic_vector(7 downto 0);
    vfat2_14_data_out_p_i   : in std_logic;
    vfat2_14_data_out_n_i   : in std_logic;

    vfat2_15_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat2_15_sbits_n_i      : in std_logic_vector(7 downto 0);
    vfat2_15_data_out_p_i   : in std_logic;
    vfat2_15_data_out_n_i   : in std_logic;

    vfat2_16_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat2_16_sbits_n_i      : in std_logic_vector(7 downto 0);
    vfat2_16_data_out_p_i   : in std_logic;
    vfat2_16_data_out_n_i   : in std_logic;

    vfat2_17_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat2_17_sbits_n_i      : in std_logic_vector(7 downto 0);
    vfat2_17_data_out_p_i   : in std_logic;
    vfat2_17_data_out_n_i   : in std_logic;

    vfat2_18_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat2_18_sbits_n_i      : in std_logic_vector(7 downto 0);
    vfat2_18_data_out_p_i   : in std_logic;
    vfat2_18_data_out_n_i   : in std_logic;

    vfat2_19_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat2_19_sbits_n_i      : in std_logic_vector(7 downto 0);
    vfat2_19_data_out_p_i   : in std_logic;
    vfat2_19_data_out_n_i   : in std_logic;

    vfat2_20_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat2_20_sbits_n_i      : in std_logic_vector(7 downto 0);
    vfat2_20_data_out_p_i   : in std_logic;
    vfat2_20_data_out_n_i   : in std_logic;

    vfat2_21_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat2_21_sbits_n_i      : in std_logic_vector(7 downto 0);
    vfat2_21_data_out_p_i   : in std_logic;
    vfat2_21_data_out_n_i   : in std_logic;

    vfat2_22_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat2_22_sbits_n_i      : in std_logic_vector(7 downto 0);
    vfat2_22_data_out_p_i   : in std_logic;
    vfat2_22_data_out_n_i   : in std_logic;

    vfat2_23_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat2_23_sbits_n_i      : in std_logic_vector(7 downto 0);
    vfat2_23_data_out_p_i   : in std_logic;
    vfat2_23_data_out_n_i   : in std_logic;

    --== VFAT2s buffered control ==--

    vfat2_mclk_i            : in std_logic;

    vfat2_reset_i           : in std_logic;

    vfat2_t1_i              : in std_logic;

    vfat2_scl_i             : in std_logic_vector(5 downto 0);
    vfat2_sda_mosi_i        : in std_logic_vector(5 downto 0);
    vfat2_sda_miso_o        : out std_logic_vector(5 downto 0);
    vfat2_sda_tri_i         : in std_logic_vector(5 downto 0);

    vfat2_data_valid_o      : out std_logic_vector(5 downto 0);

    --== VFAT2s buffered data ==--

    vfat2_data_out_o        : out std_logic_vector(23 downto 0);
    vfat2_sbits_o           : out sbits_array_t(23 downto 0);
    
    --=========--
    --== ADC ==--
    --=========--
    
    --== ADC raw ==--
    
    adc_clk_o               : out std_logic;
    adc_chip_select_o       : out std_logic;
    adc_dout_o              : out std_logic;
    
    adc_din_i               : in std_logic;
    adc_eoc_i               : in std_logic;
    
    --== ADC buffered ==--
    
    adc_clk_i               : in std_logic;
    adc_chip_select_i       : in std_logic;
    adc_dout_i              : in std_logic;
    
    adc_din_o               : out std_logic;
    adc_eoc_o               : out std_logic;

    --==========--
    --== CDCE ==--
    --==========--
    
    --== CDCE raw ==--
    
    cdce_clk_p_i            : in std_logic;
    cdce_clk_n_i            : in std_logic;
    
    cdce_clk_pri_p_o        : out std_logic;
    cdce_clk_pri_n_o        : out std_logic;

    cdce_aux_out_o          : out std_logic;
    cdce_aux_in_i           : in std_logic;
    cdce_ref_o              : out std_logic;
    cdce_pwrdown_o          : out std_logic;
    cdce_sync_o             : out std_logic;
    cdce_locked_i           : in std_logic;
    
    cdce_sck_o              : out std_logic;
    cdce_mosi_o             : out std_logic;
    cdce_le_o               : out std_logic;
    cdce_miso_i             : in std_logic;
    
    --== CDCE buffered ==--
     
    cdce_clk_o              : out std_logic;
    
    cdce_clk_pri_i          : in std_logic;

    cdce_aux_out_i          : in std_logic;
    cdce_aux_in_o           : out std_logic;
    cdce_ref_i              : in std_logic;
    cdce_pwrdown_i          : in std_logic;
    cdce_sync_i             : in std_logic;
    cdce_locked_o           : out std_logic;
    
    cdce_sck_i              : in std_logic;
    cdce_mosi_i             : in std_logic;
    cdce_le_i               : in std_logic;
    cdce_miso_o             : out std_logic;
    
    --============--
    --== ChipID ==--
    --============--
    
    --== ChipID raw ==--
    
    chipid_io               : inout std_logic;

    --== ChipID buffered ==--
    
    chipid_mosi_i           : in std_logic;
    chipid_miso_o           : out std_logic;
    chipid_tri_i            : in std_logic;
    
    --==========--
    --== QPLL ==--
    --==========--

    --== QPLL raw ==--

    qpll_ref_40MHz_o        : out std_logic;
    qpll_reset_o            : out std_logic;
    
    qpll_locked_i           : in std_logic;
    qpll_error_i            : in std_logic;
    
    qpll_clk_p_i            : in std_logic;
    qpll_clk_n_i            : in std_logic;
        
    --== QPLL buffered ==--
    
    qpll_ref_40MHz_i        : in std_logic;
    qpll_reset_i            : in std_logic;
    
    qpll_locked_o           : out std_logic;
    qpll_error_o            : out std_logic;
    
    qpll_clk_o              : out std_logic;
    
    --=================--
    --== Temperature ==--
    --=================--
    
    --== Temperature raw ==--

    temp_clk_o              : out std_logic;
    temp_data_io            : inout std_logic;

    --== Temperature buffered ==--
    
    temp_clk_i              : in std_logic;
    
    temp_data_mosi_i        : in std_logic;
    temp_data_miso_o        : out std_logic;
    temp_data_tri_i         : in std_logic
    
);
end buffers;

architecture Behavioral of buffers is
begin

    --===================--
    --== VFAT2 buffers ==--
    --===================--
    
    vfat2_buffers_inst : entity work.vfat2_buffers
    port map(
        -- Raw
        vfat2_mclk_p_o          => vfat2_mclk_p_o,
        vfat2_mclk_n_o          => vfat2_mclk_n_o,
        vfat2_resb_o            => vfat2_resb_o,
        vfat2_resh_o            => vfat2_resh_o,
        vfat2_t1_p_o            => vfat2_t1_p_o,
        vfat2_t1_n_o            => vfat2_t1_n_o,
        vfat2_scl_o             => vfat2_scl_o,
        vfat2_sda_io            => vfat2_sda_io,
        vfat2_data_valid_p_i    => vfat2_data_valid_p_i,
        vfat2_data_valid_n_i    => vfat2_data_valid_n_i,
        vfat2_0_sbits_p_i		=> vfat2_0_sbits_p_i,
        vfat2_0_sbits_n_i		=> vfat2_0_sbits_n_i,
        vfat2_0_data_out_p_i	=> vfat2_0_data_out_p_i,
        vfat2_0_data_out_n_i	=> vfat2_0_data_out_n_i,
        vfat2_1_sbits_p_i		=> vfat2_1_sbits_p_i,
        vfat2_1_sbits_n_i		=> vfat2_1_sbits_n_i,
        vfat2_1_data_out_p_i	=> vfat2_1_data_out_p_i,
        vfat2_1_data_out_n_i	=> vfat2_1_data_out_n_i,
        vfat2_2_sbits_p_i		=> vfat2_2_sbits_p_i,
        vfat2_2_sbits_n_i		=> vfat2_2_sbits_n_i,
        vfat2_2_data_out_p_i	=> vfat2_2_data_out_p_i,
        vfat2_2_data_out_n_i	=> vfat2_2_data_out_n_i,
        vfat2_3_sbits_p_i		=> vfat2_3_sbits_p_i,
        vfat2_3_sbits_n_i		=> vfat2_3_sbits_n_i,
        vfat2_3_data_out_p_i	=> vfat2_3_data_out_p_i,
        vfat2_3_data_out_n_i	=> vfat2_3_data_out_n_i,
        vfat2_4_sbits_p_i		=> vfat2_4_sbits_p_i,
        vfat2_4_sbits_n_i		=> vfat2_4_sbits_n_i,
        vfat2_4_data_out_p_i	=> vfat2_4_data_out_p_i,
        vfat2_4_data_out_n_i	=> vfat2_4_data_out_n_i,
        vfat2_5_sbits_p_i		=> vfat2_5_sbits_p_i,
        vfat2_5_sbits_n_i		=> vfat2_5_sbits_n_i,
        vfat2_5_data_out_p_i	=> vfat2_5_data_out_p_i,
        vfat2_5_data_out_n_i	=> vfat2_5_data_out_n_i,
        vfat2_6_sbits_p_i		=> vfat2_6_sbits_p_i,
        vfat2_6_sbits_n_i		=> vfat2_6_sbits_n_i,
        vfat2_6_data_out_p_i	=> vfat2_6_data_out_p_i,
        vfat2_6_data_out_n_i	=> vfat2_6_data_out_n_i,
        vfat2_7_sbits_p_i		=> vfat2_7_sbits_p_i,
        vfat2_7_sbits_n_i		=> vfat2_7_sbits_n_i,
        vfat2_7_data_out_p_i	=> vfat2_7_data_out_p_i,
        vfat2_7_data_out_n_i	=> vfat2_7_data_out_n_i,
        vfat2_8_sbits_p_i		=> vfat2_8_sbits_p_i,
        vfat2_8_sbits_n_i		=> vfat2_8_sbits_n_i,
        vfat2_8_data_out_p_i	=> vfat2_8_data_out_p_i,
        vfat2_8_data_out_n_i	=> vfat2_8_data_out_n_i,
        vfat2_9_sbits_p_i		=> vfat2_9_sbits_p_i,
        vfat2_9_sbits_n_i		=> vfat2_9_sbits_n_i,
        vfat2_9_data_out_p_i	=> vfat2_9_data_out_p_i,
        vfat2_9_data_out_n_i	=> vfat2_9_data_out_n_i,
        vfat2_10_sbits_p_i		=> vfat2_10_sbits_p_i,
        vfat2_10_sbits_n_i		=> vfat2_10_sbits_n_i,
        vfat2_10_data_out_p_i	=> vfat2_10_data_out_p_i,
        vfat2_10_data_out_n_i	=> vfat2_10_data_out_n_i,
        vfat2_11_sbits_p_i		=> vfat2_11_sbits_p_i,
        vfat2_11_sbits_n_i		=> vfat2_11_sbits_n_i,
        vfat2_11_data_out_p_i	=> vfat2_11_data_out_p_i,
        vfat2_11_data_out_n_i	=> vfat2_11_data_out_n_i,
        vfat2_12_sbits_p_i		=> vfat2_12_sbits_p_i,
        vfat2_12_sbits_n_i		=> vfat2_12_sbits_n_i,
        vfat2_12_data_out_p_i	=> vfat2_12_data_out_p_i,
        vfat2_12_data_out_n_i	=> vfat2_12_data_out_n_i,
        vfat2_13_sbits_p_i		=> vfat2_13_sbits_p_i,
        vfat2_13_sbits_n_i		=> vfat2_13_sbits_n_i,
        vfat2_13_data_out_p_i	=> vfat2_13_data_out_p_i,
        vfat2_13_data_out_n_i	=> vfat2_13_data_out_n_i,
        vfat2_14_sbits_p_i		=> vfat2_14_sbits_p_i,
        vfat2_14_sbits_n_i		=> vfat2_14_sbits_n_i,
        vfat2_14_data_out_p_i	=> vfat2_14_data_out_p_i,
        vfat2_14_data_out_n_i	=> vfat2_14_data_out_n_i,
        vfat2_15_sbits_p_i		=> vfat2_15_sbits_p_i,
        vfat2_15_sbits_n_i		=> vfat2_15_sbits_n_i,
        vfat2_15_data_out_p_i	=> vfat2_15_data_out_p_i,
        vfat2_15_data_out_n_i	=> vfat2_15_data_out_n_i,
        vfat2_16_sbits_p_i		=> vfat2_16_sbits_p_i,
        vfat2_16_sbits_n_i		=> vfat2_16_sbits_n_i,
        vfat2_16_data_out_p_i	=> vfat2_16_data_out_p_i,
        vfat2_16_data_out_n_i	=> vfat2_16_data_out_n_i,
        vfat2_17_sbits_p_i		=> vfat2_17_sbits_p_i,
        vfat2_17_sbits_n_i		=> vfat2_17_sbits_n_i,
        vfat2_17_data_out_p_i	=> vfat2_17_data_out_p_i,
        vfat2_17_data_out_n_i	=> vfat2_17_data_out_n_i,
        vfat2_18_sbits_p_i		=> vfat2_18_sbits_p_i,
        vfat2_18_sbits_n_i		=> vfat2_18_sbits_n_i,
        vfat2_18_data_out_p_i	=> vfat2_18_data_out_p_i,
        vfat2_18_data_out_n_i	=> vfat2_18_data_out_n_i,
        vfat2_19_sbits_p_i		=> vfat2_19_sbits_p_i,
        vfat2_19_sbits_n_i		=> vfat2_19_sbits_n_i,
        vfat2_19_data_out_p_i	=> vfat2_19_data_out_p_i,
        vfat2_19_data_out_n_i	=> vfat2_19_data_out_n_i,
        vfat2_20_sbits_p_i		=> vfat2_20_sbits_p_i,
        vfat2_20_sbits_n_i		=> vfat2_20_sbits_n_i,
        vfat2_20_data_out_p_i	=> vfat2_20_data_out_p_i,
        vfat2_20_data_out_n_i	=> vfat2_20_data_out_n_i,
        vfat2_21_sbits_p_i		=> vfat2_21_sbits_p_i,
        vfat2_21_sbits_n_i		=> vfat2_21_sbits_n_i,
        vfat2_21_data_out_p_i	=> vfat2_21_data_out_p_i,
        vfat2_21_data_out_n_i	=> vfat2_21_data_out_n_i,
        vfat2_22_sbits_p_i		=> vfat2_22_sbits_p_i,
        vfat2_22_sbits_n_i		=> vfat2_22_sbits_n_i,
        vfat2_22_data_out_p_i	=> vfat2_22_data_out_p_i,
        vfat2_22_data_out_n_i	=> vfat2_22_data_out_n_i,
        vfat2_23_sbits_p_i		=> vfat2_23_sbits_p_i,
        vfat2_23_sbits_n_i		=> vfat2_23_sbits_n_i,
        vfat2_23_data_out_p_i	=> vfat2_23_data_out_p_i,
        vfat2_23_data_out_n_i	=> vfat2_23_data_out_n_i,
        -- Buffered
        vfat2_mclk_i            => vfat2_mclk_i,
        vfat2_reset_i           => vfat2_reset_i,
        vfat2_t1_i              => vfat2_t1_i,
        vfat2_scl_i             => vfat2_scl_i,
        vfat2_sda_miso_o        => vfat2_sda_miso_o, 
        vfat2_sda_mosi_i        => vfat2_sda_mosi_i,
        vfat2_sda_tri_i         => vfat2_sda_tri_i,
        vfat2_data_valid_o      => vfat2_data_valid_o,
        vfat2_data_out_o        => vfat2_data_out_o,
        vfat2_sbits_o           => vfat2_sbits_o
    );
    
    --=================--
    --== ADC buffers ==--
    --=================--

    adc_buffers_inst : entity work.adc_buffers
    port map(
        -- Raw
        adc_clk_o           => adc_clk_o,
        adc_chip_select_o   => adc_chip_select_o,
        adc_dout_o          => adc_dout_o,
        adc_din_i           => adc_din_i,
        adc_eoc_i           => adc_eoc_i,
        -- Buffered
        adc_clk_i           => adc_clk_i,
        adc_chip_select_i   => adc_chip_select_i,
        adc_dout_i          => adc_dout_i,
        adc_din_o           => adc_din_o,
        adc_eoc_o           => adc_eoc_o
    );

    --==================--
    --== CDCE buffers ==--
    --==================--

    cdce_buffers_inst : entity work.cdce_buffers
    port map(
        -- Raw
        cdce_clk_p_i        => cdce_clk_p_i,
        cdce_clk_n_i        => cdce_clk_n_i,
        cdce_clk_pri_p_o    => cdce_clk_pri_p_o,
        cdce_clk_pri_n_o    => cdce_clk_pri_n_o,
        cdce_aux_out_o      => cdce_aux_out_o,
        cdce_aux_in_i       => cdce_aux_in_i,
        cdce_ref_o          => cdce_ref_o,
        cdce_pwrdown_o      => cdce_pwrdown_o,
        cdce_sync_o         => cdce_sync_o,
        cdce_locked_i       => cdce_locked_i,
        cdce_sck_o          => cdce_sck_o,
        cdce_mosi_o         => cdce_mosi_o,
        cdce_le_o           => cdce_le_o,
        cdce_miso_i         => cdce_miso_i,
        -- Buffered
        cdce_clk_o          => cdce_clk_o,
        cdce_clk_pri_i      => cdce_clk_pri_i,
        cdce_aux_out_i      => cdce_aux_out_i,
        cdce_aux_in_o       => cdce_aux_in_o,
        cdce_ref_i          => cdce_ref_i,
        cdce_pwrdown_i      => cdce_pwrdown_i,
        cdce_sync_i         => cdce_sync_i,
        cdce_locked_o       => cdce_locked_o,
        cdce_sck_i          => cdce_sck_i,
        cdce_mosi_i         => cdce_mosi_i,
        cdce_le_i           => cdce_le_i,
        cdce_miso_o         => cdce_miso_o
    );

    --====================--
    --== ChipID buffers ==--
    --====================--
    
    chipid_buffers_inst : entity work.chipid_buffers
    port map(
        -- Raw
        chipid_io       => chipid_io,
        -- Buffered
        chipid_mosi_i   => chipid_mosi_i,
        chipid_miso_o   => chipid_miso_o,
        chipid_tri_i    => chipid_tri_i
    );

    --==================--
    --== QPLL buffers ==--
    --==================--
    
    qpll_buffers_inst : entity work.qpll_buffers
    port map(
        -- Raw
        qpll_ref_40MHz_o    => qpll_ref_40MHz_o,
        qpll_reset_o        => qpll_reset_o,
        qpll_locked_i       => qpll_locked_i,
        qpll_error_i        => qpll_error_i,
        qpll_clk_p_i        => qpll_clk_p_i,
        qpll_clk_n_i        => qpll_clk_n_i,
        -- Buffered
        qpll_ref_40MHz_i    => qpll_ref_40MHz_i,
        qpll_reset_i        => qpll_reset_i,
        qpll_locked_o       => qpll_locked_o,
        qpll_error_o        => qpll_error_o,
        qpll_clk_o          => qpll_clk_o
    );

    --=========================--
    --== Temperature buffers ==--
    --=========================--

    temp_buffers_inst : entity work.temp_buffers
    port map(
        -- Raw
        temp_clk_o          => temp_clk_o,
        temp_data_io        => temp_data_io,
        -- Buffered
        temp_clk_i          => temp_clk_i,
        temp_data_mosi_i    => temp_data_mosi_i,
        temp_data_miso_o    => temp_data_miso_o,
        temp_data_tri_i     => temp_data_tri_i
    );

end Behavioral;

