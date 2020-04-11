create_clock -period 10.000 -name {control/led_control/fader_cnt_reg[0]_0} -waveform {0.000 5.000} [get_pins control/led_control_inst/prescaler_reg[0]
create_clock -period 24.9 -name clock [get_ports clock_p]

set_property MAX_FANOUT 128 [get_nets trigger/ipbus_slave_inst/i_ipb_reset_sync_usr_clk/s_resync[0]]
set_property MAX_FANOUT 128 [get_nets trigger/ipbus_slave_inst/i_ipb_reset_sync_usr_clk/s_resync[1]]

set_input_delay -clock [get_clocks clock_p] 12.500 [get_ports {gbt_rxready_i[*]}]
set_input_delay -clock [get_clocks clock_p] 12.500 [get_ports {gbt_rxvalid_i[*]}]
set_input_delay -clock [get_clocks clock_p] 12.500 [get_ports {gbt_txready_i[*]}]

set_input_delay -clock [get_clocks VIRTUAL_clk160_o_logic_clocking] 1.625 [get_ports {vfat_sbits_*[*]}]
set_input_delay -clock [get_clocks VIRTUAL_clk160_o_logic_clocking] 1.625 [get_ports {vfat_sot_*[*]}]
set_input_delay -clock [get_clocks VIRTUAL_clk160_o_logic_clocking] 1.625 [get_ports elink_i_*]


set_output_delay -clock [get_clocks clock_p] -min -add_delay 0.000 [get_ports {led_o[0]}]
set_output_delay -clock [get_clocks clock_p] -max -add_delay 2.000 [get_ports {led_o[0]}]

set_output_delay -clock [get_clocks VIRTUAL_clk320_o_gbt_clocking] 1.625 [get_ports elink_o_p]

# The active clock pin of the launching sequential cell is called the path startpoint.
# The data input pin of the capturing sequential cell is called the path endpoint.
# For an input port path, the data path starts at the input port. The input port is the path startpoint.
# For an output port path, the data path ends at the output port. The output port is the path endpoint.

set_max_delay -from [get_pins -hierarchical -filter { NAME =~  "*iserdes_a7.iserdes/CLK" }] -to [get_pins -hierarchical -filter { NAME =~  "*dru/data_in_delay_reg*/D" }] 1.500
set_false_path -from [get_pins -hierarchical -filter { NAME =~  "*iserdes_a7.iserdes/CLK" }] -to [get_pins -hierarchical -filter { NAME =~  "*dru/data_in_delay_reg*/D" }]

# Want to ignore timing from the IOpad to the input delay (since there is a delay element and the clock phase is unknown, it makes no sense to constrain the timing)

set_false_path -from [get_ports {vfat_sot_*[*]}] -to [get_pins -hierarchical -filter { NAME =~  "*trig_alignment/*oversample*/*ise1*/DDLY" }]
set_false_path -from [get_ports {vfat_sbits_*[*]}] -to [get_pins -hierarchical -filter { NAME =~  "*trig_alignment/*oversample*/*ise1*/DDLY" }]
set_false_path -from [get_ports elink_i_*] -to [get_pins -hierarchical -filter { NAME =~  "*/*ise1*/DDLY" }]


# Limit fanout of reset to decongest routing
set_property MAX_FANOUT 128 [get_nets -hierarchical -filter { NAME =~  "trigger/ipbus_slave_inst/i_ipb_reset_sync_usr_clk/s_resync*" }]

set_false_path -from [get_clocks {control/led_control/fader_cnt_reg[0]_0}] -to [get_clocks -of_objects [get_pins clocking/logic_clocking/inst/plle2_adv_inst/CLKOUT0]]
set_false_path -from [get_pins {gbt/gbt_serdes/to_gbt_ser_gen_a7.i_to_gbt_ser/inst/pins[0].oserdese2_master/CLK}] -to [get_ports elink_o_p]

set_max_delay -from [get_cells trigger/tx_link_reset_reg]                                                                                                                         -to [get_cells {trigger/gem_data_out_inst/synchronizer_reset/sync_gen.gen_ff*.s_resync_reg*}]      20.0 -datapath_only
set_max_delay -from [get_cells trigger/gem_data_out_inst/a7_gtp_wrapper/a7_mgts_with_buffer0_support_i/U0/a7_mgts_with_buffer0_init_i/gt*_txresetfsm_i/tx_fsm_reset_done_int_reg] -to [get_cells {trigger/gem_data_out_inst/synchronizer_ready_sync/sync_gen.gen_ff*.s_resync_reg*}] 20.0 -datapath_only

# nothing important comes from the CFGMCLK^M
set_false_path -from [get_clocks CFGMCLK] -to [get_clocks *]
set_false_path -from [get_clocks  *     ] -to [get_clocks CFGMCLK]
