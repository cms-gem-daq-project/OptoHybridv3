create_pblock pblock_trigger
resize_pblock [get_pblocks pblock_trigger] -add {CLOCKREGION_X0Y0:CLOCKREGION_X1Y2}
create_pblock pblock_control
add_cells_to_pblock [get_pblocks pblock_control] [get_cells -quiet [list control]]
resize_pblock [get_pblocks pblock_control] -add {SLICE_X48Y150:SLICE_X65Y199}
resize_pblock [get_pblocks pblock_control] -add {DSP48_X1Y60:DSP48_X1Y79}
resize_pblock [get_pblocks pblock_control] -add {RAMB18_X1Y60:RAMB18_X1Y79}
resize_pblock [get_pblocks pblock_control] -add {RAMB36_X1Y30:RAMB36_X1Y39}
create_pblock pblock_gbt
add_cells_to_pblock [get_pblocks pblock_gbt] [get_cells -quiet [list gbt]]
resize_pblock [get_pblocks pblock_gbt] -add {SLICE_X0Y150:SLICE_X21Y199}
resize_pblock [get_pblocks pblock_gbt] -add {DSP48_X0Y60:DSP48_X0Y79}
resize_pblock [get_pblocks pblock_gbt] -add {RAMB18_X0Y60:RAMB18_X0Y79}
resize_pblock [get_pblocks pblock_gbt] -add {RAMB36_X0Y30:RAMB36_X0Y39}
create_pblock pblock_ipb_switch_inst
add_cells_to_pblock [get_pblocks pblock_ipb_switch_inst] [get_cells -quiet [list ipb_switch_inst]]
resize_pblock [get_pblocks pblock_ipb_switch_inst] -add {SLICE_X22Y152:SLICE_X41Y179}
create_pblock pblock_adc_inst
add_cells_to_pblock [get_pblocks pblock_adc_inst] [get_cells -quiet [list adc_inst]]
resize_pblock [get_pblocks pblock_adc_inst] -add {SLICE_X40Y180:SLICE_X47Y199}
create_pblock pblock_clocking
add_cells_to_pblock [get_pblocks pblock_clocking] [get_cells -quiet [list clocking]]
resize_pblock [get_pblocks pblock_clocking] -add {SLICE_X24Y188:SLICE_X33Y199}
create_pblock pblock_reset_ctl
add_cells_to_pblock [get_pblocks pblock_reset_ctl] [get_cells -quiet [list reset_ctl]]
resize_pblock [get_pblocks pblock_reset_ctl] -add {SLICE_X42Y159:SLICE_X47Y169}



create_pblock pblock_cluster_packer
add_cells_to_pblock [get_pblocks pblock_cluster_packer] [get_cells -hierarchical -filter { NAME =~  "trigger/sbits/*cluster_packer*" }]
remove_cells_from_pblock [get_pblocks pblock_trigger] [get_cells -hierarchical -filter { NAME =~  "trigger/trigger_links*" }]
resize_pblock [get_pblocks pblock_cluster_packer] -add {SLICE_X0Y0:SLICE_X89Y74}
resize_pblock [get_pblocks pblock_cluster_packer] -add {DSP48_X0Y0:DSP48_X2Y29}
resize_pblock [get_pblocks pblock_cluster_packer] -add {RAMB18_X0Y0:RAMB18_X3Y29}
resize_pblock [get_pblocks pblock_cluster_packer] -add {RAMB36_X0Y0:RAMB36_X3Y14}

