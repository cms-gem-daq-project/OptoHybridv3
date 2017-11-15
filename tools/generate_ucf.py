import re
from polarity_swaps import *
from insert_code import *

def main():

    ADDRESS_FILE = '../src/ucf/misc.ucf'

    MARKER_START='#### START: AUTO GENERATED SBITS UCF -- DO NOT EDIT ####'
    MARKER_END='#### END: AUTO GENERATED SBITS UCF -- DO NOT EDIT ####'

    insert_code (ADDRESS_FILE, ADDRESS_FILE, MARKER_START, MARKER_END, write_sbit_constraints)

    MARKER_START='#### START: AUTO GENERATED RESETS UCF -- DO NOT EDIT ####'
    MARKER_END='#### END: AUTO GENERATED RESETS UCF -- DO NOT EDIT ####'

    insert_code (ADDRESS_FILE, ADDRESS_FILE, MARKER_START, MARKER_END, write_reset_constraints)

# produce a python object containing the netlist
# from altium should export netlist as  MultiWire
def parse_netlist():
    filename = 'OHv3a-SimpleNetList.NET'
    f = open(filename, 'r')

    netlist = {}

    for line in f:
        if (line[0]!='-'):

            if (len(line.split())>3):
                print "PARSING LINE FAILED: # of elements > 3"
                print line
                continue
            elif (len(line.split())<3):
                print "PARSING LINE FAILED: # of elements < 3"
                print line
                continue
            else:
                (net,part,pin) = line.split()
                if (part=='U5' and net[0]!='+' and net!='GND'):
                    netlist.update({net: pin})
                    print ("FOUND: net %s  pin %s" % (net, pin))

    return netlist

def write_reset_constraints (file_handle):

    f=file_handle

    netlist = parse_netlist()

    for net in netlist:

        # sbits

        regexp = re.compile("EXT_RESET_[0-9]*")

        if (regexp.match(net)):
            #print net + "     " + netlist.get(net)

            (ext, reset, pin) = net.split("_");

            pin = int(pin)-1 # subtract one; firmware counts from zero

            f.write('NET "ext_reset_o<%s>" LOC="%s";\n' % (pin, netlist.get(net)))

def write_sbit_constraints (file_handle):

    f=file_handle

    netlist = parse_netlist()

    for net in netlist:

        # sbits

        patp   = re.compile("S[0-9]*_[0-9]*_P")
        patn   = re.compile("S[0-9]*_[0-9]*_N")

        if (patp.match(net) or patn.match(net)):
            #print net + "     " + netlist.get(net)

            (sector, pair, pin) = net.split("_");

            sector = sector [1:] # take off the S at the beginning

            sbit_global = 8*(int(sector)-1) + int(pair) # enumerate 0--191 instead of (1--24)+(0--7)

            comment = ""
            if (sbit_polarity_swap(int(sector),int(pair))):
                comment = " # polarity swap"
                if (pin=='N'):
                    pin='P'
                elif (pin=='P'):
                    pin='N'

            f.write('NET vfat_sbits_%s<%s> LOC="%s"; %s\n' % (pin.lower(), sbit_global, netlist.get(net), comment))

        # start of transmission pulses

        patp   = re.compile("S[0-9]*CLKOUT_P")
        patn   = re.compile("S[0-9]*CLKOUT_N")
        if (patp.match(net) or patn.match(net)):

            (sector, pin) = net.split("_");
            sector = sector [1:] # take off the s at the beginning
            sector = sector [:-6]

            comment = ""
            if (sof_polarity_swap(int(sector))):
                comment = " # polarity swap"
                if (pin=='N'):
                    pin='P'
                elif (pin=='P'):
                    pin='N'

            # netlist counts sectors from 1,
            f.write('NET vfat_sof_%s<%s> LOC="%s"; %s\n' % (pin.lower(), int(sector)-1, netlist.get(net), comment))

if __name__ == '__main__':
    main()
