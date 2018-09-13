from oh_settings import *

from timing_constants_geb_v3b_short import *
from timing_constants_geb_v3a_short import *
from timing_constants_geb_v3c_long  import *

ADDRESS_TABLE_TOP = '../optohybrid_registers.xml'
MARKER_START='<!-- START: TIMING_DELAYS DO NOT EDIT -->'
MARKER_END="<!-- END: TIMING_DELAYS DO NOT EDIT -->"


def main():

    trig_tap_delays = 0
    sot_tap_delays = 0

    if (geb_version=="v3a" and geb_length=="short"):
        trig_tap_delays = v3a_short_trig_tap_delays
        sot_tap_delays = v3a_short_sot_tap_delays
    elif (geb_version=="v3b" and geb_length=="short"):
        trig_tap_delays = v3b_short_trig_tap_delays
        sot_tap_delays = v3b_short_sot_tap_delays
    elif (geb_version=="v3c" and geb_length=="long"):
        trig_tap_delays = v3c_long_trig_tap_delays
        sot_tap_delays = v3c_long_sot_tap_delays
    else:
        trig_tap_delays = 0
        sot_tap_delays = 0

    f = open(ADDRESS_TABLE_TOP, 'r+')
    lines = f.readlines()
    f.close()

    f = open(ADDRESS_TABLE_TOP + '.bak', 'w')
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
        print ("start and end section markers not found in %s" % ADDRESS_TABLE_TOP)
        print ("please insert the following lines into the file")
        print ("%s" % MARKER_START)
        print ("%s" % MARKER_END)
    else:

        start_found = False
        end_found = False

        wrote_registers = False

        #f = open("temp.xml", 'w')
        f = open(ADDRESS_TABLE_TOP, 'w')


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
            if (start_found and not end_found and not wrote_registers):
                wrote_registers = True
                print ("starting")

                for vfat in range (24):

                    geb_slot = 0


                    if (USE_INVERTED_NUMBERING):
                        geb_slot = 23-vfat
                    else:
                        geb_slot = vfat

                    for bit in range (8):

                        global_bit_in_geb_numbering = geb_slot*8+bit
                        global_bit = vfat*8+bit

                        address=global_bit // 6 # 5 bits per tap means 6 taps per 32 bit register
                        mask=0x1f << 5*(global_bit % 6)

                        print ( "VFAT #%s, Trigger Bit %s, tu number=%d, Tap Delay=%s" % (vfat, bit, global_bit, trig_tap_delays[global_bit_in_geb_numbering]))

                        f.write('%s<node id="TAP_DELAY_VFAT%s_BIT%s" address="0x%X" permission="rw"\n' % (padding, vfat, bit, address))
                        f.write('%s    mask="0x%08X"\n' % (padding, mask))
                        f.write('%s    description="78 ps tap delay. Set from 0-21 to equalize trace lengths within a VFAT"\n' % padding)
                        f.write('%s    fw_signal="trig_tap_delay(%s)"\n' % (padding, global_bit))
                        f.write('%s    fw_default="%s"/>\n' % (padding, trig_tap_delays[global_bit_in_geb_numbering]))

                for vfat in range (24):

                    geb_slot = 0

                    if (USE_INVERTED_NUMBERING):
                        geb_slot = 23-vfat
                    else:
                        geb_slot = vfat

                    sot_base_address = 191 / 6 + 1
                    address = sot_base_address + vfat/6
                    mask=0x1f << 5*(vfat % 6) # 6 vfats per register

                    print ( "VFAT #%s SOT, Tap Delay=%s" % (vfat, sot_tap_delays[geb_slot]))

                    f.write('%s<node id="SOT_TAP_DELAY_VFAT%s" address="0x%X" permission="rw"\n' % (padding, vfat, address))
                    f.write('%s    mask="0x%08X"\n' % (padding, mask))
                    f.write('%s    description="78 ps tap delay. Set from 0-21 to equalize trace lengths within a VFAT"\n' % padding)
                    f.write('%s    fw_signal="sot_tap_delay(%s)"\n' % (padding, vfat))
                    f.write('%s    fw_default="%s"/>\n' % (padding, sot_tap_delays[geb_slot]))

        f.close

if __name__ == '__main__':
    main()
