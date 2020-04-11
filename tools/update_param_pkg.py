#/usr/env python2
from __future__ import unicode_literals
from oh_settings import *
from polarity_swaps import *
from insert_code import *

ADDRESS_TABLE_TOP = '../src/pkg/param_pkg.vhd'
MARKER_START='-- START: PARAM_PKG DO NOT EDIT --'
MARKER_END="-- END: PARAM_PKG DO NOT EDIT --"


def main():

    trig_tap_delays = 0
    sot_tap_delays = 0

    insert_code (ADDRESS_TABLE_TOP, ADDRESS_TABLE_TOP, MARKER_START, MARKER_END, write_param_pkg)


def write_param_pkg (file_handle):

    f = file_handle

    ################################################################################
    # Trigger Units
    ################################################################################

    padding = "    " #spaces for indentation

    f.write ('%sconstant MAJOR_VERSION          : std_logic_vector(7 downto 0) := x"%s";\n'     %  (padding, firmware_version_major))
    f.write ('%sconstant MINOR_VERSION          : std_logic_vector(7 downto 0) := x"%s";\n'     %  (padding, firmware_version_minor))
    f.write ('%sconstant RELEASE_VERSION        : std_logic_vector(7 downto 0) := x"%s";\n'     %  (padding, firmware_release_version))
    f.write ('\n')
    f.write ('%sconstant RELEASE_YEAR           : std_logic_vector(15 downto 0) := x"%04d";\n'  %  (padding, firmware_year))
    f.write ('%sconstant RELEASE_MONTH          : std_logic_vector(7 downto  0) := x"%02d";\n'  %  (padding, firmware_month))
    f.write ('%sconstant RELEASE_DAY            : std_logic_vector(7 downto  0) := x"%02d";\n'  %  (padding, firmware_day))
    f.write ('\n')
    f.write ('%sconstant RELEASE_HARDWARE       : std_logic_vector(7 downto  0) := x"%s";\n'    %  (padding, release_hardware))
    f.write ('\n')
    f.write ('%sconstant FPGA_TYPE     : string  := "%s";\n'                                    %  (padding, fpga_type))
    f.write ('%sconstant FPGA_TYPE_IS_VIRTEX6  : integer := %d;\n'                              %  (padding, fpga_series6))
    f.write ('%sconstant FPGA_TYPE_IS_ARTIX7   : integer := %d;\n'                              %  (padding, fpga_series7))
    f.write ('\n')
    f.write ('%sconstant MXELINKS : integer := %d;\n'                                           %  (padding, mxelinks))
    f.write ('%sconstant MXLED    : integer := %d;\n'                                           %  (padding, mxleds))
    f.write ('%sconstant MXRESET  : integer := %d;\n'                                           %  (padding, mxresets))
    f.write ('%sconstant MXREADY  : integer := %d;\n'                                           %  (padding, mxready))

if __name__ == '__main__':
    main()
