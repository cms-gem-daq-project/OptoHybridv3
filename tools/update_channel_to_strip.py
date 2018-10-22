from __future__ import unicode_literals
from oh_settings import *
from insert_code import *
import sys
from channel_to_strip_v3b import *
from channel_to_strip_nomap import *

MAPPING_FILE = '../src/trigger/channel_to_strip.vhd'

def main():

    MARKER_START = '-- START: SBIT_MAPPING'
    MARKER_END   = '-- END: SBIT_MAPPING'


    func = write_mapping_nomap

    if   (use_channel_to_strip_mapping and gem_version == "ge11" and hybrid_version == "v3b"):
        func = write_mapping_v3b
    elif (use_channel_to_strip_mapping and gem_version == "ge11" and hybrid_version == "v3b"):
        func = write_mapping_v3b
    else:
        func = write_mapping_nomap

    insert_code (MAPPING_FILE, MAPPING_FILE, MARKER_START, MARKER_END, func)

if __name__ == '__main__':
    main()
