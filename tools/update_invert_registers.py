from __future__ import unicode_literals
import sys

from oh_settings import *
from polarity_swaps import *
from insert_code import *

ADDRESS_TABLE_TOP = '../optohybrid_registers.xml'
MARKER_START='<!-- START: INVERT_REGS DO NOT EDIT -->'
MARKER_END="<!-- END: INVERT_REGS DO NOT EDIT -->"

def main():

    trig_tap_delays = 0
    sot_tap_delays = 0

    insert_code (ADDRESS_TABLE_TOP, ADDRESS_TABLE_TOP, MARKER_START, MARKER_END, write_xml_invert_map)

def write_xml_invert_map (file_handle):

    f = file_handle

    ################################################################################
    # SOT
    ################################################################################

    sot_default = 0
    base_address = 0x0

    for j in range (num_vfats,0,-1):

        vfat = 0
        if (USE_INVERTED_NUMBERING):
            vfat = (num_vfats-j)+1
        else:
            vfat = j

        if (sot_polarity_swap(int(vfat), oh_version, gem_version)):
            swap = 1
        else:
            swap = 0

        sot_default = sot_default | (swap << (j-1))

    sot_mask="0x00000"
    if (num_vfats==12):
        sot_mask="0x00000fff"
    if (num_vfats==24):
        sot_mask="0x00ffffff"

    padding = "                " #spaces for indentation
    f.write('%s<node id="SOT_INVERT" address="0x%x" permission="rw"\n'  % (padding, base_address))
    f.write('%s    description="1=invert pair"\n' % (padding))
    f.write('%s    fw_signal="sot_invert"\n' % (padding))
    f.write('%s    mask="%s"\n' % (padding, sot_mask))
    f.write('%s    fw_default="0x%06X"/>\n' % (padding, sot_default))

    ################################################################################
    # Trigger Units
    ################################################################################

    base_address = base_address + 1

    for vfat in range (0,num_vfats):

        geb_slot   =  0
        fw_default =  0
        sbit       = -1

        if (USE_INVERTED_NUMBERING):
            geb_slot = (num_vfats-vfat)
        else:
            geb_slot = vfat

        for pair in range (0,8):

            if (sbit_polarity_swap(geb_slot, pair, oh_version, gem_version)):
                swap = 0x1
            else:
                swap = 0x0

            if (USE_INVERTED_NUMBERING):
                sbit = 8*(vfat) + (pair) # enumerate 0--191 instead of (1--24)+(0--7)
            else:
                sbit = 8*(vfat) + (pair) # enumerate 0--191 instead of (1--24)+(0--7)

            fw_default = fw_default | (swap<<pair)

        address = base_address + vfat//4
        bitlo  = (vfat%4) * 8
        bithi  = bitlo + 7
        mask   = 0xff << (bitlo)

        bithi = bithi + 32*(vfat//4)
        bitlo = bitlo + 32*(vfat//4)

        f.write('%s<node id="VFAT%d_TU_INVERT" address="0x%x" permission="rw"\n' % (padding, vfat, address) )
        f.write('%s    description="1=invert pair"\n' % (padding))
        f.write('%s    fw_signal="TU_INVERT (%d downto %d)"\n' % (padding, bithi, bitlo))
        f.write('%s    mask="0x%08X"\n' %(padding, mask))
        f.write('%s    fw_default="0x%02X"/>\n' % (padding, fw_default))

if __name__ == '__main__':
    main()
