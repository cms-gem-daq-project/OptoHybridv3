#/usr/env python2
import re
from polarity_swaps import *
from insert_code import *
from oh_settings import *

hw_version="v3b"


def main():

    ADDRESS_FILE = '../src/ucf/misc_v3b.ucf'

    MARKER_START='#### START: AUTO GENERATED SBITS UCF -- DO NOT EDIT ####'
    MARKER_END='#### END: AUTO GENERATED SBITS UCF -- DO NOT EDIT ####'

    insert_code (ADDRESS_FILE, ADDRESS_FILE, MARKER_START, MARKER_END, write_sbit_constraints)

    MARKER_START='#### START: AUTO GENERATED RESETS UCF -- DO NOT EDIT ####'
    MARKER_END='#### END: AUTO GENERATED RESETS UCF -- DO NOT EDIT ####'

    insert_code (ADDRESS_FILE, ADDRESS_FILE, MARKER_START, MARKER_END, write_reset_constraints)

# produce a python object containing the netlist
# from altium should export netlist as  MultiWire
def parse_netlist():

    filename = ""

    if (hw_version=="v3a"):
        filename = 'OHv3a-SimpleNetList.NET'
    if (hw_version=="v3b"):
        filename = 'OHv3b-SimpleNetList.NET'

    f = open(filename, 'r')

    netlist = {}

    for line in f:
        if (line[0]!='-' and line[0:6]!="tp_gbt"):

            if (len(line.split())>3):
                print line
                print "PARSING LINE FAILED: # of elements > 3"
                continue
            elif (len(line.split())<3):
                print line
                print "PARSING LINE FAILED: # of elements < 3"
                continue
            else:
                (net,part,pin) = line.split()
                if (part=='U5' and net[0]!='+' and net!='GND'):
                    netlist.update({net: pin})
                    #print ("FOUND: net %s  pin %s" % (net, pin))

    return netlist

def write_reset_constraints (file_handle):

    f=file_handle

    netlist = parse_netlist()

    print "Netlist Parsed"

    for net in netlist:

        # sbits

        net = net.lower()
        regexp = re.compile("ext_reset_[0-9]*")

        if (regexp.match(net)):
            #print net + "     " + netlist.get(net)

            (ext, reset, pin) = net.split("_");

            pin = int(pin)-1 # subtract one; firmware counts from zero

            f.write('NET "ext_reset_o<%s>" LOC="%s";\n' % (pin, netlist.get(net)))

def write_sbit_constraints (file_handle):

    f=file_handle

    netlist = parse_netlist()

    print "Netlist Parsed"

    keys = netlist.keys()

    keys = keys.sort()

    #print("\n")
    #print("%s\n" % type(netlist))
    #print("\n")

    #print(keys)

    for net in sorted(netlist, key=natural_keys):

        # sbits

        patp   = re.compile("s[0-9]*_[0-9]*_p")
        patn   = re.compile("s[0-9]*_[0-9]*_n")

        net = net.lower();

        if (    patp.match(net) or patn.match(net)):
            #print net + "     " + netlist.get(net)

            (sector, pair, pin) = net.split("_");


            sector = sector [1:] # take off the S at the beginning

            print "Parsing SBIT %s, sector=%s, pair=%s, net=%s" % (net, sector, pair, pin)


            sbit=-1

            if (USE_INVERTED_NUMBERING):
                sbit= 8*( 23 - (int(sector)-1)) + int(pair) # enumerate 0--191 instead of (1--24)+(0--7)
            else:
                sbit = 8*(int(sector)-1) + int(pair) # enumerate 0--191 instead of (1--24)+(0--7)

            comment = ""
            if (sbit_polarity_swap(int(sector),int(pair))):
                comment = " # polarity swap"
                if (pin=='n'):
                    pin='p'
                elif (pin=='p'):
                    pin='n'

            netname =  ( "vfat_sbits_"+str(pin.lower())+"<"+str(sbit)+">").ljust(18, ' ')
            f.write('NET %s LOC="%s";%s\n' % (netname, netlist.get(net), comment))

        # start of transmission pulses

        patp_uc = re.compile("S[0-9]*CLKOUT_P")
        patn_uc = re.compile("S[0-9]*CLKOUT_N")
        patp_lc = re.compile("s[0-9]*clkout_p")
        patn_lc = re.compile("s[0-9]*clkout_n")

        if (    patp_uc.match(net) or patp_lc.match(net) or patn_uc.match(net) or patn_lc.match(net)):

            (sector, pin) = net.split("_");
            sector = sector [1:] # take off the s at the beginning
            sector = sector [:-6]

            comment = ""
            if (sot_polarity_swap(int(sector), hw_version)):
                comment = " # polarity swap"
                if (pin=='n'):
                    pin='p'
                elif (pin=='p'):
                    pin='n'

            vfat = -1
            if (USE_INVERTED_NUMBERING):
                vfat = 23-(int(sector)-1)
            else:
                vfat = int(sector) - 1

            # netlist counts sectors from 1,
            netname =  ( "vfat_sot_"+str(pin.lower())+"<"+str(vfat)+">").ljust(18, ' ')
            f.write('NET %s LOC="%s";%s\n' % (netname, netlist.get(net), comment))

def atoi(text):
    return int(text) if text.isdigit() else text

def natural_keys(text):
    '''
    alist.sort(key=natural_keys) sorts in human order
    http://nedbatchelder.com/blog/200712/human_sorting.html
    (See Toothy's implementation in the comments)
    '''
    return [ atoi(c) for c in re.split('(\d+)', text) ]


if __name__ == '__main__':
    main()
