----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    08:37:20 07/07/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    adc_buffers - Behavioral 
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

entity adc_buffers is
port(
    
    --== ADC raw ==--
    
    adc_clk_o           : out std_logic;
    adc_chip_select_o   : out std_logic;
    adc_dout_o          : out std_logic;
    
    adc_din_i           : in std_logic;
    adc_eoc_i           : in std_logic;
    
    --== ADC buffered ==--
    
    adc_clk_i           : in std_logic;
    adc_chip_select_i   : in std_logic;
    adc_dout_i          : in std_logic;
    
    adc_din_o           : out std_logic;
    adc_eoc_o           : out std_logic
    
);
end adc_buffers;

architecture Behavioral of adc_buffers is
begin

    -- adc_clk

    adc_clk_obuf : obuf
    generic map(
        drive       => 12,
        iostandard  => "lvcmos25",
        slew        => "fast"
    )
    port map(
        i           => adc_clk_i,
        o           => adc_clk_o
    );
    
    -- adc_din
    
    adc_din_ibuf : ibuf
    generic map(
        ibuf_low_pwr    => true,
        iostandard      => "lvcmos25"
    )
    port map(
        i               => adc_din_i,
        o               => adc_din_o
    );
    
    -- adc_eoc
    
    adc_eoc_ibuf : ibuf
    generic map(
        ibuf_low_pwr    => true,
        iostandard      => "lvcmos25"
    )
    port map(
        i               => adc_eoc_i,
        o               => adc_eoc_o
    );
    
    -- adc_chip_select

    adc_chip_select_obuf : obuf
    generic map(
        drive       => 12,
        iostandard  => "lvcmos25",
        slew        => "slow"
    )
    port map(
        i           => adc_chip_select_i,
        o           => adc_chip_select_o
    );
    
    -- adc_dout
    
    adc_dout_obuf : obuf
    generic map(
        drive       => 12,
        iostandard  => "lvcmos25",
        slew        => "slow"
    )
    port map(
        i           => adc_dout_i,
        o           => adc_dout_o
    );
    
end Behavioral;

