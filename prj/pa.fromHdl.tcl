
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name OptoHybridv2 -dir "Z:/Documents/PhD/Code/OptoHybridv2/prj/planAhead_run_1" -part xc6vlx130tff1156-1
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "Z:/Documents/PhD/Code/OptoHybridv2/src/ucf/vfat2.ucf" [current_fileset -constrset]
set hdlfile [add_files [list {../src/packages/vfat2_pkg.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../src/system/vfat2_buffers.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../src/optohybrid_top.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set_property top optohybrid_top $srcset
add_files [list {Z:/Documents/PhD/Code/OptoHybridv2/src/ucf/vfat2.ucf}] -fileset [get_property constrset [current_run]]
add_files [list {Z:/Documents/PhD/Code/OptoHybridv2/src/ucf/flash.ucf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc6vlx130tff1156-1
