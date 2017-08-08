----------------------------------------------------------------------------------
-- CMS Muon Endcap
-- GEM Collaboration
-- Optohybrid v3 Firmware -- System Monitor
-- T. Lenzi, A. Peck
----------------------------------------------------------------------------------
-- 2017/08/08 -- Remove auxillary inputs, add alarms
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

    -- Analog input
    adc_vp         : in  std_logic;
    adc_vn         : in  std_logic;

    -- Outputs
    overtemp_o     : out std_logic;
    vccaux_alarm_o : out std_logic;
    vccint_alarm_o : out std_logic

);
end adc;

architecture Behavioral of adc is
begin

    xadc_inst : entity work.xadc
    port map(
        daddr_in         => wb_slv_req_i.addr(6 downto 0),
        dclk_in          => ref_clk_i,
        den_in           => wb_slv_req_i.stb,
        di_in            => wb_slv_req_i.data(15 downto 0),
        dwe_in           => wb_slv_req_i.we,
        reset_in         => reset_i,
        busy_out         => open,
        channel_out      => open,
        do_out           => wb_slv_res_o.data(15 downto 0),
        drdy_out         => wb_slv_res_o.ack,
        eoc_out          => open,
        eos_out          => open,
        vp_in            => adc_vp,
        vn_in            => adc_vn,
        ot_out           => overtemp_o,
        vccaux_alarm_out => vccaux_alarm_o,
        vccint_alarm_out => vccint_alarm_o
    );

    wb_slv_res_o.stat <= WB_NO_ERR;

end Behavioral;
