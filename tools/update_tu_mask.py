from oh_settings import *
from polarity_swaps import *
from insert_code import *

from timing_constants_geb_v3b_short import *
from timing_constants_geb_v3a_short import *
from timing_constants_geb_v3c_long  import *

ADDRESS_TABLE_TOP = '../optohybrid_registers.xml'
MARKER_START='<!-- START: TU_MASK DO NOT EDIT -->'
MARKER_END="<!-- END: TU_MASK DO NOT EDIT -->"


def main():

    trig_tap_delays = 0
    sot_tap_delays = 0

    insert_code (ADDRESS_TABLE_TOP, ADDRESS_TABLE_TOP, MARKER_START, MARKER_END, write_tu_mask)


def write_tu_mask (file_handle):

    f = file_handle

    ################################################################################
    # Trigger Units
    ################################################################################

    padding = "            " #spaces for indentation
    base_address = 0x10

    for vfat in range (0,num_vfats):

        address = base_address + vfat//4
        bitlow  = 8*vfat + 0
        bithi   = 8*vfat + 7
        mask    = 0xff << 8*(vfat%4)

        f.write('%s<node id="VFAT%d_TU_MASK" address="0x%X" permission="rw"\n' % (padding, vfat, address))
        f.write('%s    description="8 bit mask; set a bit to 1 to mask the differential pair"\n' % (padding))
        f.write('%s    fw_signal="TU_MASK (%d downto %d)"\n' % (padding, bithi, bitlow))
        f.write('%s    mask="0x%08X"\n' % (padding, mask))
        f.write('%s    fw_default="0x0"/>\n' % (padding))

if __name__ == '__main__':
    main()
