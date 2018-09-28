from oh_settings import *
from insert_code import *

from timing_constants_geb_v3b_short import *
from timing_constants_geb_v3a_short import *
from timing_constants_geb_v3c_long  import *
from timing_constants_geb_ge21_null  import *

import sys

ADDRESS_TABLE_TOP = '../optohybrid_registers.xml'
MARKER_START='<!-- START: TIMING_DELAYS DO NOT EDIT -->'
MARKER_END="<!-- END: TIMING_DELAYS DO NOT EDIT -->"


def main():



    def write_invert_map (file_handle):

        f=file_handle

        trig_tap_delays= []
        sot_tap_delays = []

        if (geb_version=="v3a" and geb_length=="short" and gem_version=="ge11"):
            trig_tap_delays = v3a_short_trig_tap_delays
            sot_tap_delays = v3a_short_sot_tap_delays
        elif (geb_version=="v3b" and geb_length=="short" and gem_version=="ge11"):
            trig_tap_delays = v3b_short_trig_tap_delays
            sot_tap_delays = v3b_short_sot_tap_delays
        elif (geb_version=="v3c" and geb_length=="long" and gem_version=="ge11"):
            trig_tap_delays = v3c_long_trig_tap_delays
            sot_tap_delays = v3c_long_sot_tap_delays
        elif (gem_version=="ge21"):
            trig_tap_delays = ge21_null_trig_tap_delays
            sot_tap_delays = ge21_null_sot_tap_delays
        else:
            trig_tap_delays = []
            sot_tap_delays = []
            print ("Unknown settings in update_timing_registers");
            return sys.exit(1)


        padding = "                    " # indent
        base_address = 0x0

        for vfat in range (num_vfats):

            geb_slot = 0

            if (USE_INVERTED_NUMBERING):
                geb_slot = (num_vfats-1)-vfat
            else:
                geb_slot = vfat

            for bit in range (8):

                global_bit                  = vfat*8+bit
                global_bit_in_geb_numbering = geb_slot*8+bit

                address=(vfat*8+bit) / 6 # 5 bits per tap means 6 taps per 32 bit register
                mask=0x1f << 5*(global_bit % 6)

                #print ( "VFAT #%s, Trigger Bit %s, Tap Delay=%s" % (vfat, bit, trig_tap_delays[global_bit]))

                f.write('%s<node id="TAP_DELAY_VFAT%s_BIT%s" address="0x%X" permission="rw"\n'                          %  (padding, vfat, bit, address))
                f.write('%s    mask="0x%08X"\n'                                                                         %  (padding, mask))
                f.write('%s    description="VFAT %d S-bit %d tap delay"\n'  %  (padding, vfat, bit))
                f.write('%s    fw_signal="trig_tap_delay(%d)"\n'                                                        %  (padding, global_bit))
                f.write('%s    fw_default="%d"/>\n'                                                                     %  (padding, trig_tap_delays[global_bit_in_geb_numbering]))

        for vfat in range (num_vfats):

            geb_slot = 0

            if (USE_INVERTED_NUMBERING):
                geb_slot = (num_vfats-1)-vfat
            else:
                geb_slot = vfat

            sot_base_address = (num_sbits-1) / 6 + 1
            address = sot_base_address + vfat/6
            mask=0x1f << 5*(vfat % 6) # 6 vfats per register

            #print ( "VFAT #%s SOT, Tap Delay=%s" % (vfat, sot_tap_delays[geb_slot]))

            f.write('%s<node id="SOT_TAP_DELAY_VFAT%s" address="0x%X" permission="rw"\n'                            %  (padding, vfat, address))
            f.write('%s    mask="0x%08X"\n'                                                                         %  (padding, mask))
            f.write('%s    description="VFAT %d SOT tap delay"\n'                                                   %  (padding, vfat))
            f.write('%s    fw_signal="sot_tap_delay(%d)"\n'                                                         %  (padding, vfat))
            f.write('%s    fw_default="%d"/>\n'                                                                     %  (padding, sot_tap_delays[geb_slot]))

    insert_code (ADDRESS_TABLE_TOP, ADDRESS_TABLE_TOP, MARKER_START, MARKER_END, write_invert_map)


if __name__ == '__main__':
    main()
