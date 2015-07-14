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

entity adc is
port(

    --== ADC raw ==--
    
    adc_clk_o           : out std_logic;
    adc_chip_select_o   : out std_logic;
    adc_dout_o          : out std_logic;
    
    adc_din_i           : in std_logic;
    adc_eoc_i           : in std_logic;
    
    --== ADC packed ==--
    
    wb_req_i            : in wb_req_t;
    wb_res_o            : in wb_res_t

);
end adc;

architecture Behavioral of adc is

    signal adc_clk          : std_logic;
    signal adc_chip_select  : std_logic;
    signal adc_dout         : std_logic;
    signal adc_din          : std_logic;
    signal adc_eoc          : std_logic;

begin

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
        adc_clk_i           => adc_clk,
        adc_chip_select_i   => adc_chip_select,
        adc_dout_i          => adc_dout,
        adc_din_o           => adc_din,
        adc_eoc_o           => adc_eoc
    );

end Behavioral;

