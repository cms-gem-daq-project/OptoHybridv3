#/usr/env python2
from __future__ import unicode_literals
from oh_settings import *
from insert_code import *

LATEX_FILE = '../doc/latex/address_table.tex'

def main():

    MARKER_START='% START: ADDRESS_TABLE_VERSION :: DO NOT EDIT'
    MARKER_END='% END: ADDRESS_TABLE_VERSION :: DO NOT EDIT'
    outfile = LATEX_FILE.replace(".tex",file_suffix+".tex")
    insert_code (outfile, outfile, MARKER_START, MARKER_END, write_latex_version)

    MARKER_START='# START: ADDRESS_TABLE_VERSION :: DO NOT EDIT'
    MARKER_END='# END: ADDRESS_TABLE_VERSION :: DO NOT EDIT'
    outfile = LATEX_FILE.replace(".tex",file_suffix+".org")
    insert_code (outfile, outfile, MARKER_START, MARKER_END, write_org_version)

def write_org_version (file_handle):

    f = file_handle

    chamber_type = ""

    if (gem_version=="ge21"):
        chamber_type = "GE2/1"
    elif (gem_version=="ge11"):
        if (geb_length=="long"):
            chamber_type = "GE1/1 Long"
        if (geb_length=="short"):
            chamber_type = "GE1/1 Short"

    ################################################################################
    # Trigger Units
    ################################################################################

    f.write ('#+TITLE: Address Table %s\n\n' % (chamber_type))
    f.write ('** v%02x.%02x.%02x.%s\n\n' % (firmware_version_major, firmware_version_minor, firmware_release_version, release_hardware))
    f.write ('** %04d/%02d/%02d\n\n' % (firmware_year, firmware_month, firmware_day))


def write_latex_version (file_handle):

    f = file_handle

    chamber_type = ""

    if (gem_version=="ge21"):
        chamber_type = "GE2/1"
    elif (gem_version=="ge11"):
        if (geb_length=="long"):
            chamber_type = "GE1/1 Long"
        if (geb_length=="short"):
            chamber_type = "GE1/1 Short"


    ################################################################################
    # Trigger Units
    ################################################################################

    padding = "    " #spaces for indentation

    f.write ('%s\\author{\\textbf{%s} \\\\  \\\\ v%02x.%02x.%02x.%s \\\\ %04d%02d%02d}\n' % (padding, chamber_type, firmware_version_major, firmware_version_minor, firmware_release_version, release_hardware, firmware_year, firmware_month, firmware_day))

if __name__ == '__main__':
    main()
