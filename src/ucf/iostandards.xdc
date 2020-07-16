set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

set_property IOSTANDARD LVDS_25 [get_ports {master_slave_*}]
set_property IOSTANDARD LVDS_25 [get_ports {vfat_*}]
set_property IOSTANDARD LVDS_25 [get_ports {clock_*}]
set_property IOSTANDARD LVDS_25 [get_ports {elink_*}]
set_property IOSTANDARD LVDS_25 [get_ports {gbt_trig*}]

set_property IOSTANDARD LVCMOS25 [get_ports {vtrx_mabs_i*}]

#set_property    IOSTANDARD    LVDS_25    [get_ports TP8]
#set_property    IOSTANDARD    LVDS_25    [get_ports TP9]
#set_property    IOSTANDARD    LVDS_25    [get_ports TP10]
#set_property    IOSTANDARD    LVDS_25    [get_ports TP11]

set_property IOSTANDARD LVCMOS25 [get_ports {led_o[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports master_slave]
set_property IOSTANDARD LVCMOS25 [get_ports {gbt_rx*}]
set_property IOSTANDARD LVCMOS25 [get_ports {gbt_tx*}]
