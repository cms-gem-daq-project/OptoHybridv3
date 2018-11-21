from oh_settings import *
from insert_code import *

ADDRESS_TABLE_TOP = '../src/sbit_cluster_packer/source/cluster_packer.v'

MARKER_START='// START: CLUSTER_PACKER_SETTINGS DO NOT EDIT --'
MARKER_END='// END: CLUSTER_PACKER_SETTINGS DO NOT EDIT --'


def main():

    insert_code (ADDRESS_TABLE_TOP, ADDRESS_TABLE_TOP, MARKER_START, MARKER_END, write_cluster_packer)


def write_cluster_packer (file_handle):

    f = file_handle

    ################################################################################
    # Trigger Units
    ################################################################################

    padding = "" #spaces for indentation

    if (gem_version=="ge21"):
        f.write ('%s`define oh_lite\n'                                           %  (padding))
    else:
        f.write ('%s//`define oh_lite\n'                                         %  (padding))

if __name__ == '__main__':
    main()
