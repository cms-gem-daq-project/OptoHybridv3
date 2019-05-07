#!/usr/bin/env python

from rw_reg import *
from time import *
import array
import struct
import sys

DEBUG=False

QUICKTEST = True
SINGLEVFAT = False

SBitMaskAddress = 0x6502c010
NUM_STRIPS = 128
NUM_PADS = 8
OH_NUM = 2

#VFAT DEFAULTS
CONTREG0=55
CONTREG1=0
CONTREG2=48
CONTREG3=0
IPREAMPIN=168
IPREAMPFEED=80
IPREAMPOUT=150
ISHAPER=150
ISHAPERFEED=100
ICOMP=75

VTHRESHOLD1=50
VCAL=190

OUTPUT_FILE='./results.txt'

pulses = 1

class Colors:
    WHITE   = '\033[97m'
    CYAN    = '\033[96m'
    MAGENTA = '\033[95m'
    BLUE    = '\033[94m'
    YELLOW  = '\033[93m'
    GREEN   = '\033[92m'
    RED     = '\033[91m'
    ENDC    = '\033[0m'

def main():

    ohSelect = 0
    vfatSelect = 0

    if len(sys.argv) < 3:
        print('Usage: sbit_polarity_scan.py <oh_num> <vfat_num_min> <vfat_num_max>')
        return
    if len(sys.argv) == 4:
        ohSelect      = int(sys.argv[1])
        vfatSelectMin = int(sys.argv[2])
        vfatSelectMax = int(sys.argv[3])
    else:
        ohSelect      = int(sys.argv[1])
        vfatSelectMin = int(sys.argv[2])
        vfatSelectMax = vfatSelectMin

    if ohSelect > 11:
        printRed("The given OH index (%d) is out of range (must be 0-11)" % ohSelect)
        return
    if vfatSelectMin > 23:
        printRed("The given VFAT index (%d) is out of range (must be 0-23)" % vfatSelect)
        return
    if vfatSelectMax > 23:
        printRed("The given VFAT index (%d) is out of range (must be 0-23)" % vfatSelect)
        return

    parseXML()

    for vfatSelect in range(vfatSelectMin, vfatSelectMax+1):

        print ("Scanning polarity on VFAT#%i" % vfatSelect);

        original_invert = parseInt(readReg(getNode("GEM_AMC.OH.OH%i.FPGA.TRIG.CTRL.INVERT.VFAT%i_TU_INVERT" % (ohSelect, vfatSelect)))) # new table

        writeReg(getNode("GEM_AMC.OH.OH%i.FPGA.TRIG.CTRL.VFAT_MASK" % ohSelect), 0xffffff ^ (1 << vfatSelect))

        sleep (0.001)

        sot_ready = parseInt(readReg(getNode("GEM_AMC.OH.OH%i.FPGA.TRIG.CTRL.SBIT_SOT_READY" % (ohSelect))))

        writeReg(getNode("GEM_AMC.TTC.GENERATOR.CYCLIC_L1A_COUNT"),  1)

        invert_mask = original_invert

        if (not 0x1&(sot_ready>>vfatSelect)):
                print ("\tSOT not ready on VFAT %i, can't scan" % (vfatSelect))
                print ("\tTrying inverted SOT signal")
                sot_invert = parseInt(readReg(getNode("GEM_AMC.OH.OH0.FPGA.TRIG.CTRL.INVERT.SOT_INVERT"))) # new
                writeReg(getNode("GEM_AMC.OH.OH0.FPGA.TRIG.CTRL.INVERT.SOT_INVERT"), sot_invert ^ (0x1<<vfatSelect)) #new
                sleep(0.1)
                sot_ready = parseInt(readReg(getNode("GEM_AMC.OH.OH%i.FPGA.TRIG.CTRL.SBIT_SOT_READY" % (ohSelect))))
                if (0x1&(sot_ready>>vfatSelect)):
                    print "SoT signal on VFAT%i appears to be inverted... it should be corrected in the firmware" % vfatSelect

        else:
            for ibit in range(8):

                        tu_mask = 0xff & (0xff ^ (1 << (ibit)))
                        writeReg(getNode("GEM_AMC.OH.OH%i.FPGA.TRIG.CTRL.TU_MASK.VFAT%i_TU_MASK" % (ohSelect, vfatSelect)), tu_mask)

                        sleep(1.00)

                        rate_base     = parseInt(readReg(getNode("GEM_AMC.OH.OH%i.FPGA.CONTROL.SBITS.CLUSTER_RATE" % (ohSelect))))
                        #print ("\tBase cluster rate = %x" % (rate_base))

                        writeReg(getNode("GEM_AMC.OH.OH%i.FPGA.TRIG.CTRL.INVERT.VFAT%i_TU_INVERT" % (ohSelect, vfatSelect)), original_invert ^ (1 << ibit)) #new

                        sleep(1.00)

                        rate_inverted = parseInt(readReg(getNode("GEM_AMC.OH.OH%i.FPGA.CONTROL.SBITS.CLUSTER_RATE" % (ohSelect))))
                        #print ("\tInverted cluster rate = %d" % (rate_inverted))

                        if (rate_inverted == 0 and rate_base > 0):
                            print ("BAD: Inversion on VFAT%i S-bit pair #%i, rate=%x, rate_inverted=%x" % (vfatSelect, ibit, rate_base, rate_inverted))
                            invert_mask = invert_mask ^ (0x1 << ibit)
                        elif (rate_base==0 and rate_inverted > 0):
                            print ("OK : Correct polarity   on VFAT%i S-bit pair #%i, rate=%x, rate_inverted=%x" % (vfatSelect, ibit, rate_base, rate_inverted))
                        else:
                            print ("Ambiguous polarity   on VFAT%i S-bit pair #%i, rate=%x, rate_inverted=%x" % (vfatSelect, ibit, rate_base, rate_inverted))

                        writeReg(getNode("GEM_AMC.OH.OH%i.FPGA.TRIG.CTRL.INVERT.VFAT%i_TU_INVERT" % (ohSelect, vfatSelect)), original_invert) # new

            if (invert_mask != original_invert):
                print ("Suggested inversion mask = 0x%x for GEM_AMC.OH.OH%i.FPGA.TRIG.CTRL.INVERT.VFAT%i_TU_INVERT" % (invert_mask, ohSelect, vfatSelect)) #new
            else:
                print ("Inversion mask correct");

        writeReg(getNode("GEM_AMC.OH.OH%i.FPGA.TRIG.CTRL.VFAT_MASK" % ohSelect), 0)
        writeReg(getNode("GEM_AMC.OH.OH%i.FPGA.TRIG.CTRL.TU_MASK.VFAT%i_TU_MASK" % (ohSelect, vfatSelect)), 0)

    print("")
    print("bye now..")

def check_bit(byteval,idx):
    return ((byteval&(1<<idx))!=0);

def debug(string):
    if DEBUG:
        print('DEBUG: ' + string)

def debugCyan(string):
    if DEBUG:
        printCyan('DEBUG: ' + string)

def heading(string):
    print (Colors.BLUE)
    print ('\n>>>>>>> '+str(string).upper()+' <<<<<<<')
    print (Colors.ENDC)

def subheading(string):
    print (Colors.YELLOW)
    print ('---- '+str(string)+' ----',Colors.ENDC)

def printCyan(string):
    print (Colors.CYAN)
    print (string, Colors.ENDC)

def printRed(string):
    print (Colors.RED)
    print (string, Colors.ENDC)

def hex(number):
    if number is None:
        return 'None'
    else:
        return "{0:#0x}".format(number)

def binary(number, length):
    if number is None:
        return 'None'
    else:
        return "{0:#0{1}b}".format(number, length + 2)

if __name__ == '__main__':
    main()
