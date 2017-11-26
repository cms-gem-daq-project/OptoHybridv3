import re
from polarity_swaps import *
from insert_code import *
from oh_settings import *

def main():

    ADDRESS_FILE = '../src/trigger/trig_alignment/trig_pkg.vhd'

    MARKER_START='---- START: AUTO GENERATED POLARITY SWAPS -- DO NOT EDIT ----'
    MARKER_END='---- END: AUTO GENERATED POLARITY SWAPS -- DO NOT EDIT ----'

    insert_code (ADDRESS_FILE, ADDRESS_FILE, MARKER_START, MARKER_END, write_invert_map)


    # do the same for the optohybrid test bench;

    ADDRESS_FILE = '../src/optohybrid_tb.v'

    MARKER_START='//-- START: AUTO GENERATED POLARITY SWAPS -- DO NOT EDIT --//'
    MARKER_END='//-- END: AUTO GENERATED POLARITY SWAPS -- DO NOT EDIT --//'

    insert_code (ADDRESS_FILE, ADDRESS_FILE, MARKER_START, MARKER_END, write_invert_map_verilog)

def write_invert_map_verilog  (file_handle):

    # sbits

    f = file_handle

    f.write('  initial SOT_INVERT  = {\n')

    for j in range (24,0,-1):
        if (sof_polarity_swap(int(j))):
            swap = '1'
        else:
            swap = '0'

        if (j==1):
            sep = ' '
        else:
            sep = ','

        f.write('    1\'b%s %s // SOT_INVERT[%s]\n' % (swap, sep, j-1))

    f.write('\n')
    f.write('  initial TU_INVERT = {\n')

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

            f.write('    1\'b%s %s // TU_INVERT[%s] (VFAT=%s BIT=%s)\n' % (swap, sep, str(8*(sector-1)+pair-1), sector-1, pair-1 ))

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

        f.write('    \'%s\' %s -- SOT_INVERT[%s]\n' % (swap, sep, j-1))

    f.write('\n')
    f.write('  constant TU_INVERT  : std_logic_vector (191 downto 0) :=\n')

    for sector in range (24,0,-1): # counts 24 to 1
        for pair   in range (8,0,-1): # counts 8 to 1

            if (sbit_polarity_swap(int(sector),int(pair-1))):
                swap = '1'
            else:
                swap = '0'

            if (sector==1 and pair==1):
                sep = ';'
            else:
                sep = '&'

            sbit=-1
            vfat=-1

            if (USE_INVERTED_NUMBERING):
                vfat = 23-(sector-1)
                sbit = 8*(vfat) + (pair-1)# enumerate 0--191 instead of (1--24)+(0--7)
            else:
                vfat = sector-1
                sbit = 8*(vfat) + (pair-1) # enumerate 0--191 instead of (1--24)+(0--7)


            f.write('    \'%s\' %s -- TU_INVERT[%s] (VFAT=%s BIT=%s)\n' % (swap, sep, sbit, sector-1, pair-1 ))

if __name__ == '__main__':
    main()
