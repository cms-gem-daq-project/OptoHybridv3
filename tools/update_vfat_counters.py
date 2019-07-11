from __future__ import unicode_literals
from oh_settings import *
from insert_code import *

ADDRESS_TABLE_TOP = '../optohybrid_registers.xml'


def main():

    trig_tap_delays = 0
    sot_tap_delays = 0

    MARKER_START='<!-- START: VFAT_COUNTERS DO NOT EDIT -->'
    MARKER_END="<!-- END: VFAT_COUNTERS DO NOT EDIT -->"
    insert_code (ADDRESS_TABLE_TOP, ADDRESS_TABLE_TOP, MARKER_START, MARKER_END, write_vfat_counters)

    MARKER_START='<!-- START: OVERFLOW_COUNTERS DO NOT EDIT -->'
    MARKER_END="<!-- END: OVERFLOW_COUNTERS DO NOT EDIT -->"
    insert_code (ADDRESS_TABLE_TOP, ADDRESS_TABLE_TOP, MARKER_START, MARKER_END, write_overflow_counters)

    MARKER_START='<!-- START: VFAT_MASK DO NOT EDIT -->'
    MARKER_END="<!-- END: VFAT_MASK DO NOT EDIT -->"
    insert_code (ADDRESS_TABLE_TOP, ADDRESS_TABLE_TOP, MARKER_START, MARKER_END, write_vfat_mask)

    MARKER_START='<!-- START: SOT_READY_UNSTABLE DO NOT EDIT -->'
    MARKER_END="<!-- END: SOT_READY_UNSTABLE DO NOT EDIT -->"
    insert_code (ADDRESS_TABLE_TOP, ADDRESS_TABLE_TOP, MARKER_START, MARKER_END, write_ready_unstable)

    MARKER_START='<!-- START: ACTIVE_VFATS DO NOT EDIT -->'
    MARKER_END="<!-- END: ACTIVE_VFATS DO NOT EDIT -->"
    insert_code (ADDRESS_TABLE_TOP, ADDRESS_TABLE_TOP, MARKER_START, MARKER_END, write_active_vfats)

def write_overflow_counters (file_handle):

    f = file_handle

    ################################################################################
    # Trigger Units
    ################################################################################

    padding = "                " #spaces for indentation

    f.write('%s<node id="SBITS_OVER_64x${OVERFLOW_IDX}" address="0x1f" permission="r"\n'                %  (padding) )
    f.write('%s    mask="0x0000ffff"\n'                                                                %  (padding) )
    f.write('%s    description="More than 64 * ${OVERFLOW_IDX} Sbits in a bx Counter"\n'               %  (padding) )
    f.write('%s    fw_cnt_en_signal="sbits_comparator_over_threshold(${OVERFLOW_IDX})"\n'              %  (padding) )
    f.write('%s    fw_cnt_snap_signal="sbit_cnt_snap"\n'                                               %  (padding) )
    f.write('%s    fw_cnt_reset_signal="cnt_reset_strobed"\n'                                          %  (padding) )
    f.write('%s    fw_cnt_clk_signal="clk_40_sbit"\n'                                                  %  (padding) )
    f.write('%s    fw_signal="cnt_over_threshold${OVERFLOW_IDX}"\n'                                    %  (padding) )
    f.write('%s    generate="true"\n'                                                                  %  (padding) )
    f.write('%s    generate_size="%d"\n'                                                               %  (padding, num_vfats) )
    f.write('%s    generate_address_step="0x1"\n'                                                      %  (padding) )
    f.write('%s    generate_idx_var="OVERFLOW_IDX"/>\n'                                                %  (padding) )

def write_vfat_counters (file_handle):

    f = file_handle

    ################################################################################
    # Trigger Units
    ################################################################################

    padding = "                " #spaces for indentation

    f.write('%s<node id="VFAT${VFAT_CNT_IDX}_SBITS" address="0x0" permission="r"\n'  %  (padding) )
    f.write('%s    mask="0xffffffff"\n'                                        %  (padding) )
    f.write('%s    description="VFAT ${VFAT_CNT_IDX} Counter"\n'               %  (padding) )
    f.write('%s    fw_cnt_en_signal="active_vfats(${VFAT_CNT_IDX})"\n'         %  (padding) )
    f.write('%s    fw_cnt_snap_signal="sbit_cnt_snap"\n'                       %  (padding) )
    f.write('%s    fw_cnt_reset_signal="cnt_reset_strobed"\n'                  %  (padding) )
    f.write('%s    fw_cnt_clk_signal="clk_40_sbit"\n'                          %  (padding) )
    f.write('%s    fw_signal="cnt_vfat${VFAT_CNT_IDX}"\n'                      %  (padding) )
    f.write('%s    generate="true"\n'                                          %  (padding) )
    f.write('%s    generate_size="%d"\n'                                       %  (padding,num_vfats))
    f.write('%s    generate_address_step="0x1"\n'                              %  (padding) )
    f.write('%s    generate_idx_var="VFAT_CNT_IDX"/>\n'                        %  (padding) )

def write_vfat_mask (file_handle):

    f = file_handle

    ################################################################################
    # Trigger Units
    ################################################################################

    padding = "            " #spaces for indentation

    if (num_vfats==12):
        mask = "0xfff"
    else:
        mask = "0xffffff"

    f.write('%s<node id="VFAT_MASK" address="0x0" permission="rw"\n' % (padding))
    f.write('%s    description="%d bit mask of VFATs (1=off)"\n' % (padding, num_vfats))
    f.write('%s    mask="%s"\n' % (padding, mask))
    f.write('%s    fw_signal="vfat_mask"\n' % (padding))
    f.write('%s    fw_default="0x0"/>\n' % (padding))

def write_active_vfats (file_handle):

    if (num_vfats == 24):
        mask = "0xffffff"
    elif (num_vfats == 12):
        mask = "0xfff"
    else:
        mask = "0x0"

    f = file_handle
    padding = "            " #spaces for indentation
    f.write('%s<node id="ACTIVE_VFATS" address="0x1" permission="r"\n' % (padding))
    f.write('%s    description="%d bit list of VFATs with hits in this BX"\n' % (padding, num_vfats))
    f.write('%s    mask="%s"\n' % (padding, mask))
    f.write('%s    fw_signal="active_vfats"/>\n' % (padding))

def write_ready_unstable (file_handle):

    f = file_handle
    padding = "            " #spaces for indentation

    if (num_vfats==12):
        mask = "0xfff"
    else:
        mask = "0xffffff"

    f.write('%s<node id="SBIT_SOT_READY" address="0x3" permission="r"\n'                                                           %  (padding))
    f.write('%s    description="%d bit list of VFATs with stable Start-of-frame pulses (in sync for a number of clock cycles)"\n'  %  (padding, num_vfats))
    f.write('%s    mask="%s"\n'                                                                                                    %  (padding, mask))
    f.write('%s    fw_signal="sot_is_aligned"/>\n'                                                                                 %  (padding))

    f.write('%s<node id="SBIT_SOT_UNSTABLE" address="0x4" permission="r"\n'                                                                    %  (padding))
    f.write('%s    description="%d bit list of VFATs with unstable Start-of-frame pulses (became misaligned after already achieving lock)"\n'  %  (padding, num_vfats))
    f.write('%s    mask="%s"\n'                                                                                                                %  (padding, mask))
    f.write('%s    fw_signal="sot_unstable" />\n'                                                                                              %  (padding))

if __name__ == '__main__':
    main()
