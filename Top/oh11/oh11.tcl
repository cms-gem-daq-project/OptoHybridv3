#planahead
############# modify these to match project ################
set bin_file 1
set use_questa_simulator 0

#set FPGA xc7a75tfgg484-3
set FPGA xc6vlx130tff1156-1

## FPGA and Vivado strategies and flows
#regexp -- {Vivado v([0-9]{4})\.[0-9]} [version] -> VIVADO_YEAR
set SYNTH_FLOW "XST 14"
set SYNTH_STRATEGY "PlanAhead Defaults"
set IMPL_FLOW "ISE 14"
set IMPL_STRATEGY "ISE Defaults"

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
        steps.xst.args.equivalent_register_removal no \
    ] \
]

#                                 STEPS.SYNTH_DESIGN.ARGS.KEEP_EQUIVALENT_REGISTERS true \
#                                 STEPS.SYNTH_DESIGN.ARGS.RETIMING false \
#                    impl_1 [dict create \
#                                STEPS.OPT_DESIGN.ARGS.DIRECTIVE Default \
#                                STEPS.POST_ROUTE_PHYS_OPT_DESIGN.ARGS.DIRECTIVE AggressiveExplore \
#                               ]\
#                   ]

############################################################

set DESIGN    "[file rootname [file tail [info script]]]"
set PATH_REPO "[file normalize [file dirname [info script]]]/../../"

source $PATH_REPO/Hog/Tcl/create_project.tcl
