
# PlanAhead Launch Script for Post-Synthesis floorplanning, created by Project Navigator

create_project -name OptoHybridv2 -dir "Z:/Documents/PhD/Code/OptoHybridv2/prj/planAhead_run_1" -part xc6vlx130tff1156-1
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "Z:/Documents/PhD/Code/OptoHybridv2/prj/optohybrid_top.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {Z:/Documents/PhD/Code/OptoHybridv2/prj} {../vendors/gbt-fpga/tags/gbt_fpga_3_1_0/gbt_bank/xilinx_v6/gbt_rx/rx_dpram} {../vendors/gbt-fpga/tags/gbt_fpga_3_1_0/gbt_bank/xilinx_v6/gbt_tx/tx_dpram} }
set_property target_constrs_file "Z:/Documents/PhD/Code/OptoHybridv2/src/ucf/vfat2s.ucf" [current_fileset -constrset]
add_files [list {Z:/Documents/PhD/Code/OptoHybridv2/src/ucf/vfat2s.ucf}] -fileset [get_property constrset [current_run]]
link_design
