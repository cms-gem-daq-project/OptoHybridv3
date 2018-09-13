from oh_settings import *
from insert_code import *



def main():

    SRC_FILE = '../src/sbit_cluster_packer/source/cluster_packer.v'

    MARKER_START='// START: CLUSTER_PACKER_SETTINGS DO NOT EDIT --'
    MARKER_END='// END: CLUSTER_PACKER_SETTINGS DO NOT EDIT --'

    insert_code (SRC_FILE, SRC_FILE, MARKER_START, MARKER_END, write_cluster_packer)

    SRC_FILE = '../src/sbit_cluster_packer/source/first8of1536.v'

    MARKER_START='// START: FIRST8_SETTINGS DO NOT EDIT --'
    MARKER_END='// END: FIRST8_SETTINGS DO NOT EDIT --'

    insert_code (SRC_FILE, SRC_FILE, MARKER_START, MARKER_END, write_first8)


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

def write_first8 (file_handle):

    f = file_handle

    ################################################################################
    # Trigger Units
    ################################################################################

    padding = "" #spaces for indentation

    if (gem_version=="ge21"):
        f.write ('%s`define first4\n'                                           %  (padding))

    else:
        f.write ('%s//`define first4\n'                                         %  (padding))

if __name__ == '__main__':
    main()
