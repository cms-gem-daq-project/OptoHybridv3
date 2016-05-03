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
    
    --==========--
    --== QPLL ==--
    --==========--

    --== QPLL raw ==--

    qpll_clk_p_i            : in std_logic;
    qpll_clk_n_i            : in std_logic;
    qpll_reset_o            : out std_logic;    
    qpll_locked_i           : in std_logic;    
        
    --== QPLL buffered ==--
    
    qpll_clk_o              : out std_logic;
    qpll_reset_i            : in std_logic;    
    qpll_locked_o           : out std_logic
    
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
    
    --==================--
    --== QPLL buffers ==--
    --==================--
    
    qpll_buffers_inst : entity work.qpll_buffers
    port map(
        -- Raw
        qpll_clk_p_i    => qpll_clk_p_i,
        qpll_clk_n_i    => qpll_clk_n_i,
        qpll_reset_o    => qpll_reset_o,    
        qpll_locked_i   => qpll_locked_i,  
        -- Buffered
        qpll_clk_o      => qpll_clk_o,
        qpll_reset_i    => qpll_reset_i,  
        qpll_locked_o   => qpll_locked_o    
    );

end Behavioral;

