from __future__ import unicode_literals
from oh_settings import *
from insert_code import *

ADDRESS_TABLE_TOP = '../src/trigger/trig_alignment/trig_pkg.vhd'
MARKER_START='-- START: TRIG_PKG DO NOT EDIT --'
MARKER_END="-- END: TRIG_PKG DO NOT EDIT --"


def main():

    trig_tap_delays = 0
    sot_tap_delays = 0

    insert_code (ADDRESS_TABLE_TOP, ADDRESS_TABLE_TOP, MARKER_START, MARKER_END, write_trig_pkg)


def write_trig_pkg (file_handle):

    f = file_handle

    ################################################################################
    # Trigger Units
    ################################################################################

    padding = "    " #spaces for indentation

    if (gem_version=="ge21"):
        oh_lite=1
        reverse_sbits = "000"
    else:
        oh_lite=0
        reverse_sbits = "000000"

    f.write ('\n')
    f.write('% sconstant OH_LITE : integer := %d; -- lite oh only has 12 VFATs\n'              % (padding, oh_lite))
    f.write ('\n')
    f.write('% sconstant MXVFATS : integer := %d;\n'                             % (padding, num_vfats))
    f.write ('\n')
    f.write('% sconstant REVERSE_VFAT_SBITS : std_logic_vector (%d downto 0) := x"%s";\n' % (padding, num_vfats-1, reverse_sbits))
    f.write ('\n')


if __name__ == '__main__':
    main()

