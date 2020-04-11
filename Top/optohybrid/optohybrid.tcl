#vivado
############# modify these to match project ################
set bin_file 1
set use_questa_simulator 0

## FPGA and Vivado strategies and flows
set FPGA xcku15p-ffva1760-2-e
set SYNTH_STRATEGY "Flow_AreaOptimized_High" 
set SYNTH_FLOW "Vivado Synthesis 2019"
set IMPL_STRATEGY "Performance_ExplorePostRoutePhysOpt"
set IMPL_FLOW "Vivado Implementation 2019"

### Set Vivado Runs Properties ###
#
# ATTENTION: The \ character must be the last one of each line
#
# The default Vivado run names are: synth_1 for synthesis and impl_1 for implementation.
#
# To find out the exact name and value of the property, use Vivado GUI to click on the checkbox you like.
# This will make Vivado run the set_property command in the Tcl console.
# Then copy and paste the name and the values from the Vivado Tcl console into the lines below.

set PROPERTIES [dict create \
		    synth_1 [dict create \
                STEPS.SYNTH_DESIGN.ARGS.ASSERT true \
				STEPS.SYNTH_DESIGN.ARGS.KEEP_EQUIVALENT_REGISTERS true \
				STEPS.SYNTH_DESIGN.ARGS.RETIMING false \
				] \
		    impl_1 [dict create \
				STEPS.OPT_DESIGN.ARGS.DIRECTIVE Default \
				STEPS.POST_ROUTE_PHYS_OPT_DESIGN.ARGS.DIRECTIVE AggressiveExplore \
			       ]\
		   ]
############################################################


############################################################
set DESIGN    "[file rootname [file tail [info script]]]"
set path_repo "[file normalize [file dirname [info script]]]/../../"
source $path_repo/Hog/Tcl/create-project.tcl

#highlight_objects -color_index 1 [get_cells -hierarchical -filter {NAME =~ "*downlink*"}]
#highlight_objects -color_index 2 [get_cells -hierarchical -filter {NAME =~ "*uplink*"}]
#highlight_objects -color_index 3 [get_cells -hierarchical -filter {NAME =~ "*sector_logic*"}]
