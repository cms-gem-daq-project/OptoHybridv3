----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    13:13:21 03/12/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    optohybrid_top - Behavioral 
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

library unisim;
use unisim.vcomponents.all;

library work;
use work.types_pkg.all;

entity optohybrid_top is
port(

    --== VFAT2s Control ==--
    
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
    
    --== VFAT2s Data ==--
    
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
    
    --== Memory ==--
    
--    multiboot_rs_o          : out std_logic_vector(1 downto 0);
    
--    flash_address_o         : out std_logic_vector(22 downto 0);
--    flash_data_io           : inout std_logic_vector(15 downto 0);
--    flash_chip_enable_b_o   : out std_logic;
--    flash_out_enable_b_o    : out std_logic;
--    flash_write_enable_b_o  : out std_logic;
--    flash_latch_enable_b_o  : out std_logic;
    
--    eprom_data_i            : inout std_logic_vector(7 downto 0);
--    eprom_clk_o             : out std_logic;
--    eprom_reset_b_o         : out std_logic;
--    eprom_chip_enable_b_o   : out std_logic;
--    eprom_tdi_o             : out std_logic;
--    eprom_tdo_i             : in std_logic;
--    eprom_tms_o             : out std_logic;
--    eprom_tck_o             : out std_logic;
    
    --== Clocking ==--
    
    clk_50MHz_i             : in std_logic;

    qpll_ref_40MHz_o        : out std_logic;
    qpll_reset_o            : out std_logic;
    qpll_locked_i           : in std_logic;
    qpll_error_i            : in std_logic;
    qpll_clk_p_i            : in std_logic;
    qpll_clk_n_i            : in std_logic;

    cdce_clk_p_i            : in std_logic;
    cdce_clk_n_i            : in std_logic;
    cdce_clk_pri_p_o        : out std_logic;
    cdce_clk_pri_n_o        : out std_logic;
    cdce_aux_o              : out std_logic;
    cdce_aux_i              : in std_logic;
    cdce_ref_o              : out std_logic;
    cdce_pwrdown_o          : out std_logic;
    cdce_sync_o             : out std_logic;
    cdce_locked_i           : in std_logic;
    cdce_sck_o              : out std_logic;
    cdce_mosi_o             : out std_logic;
    cdce_le_o               : out std_logic;
    cdce_miso_i             : in std_logic;
    
    --== Miscellaneous ==--
    
--    hdmi_scl_io             : inout std_logic_vector(1 downto 0);
--    hdmi_sda_io             : inout std_logic_vector(1 downto 0);
--
--    tmds_d_p_io             : inout std_logic_vector(1 downto 0);
--    tmds_d_n_io             : inout std_logic_vector(1 downto 0);
--
--    tmds_clk_p_io           : inout std_logic;
--    tmds_clk_n_io           : inout std_logic;

    adc_chip_select_o       : out std_logic;
    adc_din_i               : in std_logic;
    adc_dout_o              : out std_logic;
    adc_clk_o               : out std_logic;
    adc_eoc_i               : in std_logic;

    temp_clk_o              : out std_logic;
    temp_data_io            : inout std_logic;

--    chip_id_i               : in std_logic;
    
    --== GTX ==--
    
    mgt_112_clk0_p_i        : in std_logic;
    mgt_112_clk0_n_i        : in std_logic;
    
--    mgt_116_clk1_p_i        : in std_logic;
--    mgt_116_clk1_n_i        : in std_logic;
    
    mgt_112_rx_p_i          : in std_logic_vector(3 downto 0);
    mgt_112_rx_n_i          : in std_logic_vector(3 downto 0);
    mgt_112_tx_p_o          : out std_logic_vector(3 downto 0);
    mgt_112_tx_n_o          : out std_logic_vector(3 downto 0)
    
--    mgt_113_rx_p_i          : in std_logic_vector(3 downto 0);
--    mgt_113_rx_n_i          : in std_logic_vector(3 downto 0);
--    mgt_113_tx_p_o          : out std_logic_vector(3 downto 0);
--    mgt_113_tx_n_o          : out std_logic_vector(3 downto 0);
    
--    mgt_114_rx_p_i          : in std_logic_vector(3 downto 0);
--    mgt_114_rx_n_i          : in std_logic_vector(3 downto 0);
--    mgt_114_tx_p_o          : out std_logic_vector(3 downto 0);
--    mgt_114_tx_n_o          : out std_logic_vector(3 downto 0);
    
--    mgt_115_rx_p_i          : in std_logic_vector(3 downto 0);
--    mgt_115_rx_n_i          : in std_logic_vector(3 downto 0);
--    mgt_115_tx_p_o          : out std_logic_vector(3 downto 0);
--    mgt_115_tx_n_o          : out std_logic_vector(3 downto 0);
    
--    mgt_116_rx_p_i          : in std_logic_vector(3 downto 0);
--    mgt_116_rx_n_i          : in std_logic_vector(3 downto 0);
--    mgt_116_tx_p_o          : out std_logic_vector(3 downto 0);
--    mgt_116_tx_n_o          : out std_logic_vector(3 downto 0)

);
end optohybrid_top;

architecture Behavioral of optohybrid_top is

    --== VFAT2 signals ==--

    signal vfat2_mclk               : std_logic_vector(2 downto 0); 
    signal vfat2_reset              : std_logic_vector(2 downto 0); 
    signal vfat2_t1                 : std_logic_vector(2 downto 0); 
    signal vfat2_scl                : std_logic_vector(5 downto 0); 
    signal vfat2_sda_out            : std_logic_vector(5 downto 0); 
    signal vfat2_sda_in             : std_logic_vector(5 downto 0); 
    signal vfat2_sda_tri            : std_logic_vector(5 downto 0); 
    signal vfat2_data_valid         : std_logic_vector(5 downto 0); 
    signal vfat2_data_out           : std_logic_vector(23 downto 0);
    signal vfat2_sbits              : sbits_array_t(23 downto 0);
    
    --== Clock signals ==--

    signal ref_clk                  : std_logic; -- LHC reference clock used for the whole system (some parts might run at higher speeds)
                                                 -- also used as GBT RX clock which simplifies operations
                                             
    signal mgt_refclk               : std_logic; -- MGT reference clock at 240 MHz comming from the CDCE

    signal gbt_tx_wordclk           : std_logic; -- 240 MHz clock
    signal gbt_tx_frameclk          : std_logic; -- 40 MHz clock (use to send data)
    
    signal gbt_rx_wordclk           : std_logic_vector(3 downto 0); -- 240 MHz clock
    signal gbt_rx_frameclk          : std_logic_vector(3 downto 0); -- 40 MHz clock (use to receive data)

    --== Reset signals ==--

    signal reset                    : std_logic;
    
    --== GBT signals ==--
    
    signal gbt_tx                   : gbt_data_array_t(3 downto 0);
    signal gbt_rx                   : gbt_data_array_t(3 downto 0);
    signal mgt_ready                : std_logic_vector(3 downto 0); 
    signal gbt_tx_frame_pll_locked  : std_logic;  
    signal gbt_rx_ready             : std_logic_vector(3 downto 0);  
    signal gbt_rx_frameclk_ready    : std_logic_vector(3 downto 0); 
    signal gbt_rx_wordclk_ready     : std_logic_vector(3 downto 0);

begin

    --===================--
    --== VFAT2 buffers ==--
    --===================--
    
    vfat2_buffers_inst : entity work.vfat2_buffers
    port map(
        --
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
        --
        vfat2_mclk_i            => vfat2_mclk,
        vfat2_reset_i           => vfat2_reset,
        vfat2_t1_i              => vfat2_t1,
        vfat2_scl_i             => vfat2_scl,
        vfat2_sda_i             => vfat2_sda_out,
        vfat2_sda_o             => vfat2_sda_in, 
        vfat2_sda_t             => vfat2_sda_tri,
        vfat2_data_valid_o      => vfat2_data_valid,
        --
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
        --
        vfat2_data_out_o        => vfat2_data_out,
        vfat2_sbits_o           => vfat2_sbits
    );
    
    --=========--
    --== GBT ==--
    --=========--

    gbt_inst : entity work.gbt
    port map(
        mgt_refclk_p_i          => mgt_112_clk0_p_i,
        mgt_refclk_n_i          => mgt_112_clk0_n_i,
        general_reset_i         => reset,
        manual_reset_tx_i       => '0',
        manual_reset_rx_i       => '0',
        mgt_tx_p_o              => mgt_112_tx_p_o, 
        mgt_tx_n_o              => mgt_112_tx_n_o,
        mgt_rx_p_i              => mgt_112_rx_p_i,
        mgt_rx_n_i              => mgt_112_rx_n_i,     
        tx_data_i               => gbt_tx,
        rx_data_o               => gbt_rx,
        tx_frameclk_o           => gbt_tx_frameclk,
        tx_wordclk_o            => gbt_tx_wordclk,
        rx_frameclk_o           => gbt_rx_frameclk,                 
        rx_wordclk_o            => gbt_rx_wordclk,
        rx_frameclk_ready_o     => gbt_rx_frameclk_ready,
        rx_wordclk_ready_o      => gbt_rx_wordclk_ready,
        tx_frame_pll_locked_o   => gbt_tx_frame_pll_locked,
        mgt_ready_o             => mgt_ready,
        gbt_rx_ready_o          => gbt_rx_ready 
    );
    
    --====================--
    --== Tracking links ==--
    --====================--
    
    tk_link_loop : for I in 0 to 2 generate
    begin
    
        tk_link_inst : entity work.tk_link
        port map(
            ref_clk_i           => ref_clk,
            reset_i             => reset,
            vfat2_mclk_o        => vfat2_mclk(I),
            vfat2_reset_o       => vfat2_reset(I),
            vfat2_t1_o          => vfat2_t1(I),
            vfat2_scl_o         => vfat2_scl((I * 2 + 1) downto (I * 2)),
            vfat2_sda_o         => vfat2_sda_out((I * 2 + 1) downto (I * 2)),
            vfat2_sda_i         => vfat2_sda_in((I * 2 + 1) downto (I * 2)),
            vfat2_sda_t         => vfat2_sda_tri((I * 2 + 1) downto (I * 2)),
            vfat2_data_valid_i  => vfat2_data_valid((I * 2 + 1) downto (I * 2)),
            vfat2_data_out_i    => vfat2_data_out((I * 8 + 7) downto (I * 8)),
            gbt_rx_i            => gbt_rx(I),
            gbt_tx_o            => gbt_tx(I),
            gbt_tx_frameclk_i   => gbt_tx_frameclk,
            gbt_tx_wordclk_i    => gbt_tx_wordclk,
            gbt_rx_frameclk_i   => gbt_rx_frameclk(I),
            gbt_rx_wordclk_i    => gbt_rx_wordclk(I),
            gbt_rx_ready_i      => gbt_rx_ready(I),
            mgt_ready_i         => mgt_ready(I)
        );   
        
    end generate;   
    
    --==========--
    --== QPLL ==--
    --==========--
    
    qpll_inst : entity work.qpll
    port map(
        qpll_ref_40MHz_o    => qpll_ref_40MHz_o,
        qpll_reset_o        => qpll_reset_o,
        qpll_locked_i       => qpll_locked_i,
        qpll_error_i        => qpll_error_i,
        qpll_clk_p_i        => qpll_clk_p_i,
        qpll_clk_n_i        => qpll_clk_n_i
    );     
    
    --==========--
    --== CDCE ==--
    --==========--
    
    cdce_inst : entity work.cdce
    port map( 
        cdce_clk_p_i        => cdce_clk_p_i,
        cdce_clk_n_i        => cdce_clk_n_i,
        cdce_clk_pri_p_o    => cdce_clk_pri_p_o,
        cdce_clk_pri_n_o    => cdce_clk_pri_n_o,
        cdce_aux_o          => cdce_aux_o,
        cdce_aux_i          => cdce_aux_i,
        cdce_ref_o          => cdce_ref_o,
        cdce_pwrdown_o      => cdce_pwrdown_o,
        cdce_sync_o         => cdce_sync_o,
        cdce_locked_i       => cdce_locked_i,
        cdce_sck_o          => cdce_sck_o,
        cdce_mosi_o         => cdce_mosi_o,
        cdce_le_o           => cdce_le_o,
        cdce_miso_i         => cdce_miso_i
    );
    
    --=========--
    --== ADC ==--
    --=========--
    
    adc_inst : entity work.adc
    port map(
        adc_io_clk_o    => adc_clk_o,
        adc_cs_n_o      => adc_chip_select_o,
        adc_data_o      => adc_dout_o,
        adc_data_i      => adc_din_i,
        adc_eoc_i       => adc_eoc_i
    );   
    
    --========================--
    --== Temperature sensor ==--
    --========================--
    
    temperature_inst : entity work.temperature
    port map(
        temp_clk_o      => temp_clk_o,
        temp_data_io    => temp_data_io
    );
        
end Behavioral;
