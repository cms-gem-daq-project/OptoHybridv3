from __future__ import unicode_literals
from oh_settings import *
from insert_code import *

LATEX_FILE = '../doc/latex/address_table.tex'
MARKER_START='% START: ADDRESS_TABLE_VERSION :: DO NOT EDIT'
MARKER_END='% END: ADDRESS_TABLE_VERSION :: DO NOT EDIT'

def main():

    insert_code (LATEX_FILE, LATEX_FILE, MARKER_START, MARKER_END, write_latex_version)


def write_latex_version (file_handle):

    f = file_handle

    ################################################################################
    # Trigger Units
    ################################################################################

    padding = "    " #spaces for indentation

    f.write ('%s\\author{ Firmware Version %s.%s.%s.%s \\\\ %04d%02d%02d}\n' % (padding, firmware_version_major, firmware_version_minor, firmware_release_version, release_hardware, firmware_year, firmware_month, firmware_day))

if __name__ == '__main__':
    main()
