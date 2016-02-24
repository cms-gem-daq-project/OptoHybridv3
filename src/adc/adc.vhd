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
use work.wb_pkg.all;

entity adc is
port(

    ref_clk_i       : in std_logic;
    reset_i         : in std_logic;

    -- Wishbone slave
    wb_slv_req_i    : in wb_req_t;
    wb_slv_res_o    : out wb_res_t;

    xadc_p_i        : in std_logic_vector(2 downto 0);
    xadc_n_i        : in std_logic_vector(2 downto 0)
    
);
end adc;

architecture Behavioral of adc is  
begin

    sysmon_wiz_v2_1_inst : entity work.sysmon_wiz_v2_1
    port map( 
        daddr_in    => wb_slv_req_i.addr(6 downto 0), 
        dclk_in     => ref_clk_i, 
        den_in      => wb_slv_req_i.stb, 
        di_in       => wb_slv_req_i.data(15 downto 0),
        dwe_in      => wb_slv_req_i.we, 
        reset_in    => reset_i, 
        vauxp4      => xadc_p_i(1),
        vauxn4      => xadc_n_i(1),
        vauxp5      => xadc_p_i(2),
        vauxn5      => xadc_n_i(2),
        busy_out    => open,
        channel_out => open,
        do_out      => wb_slv_res_o.data(15 downto 0),
        drdy_out    => wb_slv_res_o.ack,
        eoc_out     => open,
        eos_out     => open,
        vp_in       => xadc_p_i(0), 
        vn_in       => xadc_n_i(0)
    );
    
    wb_slv_res_o.stat <= WB_NO_ERR;

end Behavioral;