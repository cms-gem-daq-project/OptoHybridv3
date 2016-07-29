# file: simcmds.tcl

# create the simulation script
vcd dumpfile isim.vcd
vcd dumpvars -m /sysmon_wiz_v2_1_tb -l 0
wave add /
run 120000000ns
quit

