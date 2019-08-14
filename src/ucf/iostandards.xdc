set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

set_property IOSTANDARD LVDS_25 [get_ports {master_slave_*}]

set_property IOSTANDARD LVDS_25 [get_ports {vfat_sbits_*}]
set_property IOSTANDARD LVDS_25 [get_ports {vfat_sot_*}]

set_property IOSTANDARD LVDS_25 [get_ports clock_p]
set_property IOSTANDARD LVDS_25 [get_ports clock_n]

set_property IOSTANDARD LVDS_25 [get_ports elink_i_p]
set_property IOSTANDARD LVDS_25 [get_ports elink_i_n]
set_property IOSTANDARD LVDS_25 [get_ports elink_o_p]
set_property IOSTANDARD LVDS_25 [get_ports elink_o_n]

set_property IOSTANDARD LVCMOS25 [get_ports {vtrx_mabs_i[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {vtrx_mabs_i[1]}]

#set_property    IOSTANDARD    LVDS_25    [get_ports TP8]
#set_property    IOSTANDARD    LVDS_25    [get_ports TP9]
#set_property    IOSTANDARD    LVDS_25    [get_ports TP10]
#set_property    IOSTANDARD    LVDS_25    [get_ports TP11]

set_property IOSTANDARD LVCMOS25 [get_ports {led_o[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports master_slave]
set_property IOSTANDARD LVCMOS25 [get_ports {gbt_rxready_i[1]}]
set_property IOSTANDARD LVCMOS25 [get_ports {gbt_rxready_i[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {gbt_rxvalid_i[1]}]
set_property IOSTANDARD LVCMOS25 [get_ports {gbt_rxvalid_i[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {gbt_txready_i[1]}]
set_property IOSTANDARD LVCMOS25 [get_ports {gbt_txready_i[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {gbt_txvalid_o[1]}]
set_property IOSTANDARD LVCMOS25 [get_ports {gbt_txvalid_o[0]}]

