import re
from polarity_swaps import *
from insert_code import *

def main():

    ADDRESS_FILE = '../src/trigger/trig_alignment/trig_pkg.vhd'

    MARKER_START='---- START: AUTO GENERATED POLARITY SWAPS -- DO NOT EDIT ----'
    MARKER_END='---- END: AUTO GENERATED POLARITY SWAPS -- DO NOT EDIT ----'

    insert_code (ADDRESS_FILE, ADDRESS_FILE, MARKER_START, MARKER_END, write_invert_map)

def write_invert_map  (file_handle):

    # sbits

    f = file_handle

    f.write('  constant  SOT_INVERT  : std_logic_vector (23 downto 0) :=\n')

    for j in range (24,0,-1):
        if (sof_polarity_swap(int(j))):
            swap = '1'
        else:
            swap = '0'

        if (j==1):
            sep = ';'
        else:
            sep = '&'

        f.write('    \'%s\' %s -- SOF_INVERT[%s]\n' % (swap, sep, j-1))

    f.write('\n')
    f.write('  constant TU_INVERT  : std_logic_vector (191 downto 0) :=\n')

    for sector in range (24,0,-1):
        for pair   in range (8,0,-1):

            if (sbit_polarity_swap(int(sector),int(pair-1))):
                swap = '1'
            else:
                swap = '0'

            if (sector==1 and pair==1):
                sep = ';'
            else:
                sep = '&'

            f.write('    \'%s\' %s -- TU_INVERT[%s] (VFAT=%s BIT=%s)\n' % (swap, sep, str(8*(sector-1)+pair-1), sector-1, pair-1 ))

if __name__ == '__main__':
    main()
