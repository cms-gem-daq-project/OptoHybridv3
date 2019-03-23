set shortname  "OH"
set top_name   "optohybrid_top"
set myProject  "OptoHybrid_v3"
set prom_type  "XCF128X"

set myScript   "genproms.tcl"

set folder [lindex [split [pwd] /] end]
if { $folder != "tools" } {
    puts "This script needs to be executed from tools directory"
    return
} else {
    cd ../
}

set pdf_filename        doc/latex/address_table.pdf
set xml_filename        optohybrid_registers.xml
set bit_filename        prj/${top_name}.bit
set ltx_filename        vivado/oh_lite.runs/impl_1/optohybrid_top.ltx
set bit_filename_vivado vivado/oh_lite.runs/impl_1/optohybrid_top.bit
set mcs_filename        prj/${top_name}.mcs
set cfi_filename        prj/${top_name}.cfi
set cdc_filename        src/chipscope_ila.cdc
set prm_filename        prj/${top_name}.prm
set svf_verify          prj/${top_name}_verify.svf
set svf_noverify        prj/${top_name}_noverify.svf
set impact_script       prj/${top_name}.impactscript
set version_file        src/pkg/param_pkg.vhd
set project_dir         [pwd]/prj

set  MAJOR_VERSION "XX"
set  MINOR_VERSION "XX"
set  RELEASE_VERSION "XX"

set  RELEASE_YEAR "XXXX"
set  RELEASE_MONTH "XX"
set  RELEASE_DAY "XX"
set  RELEASE_HARDWARE "XX"
set  FIRMWARE_IS_GE21 0


# optohybrid version extracting
set filename ${version_file}

set fid [open $filename r]
while {[gets $fid line] != -1} {

    if { [ regexp -all -- MAJOR_VERSION $line] } {
        regexp {x\"[0-9]*\"} $line vhdl_hex
        regexp {[0-9]{2}} $vhdl_hex MAJOR_VERSION
        if { [string range ${MAJOR_VERSION} 0 0] == "0" } {
            set MAJOR_VERSION [string range ${MAJOR_VERSION} 1 1]
        }
    }

    if { [ regexp -all -- MINOR_VERSION $line] } {
        regexp {x\"[0-9]*\"} $line vhdl_hex
        regexp {[0-9]{2}} $vhdl_hex MINOR_VERSION
        if { [string range ${MINOR_VERSION} 0 0] == "0" } {
            set MINOR_VERSION [string range ${MINOR_VERSION} 1 1]
        }
    }

    if { [ regexp -all -- RELEASE_VERSION $line] } {
        regexp {x\"[0-9]*\"} $line vhdl_hex
        regexp {[0-9]{2}} $vhdl_hex RELEASE_VERSION
        if { [string range ${RELEASE_VERSION} 0 0] == "0" } {
            set RELEASE_VERSION [string range ${RELEASE_VERSION} 1 1]
        } }

    if { [ regexp -all -- RELEASE_YEAR $line] } {
        regexp {x\"[0-9]*\"} $line vhdl_hex
        regexp {[0-9]{4}} $vhdl_hex RELEASE_YEAR
    }

    if { [ regexp -all -- RELEASE_MONTH $line] } {
        regexp {x\"[0-9]*\"} $line vhdl_hex
        regexp {[0-9]{2}} $vhdl_hex RELEASE_MONTH
    }

    if { [ regexp -all -- RELEASE_DAY $line] } {
        regexp {x\"[0-9]*\"} $line vhdl_hex
        regexp {[0-9]{2}} $vhdl_hex RELEASE_DAY
    }

    if { [ regexp -all -- RELEASE_HARDWARE $line] } {
        regexp {x\"[0-9a-fA-F]+\"} $line vhdl_hex
        regexp {[0-9a-fA-F]+} $vhdl_hex RELEASE_HARDWARE
        if { [string range ${RELEASE_HARDWARE} 0 0] == "0" } {
            set RELEASE_HARDWARE [string range ${RELEASE_HARDWARE} 1 1]
        }
    }

}
close $fid

set datecode ${RELEASE_YEAR}${RELEASE_MONTH}${RELEASE_DAY}
set releasecode ${MAJOR_VERSION}.${MINOR_VERSION}.${RELEASE_VERSION}.${RELEASE_HARDWARE}


puts $datecode
puts $releasecode

if { [string compare $RELEASE_HARDWARE "2A"] == 0 } {
    set FIRMWARE_IS_GE21 1
    puts "Firmware is GE21"
}

if { $FIRMWARE_IS_GE21 == 0 } {
    puts "Generating PROM files for firmware version $datecode"

    ## put out a 'heartbeat' - so we know something's happening.
    puts "\n$myScript: running ($myProject)...\n"

    ################################################################################
    # synthesis
    ################################################################################

    # put out a 'heartbeat' - so we know something's happening.
    #puts "\n$myScript: running ($myProject)...\n"
    #
    #if { ! [ open_project ] } {
    #    return false
    #}

    #set_process_props
    #
    # Remove the comment characters (#'s) to enable the following commands
    #process run "Synthesize"
    #process run "Translate"
    #process run "Map"
    #process run "Place & Route"
    ##
    #set task "Implement Design"
    #if { ! [run_task $task] } {
    #    puts "$myScript: $task run failed, check run output for details."
    #    project close
    #    return
    #}
    #
    #set task "Generate Programming File"
    #if { ! [run_task $task] } {
    #    puts "$myScript: $task run failed, check run output for details."
    #    project close
    #    return
    #}

    #puts [exec xst -intstyle ise -ifn ${top_name}.xst -ofn ${top_name}.syr]
    #puts [exec ngdbuild -intstyle ise -dd _ngo -sd ../src/ip_cores -nt timestamp -uc ../src/gtx/gtx_attributes.ucf -uc ../src/ucf/vfat2.ucf -uc ../misc.ucf -uc ../src/ucf/memory.ucf -uc ../src/ucf/clocking.ucf -uc ../src/ucf/gtx.ucf -p xc6vlx130t-ff1156-1 ${top_name}.ngc ${top_name}.ngd]
    #puts [exec map -intstyle ise -p xc6vlx130t-ff1156-1 -w -logic_opt off -ol high -t 1 -xt 0 -register_duplication off -r 4 -global_opt off -mt off -ir off -pr off -lc off -power off -o ${top_name}_map.ncd ${top_name}.ngd ${top_name}.pcf]
    #puts [exec par -w -intstyle ise -ol high -mt off ${top_name}_map.ncd ${top_name}.ncd ${top_name}.pcf ]
    #puts [exec trce -intstyle ise -v 3 -s 1 -n 3 -fastpaths -xml ${top_name}.twx ${top_name}.ncd -o ${top_name}.twr ${top_name}.pcf]
    #puts [exec bitgen -intstyle ise -f ${top_name}.ut ${top_name}.ncd]


    ################################################################################
    puts "Generating mcs file..."
    ################################################################################

    if {[catch {set f_id [open $impact_script w]} msg]} {
        puts "Can't create $impact_script"
        puts $msg
        return
    }

    puts "Opened impact script for writing..."

    puts $f_id "setMode -pff"
    puts $f_id "setMode -pff"

    puts $f_id "addConfigDevice  -name \"${top_name}\" -path \"$project_dir\""
    puts $f_id "setSubmode -pffbpi"
    puts $f_id "setAttribute -configdevice -attr multibootBpiType -value \"TYPE_BPI\""
    puts $f_id "setAttribute -configdevice -attr multibootBpiDevice -value \"VIRTEX6\""
    puts $f_id "setAttribute -configdevice -attr multibootBpichainType -value \"PARALLEL\""
    puts $f_id "addDesign -version 0 -name \"0\""
    puts $f_id "setMode -pff"
    puts $f_id "addDeviceChain -index 0"
    puts $f_id "setMode -pff"
    puts $f_id "addDeviceChain -index 0"
    puts $f_id "setAttribute -configdevice -attr compressed -value \"FALSE\""
    puts $f_id "setAttribute -configdevice -attr compressed -value \"FALSE\""
    puts $f_id "setAttribute -configdevice -attr autoSize -value \"FALSE\""
    puts $f_id "setAttribute -configdevice -attr fileFormat -value \"mcs\""
    puts $f_id "setAttribute -configdevice -attr fillValue -value \"FF\""
    puts $f_id "setAttribute -configdevice -attr swapBit -value \"FALSE\""
    puts $f_id "setAttribute -configdevice -attr dir -value \"UP\""
    puts $f_id "setAttribute -configdevice -attr multiboot -value \"FALSE\""
    puts $f_id "setAttribute -configdevice -attr multiboot -value \"FALSE\""
    puts $f_id "setAttribute -configdevice -attr spiSelected -value \"FALSE\""
    puts $f_id "setAttribute -configdevice -attr spiSelected -value \"FALSE\""
    puts $f_id "setAttribute -configdevice -attr ironhorsename -value \"1\""
    puts $f_id "setAttribute -configdevice -attr flashDataWidth -value \"16\""
    puts $f_id "setCurrentDesign -version 0"
    puts $f_id "setAttribute -design -attr RSPin -value \"\""
    puts $f_id "setCurrentDesign -version 0"
    puts $f_id "addPromDevice -p 1 -size 131072 -name 128M"
    puts $f_id "setMode -pff"
    puts $f_id "setMode -pff"
    puts $f_id "setMode -pff"
    puts $f_id "setMode -pff"
    puts $f_id "addDeviceChain -index 0"
    puts $f_id "setMode -pff"
    puts $f_id "addDeviceChain -index 0"
    puts $f_id "setMode -pff"
    puts $f_id "setSubmode -pffbpi"
    puts $f_id "setMode -pff"

    puts $f_id "setAttribute -design -attr RSPin -value \"00\""
    puts $f_id "addDevice -p 1 -file \"${bit_filename}\""
    puts $f_id "setAttribute -design -attr RSPinMsb -value \"1\""
    puts $f_id "setAttribute -design -attr name -value \"0\""
    puts $f_id "setAttribute -design -attr RSPin -value \"00\""
    puts $f_id "setAttribute -design -attr endAddress -value \"53638b\""
    puts $f_id "setAttribute -design -attr endAddress -value \"53638b\""
    puts $f_id "setMode -pff"
    puts $f_id "setSubmode -pffbpi"
    puts $f_id "generate"

    ################################################################################
    # Build SVF Files
    ################################################################################


    puts $f_id "setCurrentDesign -version 0"
    puts $f_id "setMode -bs"
    puts $f_id "setMode -bs"
    puts $f_id "setMode -bs"
    puts $f_id "setMode -bs"

    puts $f_id "setCable -port svf -file \"${svf_verify}\""
    puts $f_id "addDevice -p 1 -file \"$bit_filename\""
    puts $f_id "attachflash -position 1 -bpi $prom_type"
    puts $f_id "assignfiletoattachedflash -position 1 -file \"$mcs_filename\""

    puts $f_id "Program -p 1 -dataWidth 16 -rs1 NONE -rs0 NONE -bpionly -e -v -loadfpga "

    puts $f_id "setCable -port svf -file \"$svf_noverify\""
    puts $f_id "Program -p 1 -bpionly -e -loadfpga "

    ################################################################################
    puts $f_id "quit"
    ################################################################################

    close $f_id

    puts "Finished writing impact script..."

    set impact_p [open "|impact -batch $impact_script" r]
    #puts [exec impact -batch "${impact_script}"]


    # echo impact output here:
    while {![eof $impact_p]} { gets $impact_p line ; puts $line }

    puts "Finished Creating PROM Files"

    # adapted from https://forums.xilinx.com/t5/Vivado-TCL-Community/Vivado-TCL-set-generics-based-on-date-git-hash/td-p/426838

    # Current date, time, and seconds since epoch
    # 0 = 4-digit year
    # 1 = 2-digit year
    # 2 = 2-digit month
    # 3 = 2-digit day
    # 4 = 2-digit hour
    # 5 = 2-digit minute
    # 6 = 2-digit second
    # 7 = Epoch (seconds since 1970-01-01_00:00:00)
    # Array index                                            0  1  2  3  4  5  6  7
    #set datetime_arr [clock format [clock seconds] -format {%Y %y %m %d %H %M %S %s}]

    # Get the datecode in the yyyy-mm-dd format
    #set datecode [lindex $datetime_arr 0]-[lindex $datetime_arr 2]-[lindex $datetime_arr 3]

    # Show this in the log
    #puts DATECODE=$datecode

    # Get the git hashtag for this project
    #set curr_dir [pwd]
    #set proj_dir [get_property DIRECTORY [current_project]]
    #cd $proj_dir
    #set git_hash [exec git log -1 --pretty='%h']
    # Show this in the log
    #puts HASHCODE=$git_hash

    # Set the generics
    #set_property generic "DATE_CODE=32'h$datecode HASH_CODE=32'h$git_hash" [current_fileset]
}



set releasedir     release/${shortname}_${releasecode}

if {![file isdirectory release]} {
    file mkdir release
}

if {![file isdirectory $releasedir]} {
    file mkdir $releasedir
}


file copy -force $xml_filename   ${releasedir}/oh_registers_${releasecode}.xml
file copy -force $pdf_filename   ${releasedir}/oh_registers_${releasecode}.pdf
if { $FIRMWARE_IS_GE21 == 0 } {
    #file copy -force $svf_verify     ${releasedir}/${shortname}_${releasecode}_verify.svf
    #file copy -force $svf_noverify   ${releasedir}/${shortname}_${releasecode}_noverify.svf
    file copy -force $mcs_filename   ${releasedir}/${shortname}_${releasecode}.mcs
    file copy -force $prm_filename   ${releasedir}/${shortname}_${releasecode}.prm
    file copy -force $cfi_filename   ${releasedir}/${shortname}_${releasecode}.cfi
    file copy -force $cdc_filename   ${releasedir}/${shortname}_${releasecode}.cdc
    file copy -force $bit_filename   ${releasedir}/${shortname}_${releasecode}.bit
} else {
    file copy -force $bit_filename_vivado   ${releasedir}/${shortname}_${releasecode}.bit
    file copy -force $ltx_filename          ${releasedir}/${shortname}_${releasecode}.ltx

}
