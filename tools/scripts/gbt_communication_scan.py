#!/usr/bin/env python

from rw_reg import *
from time import *
import array
import random
import struct
import sys

#VFAT DEFAULTS

ADDR_JTAG_LENGTH = None
ADDR_JTAG_TMS = None
ADDR_JTAG_TDO = None
ADDR_JTAG_TDI = None

SCAN_RANGE = 18

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

    iter = 4000000

    parseXML()

    loopback_reg = getNode('GEM_AMC.OH.OH1.FPGA.CONTROL.LOOPBACK.DATA').real_address
    ipass = 0
    ifail = 0
    tot ="{:,}".format(iter)

    write = random.getrandbits(32)
    wReg (loopback_reg, write)

    for i in range (iter):
        if (i%10000==0):
            icyc ="{:,}".format(i)
            print "Cycle %s out of %s... accumulated %f Mb of good data with %i failures" % (icyc, tot, ipass*32/1000000., ifail)
        read = rReg (loopback_reg)
        passfail = ""
        if (write != read):
            ifail+=1
            passfail="FAIL: "
            print ("%s write=%8x, read=%8x (i=%d)" % (passfail, write,read, i))
        else:
            ipass+=1
            #passfail="PASS: "
            #print ("%s write=%8x, read=%8x (i=%d)" % (passfail, write,read, i))

        if (passfail=="FAIL: "):
            sys.exit()

    print ""
    print "Summary:"
    print "\tipass=%d" % ipass
    print "\tifail=%d" % ifail

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
