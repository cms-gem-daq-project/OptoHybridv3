ADDRESS_FILE = '../src/ucf/misc.ucf'
MARKER_START='#### START: UCF DO NOT EDIT ####'
MARKER_END='#### END: UCF DO NOT EDIT ####'
import re
# export netlist as  MultiWire

# produce a python object containing the netlist
def parse_netlist():
    filename = 'OHv3a-SimpleNetList.NET'
    f = open(filename, 'r')

    netlist = {}

    for line in f:
        if (line[0]!='-'):

            if (len(line.split())>3):
                #print "PARSING LINE FAILED: # of elements > 3"
                #print line
                continue
            elif (len(line.split())<3):
                #print "PARSING LINE FAILED: # of elements < 3"
                #print line
                continue
            else:
                (net,part,pin) = line.split()
                if (part=='U5' and net[0]!='+' and net!='GND'):
                    netlist.update({net: pin})

    return netlist

def main():

    # build a python netlist from the Altium exported Multiwire netlist

    netlist = parse_netlist()

    f = open(ADDRESS_FILE, 'r+')
    lines = f.readlines()
    f.close()

    f = open(ADDRESS_FILE + '.bak', 'w')
    for line in lines:
        f.write(line)
    f.close

    start_found = False
    end_found = False

    for line in lines:
        if MARKER_START in line:
            start_found = True
        if MARKER_END in line:
            end_found = True

    ok_to_write = start_found and end_found

    if (not ok_to_write):
        print ("start and end section markers not found in %s" % ADDRESS_FILE)
        print ("please insert the following lines into the file")
        print ("%s" % MARKER_START)
        print ("%s" % MARKER_END)
    else:

        start_found = False
        end_found = False

        wrote_constraints = False

        #f = open("temp.ucf", 'w')
        f = open(ADDRESS_FILE, 'w')


        for line in lines:

            if (not start_found):
                f.write(line)

            if (end_found or (MARKER_END in line)):
                f.write(line)

            if MARKER_START in line:
                start_found = True

            if MARKER_END in line:
                end_found = True

            padding = "                    " #spaces for indentation
            if (start_found and not end_found and not wrote_constraints):
                wrote_constraints = True
                print ("starting")
                write_sbit_constraints (f, netlist)


        f.close

#def write_invert_map  (filename, netlist):
#
#    f = open(filename, 'w')
#
#    # sbits
#
#    f.write( "localparam [23:0] SOF_INVERT  = {")
#    for j in range (24,0,-1):
#        if (sof_polarity_swap(int(j))):
#            swap = '1'
#        else:
#            swap = '0'
#
#        if (j==0):
#            sep = ' '
#        else:
#            sep = ','
#
#        f.write( "  1'b" + swap + sep + " // SOF_INVERT[" + str(j-1) + "]"
#    f.write( "};"
#    f.write( "localparam [191:0] TU_INVERT  = {"
#    for sector in range (24,0,-1):
#        for pair   in range (8,0,-1):
#
#            if (sbit_polarity_swap(int(sector),int(pair-1))):
#                swap = '1'
#            else:
#                swap = '0'
#
#            if (sector==1 and pair==1):
#                sep = ' '
#            else:
#                sep = ','
#
#            f.write( "  1'b" + swap + sep + " // TU_INVERT[" + str(8*(sector-1)+pair-1) + "]"
#    f.write( "};\n")
#
#    f.close();

def write_sbit_constraints (file_handle, netlist):

    f=file_handle

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

def pin_needs_ucf (io_signal):
    if (io_signal=='GND'):
        return False
    elif (io_signal[0:3]=='3v3'):
        return False
    elif (io_signal[0:3]=='1v8'):
        return False
    elif (io_signal[0]=='+'):
        return False
    elif (io_signal[0:2] == "NC"):
        return False
    elif (io_signal[4:9] == "prgrm"):
        return False
    elif (io_signal == '/hard_rst'):
        return False

    return True

def sof_polarity_swap (sector):

    if   (sector==8):
        return True
    elif (sector==22):
        return True
    elif (sector==23):
        return True
    elif (sector==5):
        return True
    elif (sector==15):
        return True
    elif (sector==3):
        return True
    elif (sector==9):
        return True
    elif (sector==1):
        return True
    elif (sector==4):
        return True
    elif (sector==2):
        return True
    elif (sector==12):
        return True
    elif (sector==19):
        return True
    elif (sector==17):
        return True
    else:
        return False


def sbit_polarity_swap (sector, pair):

    if      (sector==1):
        if (pair==2):
            return True
        if (pair==4):
            return True

    elif (sector==2):
        if (pair==1):
            return True
        if (pair==3):
            return True

    elif (sector==3):
        if (pair==0):
            return True
        if (pair==1):
            return True
        if (pair==4):
            return True
        if (pair==5):
            return True
        if (pair==6):
            return True

    elif (sector==4):
        if (pair==5):
            return True
        if (pair==6):
            return True

    elif (sector==5):
        if (pair==0):
            return True
        if (pair==2):
            return True
        if (pair==3):
            return True
        if (pair==4):
            return True
        if (pair==6):
            return True

    elif (sector==6):
        if (pair==4):
            return True
        if (pair==5):
            return True

    elif (sector==7):
        if (pair==1):
            return True
        if (pair==2):
            return True

    elif (sector==8):
        if (pair==1):
            return True
        if (pair==5):
            return True
        if (pair==6):
            return True
        if (pair==7):
            return True

    elif (sector==9):
        if (pair==0):
            return True
        if (pair==1):
            return True
        if (pair==2):
            return True
        if (pair==3):
            return True
        if (pair==7):
            return True

    elif (sector==10):
        if (pair==0):
            return True
        if (pair==2):
            return True
        if (pair==5):
            return True
        if (pair==6):
            return True
        if (pair==7):
            return True

    elif (sector==11):
        if (pair==0):
            return True
        if (pair==1):
            return True
        if (pair==2):
            return True
        if (pair==4):
            return True

    elif (sector==12):
        if (pair==0):
            return True
        if (pair==2):
            return True
        if (pair==3):
            return True
        if (pair==5):
            return True
        if (pair==7):
            return True

    elif (sector==13):
        if (pair==1):
            return True
        if (pair==2):
            return True
        if (pair==3):
            return True
        if (pair==5):
            return True
        if (pair==6):
            return True
        if (pair==7):
            return True

    elif (sector==14):
        if (pair==2):
            return True
        if (pair==3):
            return True
        if (pair==4):
            return True
        if (pair==6):
            return True
        if (pair==7):
            return True

    elif (sector==15):
        if (pair==0):
            return True
        if (pair==1):
            return True
        if (pair==2):
            return True

    elif (sector==16):
        if (pair==0):
            return True
        if (pair==4):
            return True
        if (pair==5):
            return True
        if (pair==6):
            return True

    elif (sector==17):
        if (pair==1):
            return True
        if (pair==4):
            return True
        if (pair==5):
            return True
        if (pair==1):
            return True

    elif (sector==18):
        if (pair==3):
            return True

    elif (sector==19):
        if (pair==0):
            return True
        if (pair==2):
            return True
        if (pair==3):
            return True
        if (pair==4):
            return True
        if (pair==5):
            return True
        if (pair==7):
            return True


    elif (sector==20):
        if (pair==0):
            return True
        if (pair==2):
            return True
        if (pair==3):
            return True
        if (pair==5):
            return True

    elif (sector==21):
        if (pair==0):
            return True
        if (pair==1):
            return True
        if (pair==2):
            return True
        if (pair==5):
            return True
        if (pair==6):
            return True
        if (pair==7):
            return True

    elif (sector==22):
        if (pair==1):
            return True
        if (pair==2):
            return True
        if (pair==6):
            return True

    elif (sector==23):
        if (pair==0):
            return True
        if (pair==1):
            return True
        if (pair==2):
            return True
        if (pair==5):
            return True
        if (pair==6):
            return True

    elif (sector==24):
        if (pair==0):
            return True
        if (pair==2):
            return True
        if (pair==6):
            return True

    else:

        return False

if __name__ == '__main__':
    main()
