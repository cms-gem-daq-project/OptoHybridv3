#/usr/env python2
from __future__ import unicode_literals
from oh_settings import *
from insert_code import *



def main():

    SRC_FILE = '../src/sbit_cluster_packer/source/constants.v'

    MARKER_START='// START: CLUSTER_PACKER_SETTINGS DO NOT EDIT --'
    MARKER_END='// END: CLUSTER_PACKER_SETTINGS DO NOT EDIT --'

    insert_code (SRC_FILE, SRC_FILE, MARKER_START, MARKER_END, write_cluster_packer)


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

    if (ge11_full_cluster_builder):
        f.write ('%s`define full_chamber_finder\n'                               %  (padding))
    else:
        f.write ('%s//`define full_chamber_finder\n'                             %  (padding))

    if (gem_version=="ge21"):
        if (ge21_five_cluster==True):
            f.write ('%s`define first5\n'                                           %  (padding))
        else:
            f.write ('%s`define first4\n'                                           %  (padding))

    elif (ge11_full_cluster_builder == True):
        f.write ('%s`define first16\n'                                            %  (padding))

    else:
        f.write ('%s`define first8\n'                                             %  (padding))

if __name__ == '__main__':
    main()
