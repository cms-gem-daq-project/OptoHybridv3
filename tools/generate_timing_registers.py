ADDRESS_TABLE_TOP = '../optohybrid_registers.xml'
MARKER_START='<!-- START: TIMING_DELAYS DO NOT EDIT -->'
MARKER_END="<!-- END: TIMING_DELAYS DO NOT EDIT -->"

trig_tap_delays = [   3    , # TU_OFFSET[0][0]
    3    , # TU_OFFSET[0][1]
    3    , # TU_OFFSET[0][2]
    2    , # TU_OFFSET[0][3]
    2    , # TU_OFFSET[0][4]
    1    , # TU_OFFSET[0][5]
    1    , # TU_OFFSET[0][6]
    0    , # TU_OFFSET[0][7]
    3    , # TU_OFFSET[1][0]
    2    , # TU_OFFSET[1][1]
    2    , # TU_OFFSET[1][2]
    2    , # TU_OFFSET[1][3]
    2    , # TU_OFFSET[1][4]
    1    , # TU_OFFSET[1][5]
    1    , # TU_OFFSET[1][6]
    0    , # TU_OFFSET[1][7]
    6    , # TU_OFFSET[2][0]
    5    , # TU_OFFSET[2][1]
    5    , # TU_OFFSET[2][2]
    2    , # TU_OFFSET[2][3]
    2    , # TU_OFFSET[2][4]
    1    , # TU_OFFSET[2][5]
    1    , # TU_OFFSET[2][6]
    0    , # TU_OFFSET[2][7]
    3    , # TU_OFFSET[3][0]
    2    , # TU_OFFSET[3][1]
    2    , # TU_OFFSET[3][2]
    2    , # TU_OFFSET[3][3]
    2    , # TU_OFFSET[3][4]
    1    , # TU_OFFSET[3][5]
    1    , # TU_OFFSET[3][6]
    0    , # TU_OFFSET[3][7]
    6    , # TU_OFFSET[4][0]
    5    , # TU_OFFSET[4][1]
    4    , # TU_OFFSET[4][2]
    3    , # TU_OFFSET[4][3]
    2    , # TU_OFFSET[4][4]
    2    , # TU_OFFSET[4][5]
    1    , # TU_OFFSET[4][6]
    0    , # TU_OFFSET[4][7]
    9    , # TU_OFFSET[5][0]
    9    , # TU_OFFSET[5][1]
    9    , # TU_OFFSET[5][2]
    9    , # TU_OFFSET[5][3]
    9    , # TU_OFFSET[5][4]
    12   , # TU_OFFSET[5][5]
    13   , # TU_OFFSET[5][6]
    13   , # TU_OFFSET[5][7]
    1    , # TU_OFFSET[6][0]
    1    , # TU_OFFSET[6][1]
    1    , # TU_OFFSET[6][2]
    1    , # TU_OFFSET[6][3]
    0    , # TU_OFFSET[6][4]
    0    , # TU_OFFSET[6][5]
    0    , # TU_OFFSET[6][6]
    0    , # TU_OFFSET[6][7]
    1    , # TU_OFFSET[7][0]
    1    , # TU_OFFSET[7][1]
    2    , # TU_OFFSET[7][2]
    2    , # TU_OFFSET[7][3]
    2    , # TU_OFFSET[7][4]
    3    , # TU_OFFSET[7][5]
    3    , # TU_OFFSET[7][6]
    3    , # TU_OFFSET[7][7]
    0    , # TU_OFFSET[8][0]
    0    , # TU_OFFSET[8][1]
    9    , # TU_OFFSET[8][2]
    8    , # TU_OFFSET[8][3]
    9    , # TU_OFFSET[8][4]
    9    , # TU_OFFSET[8][5]
    9    , # TU_OFFSET[8][6]
    8    , # TU_OFFSET[8][7]
    0    , # TU_OFFSET[9][0]
    0    , # TU_OFFSET[9][1]
    1    , # TU_OFFSET[9][2]
    0    , # TU_OFFSET[9][3]
    1    , # TU_OFFSET[9][4]
    1    , # TU_OFFSET[9][5]
    1    , # TU_OFFSET[9][6]
    1    , # TU_OFFSET[9][7]
    0    , # TU_OFFSET[10][0]
    0    , # TU_OFFSET[10][1]
    1    , # TU_OFFSET[10][2]
    1    , # TU_OFFSET[10][3]
    1    , # TU_OFFSET[10][4]
    1    , # TU_OFFSET[10][5]
    2    , # TU_OFFSET[10][6]
    2    , # TU_OFFSET[10][7]
    7    , # TU_OFFSET[11][0]
    7    , # TU_OFFSET[11][1]
    8    , # TU_OFFSET[11][2]
    9    , # TU_OFFSET[11][3]
    9    , # TU_OFFSET[11][4]
    10   , # TU_OFFSET[11][5]
    13   , # TU_OFFSET[11][6]
    13   , # TU_OFFSET[11][7]
    1    , # TU_OFFSET[12][0]
    5    , # TU_OFFSET[12][1]
    5    , # TU_OFFSET[12][2]
    4    , # TU_OFFSET[12][3]
    4    , # TU_OFFSET[12][4]
    4    , # TU_OFFSET[12][5]
    4    , # TU_OFFSET[12][6]
    3    , # TU_OFFSET[12][7]
    2    , # TU_OFFSET[13][0]
    2    , # TU_OFFSET[13][1]
    1    , # TU_OFFSET[13][2]
    1    , # TU_OFFSET[13][3]
    1    , # TU_OFFSET[13][4]
    1    , # TU_OFFSET[13][5]
    0    , # TU_OFFSET[13][6]
    0    , # TU_OFFSET[13][7]
    3    , # TU_OFFSET[14][0]
    3    , # TU_OFFSET[14][1]
    3    , # TU_OFFSET[14][2]
    2    , # TU_OFFSET[14][3]
    2    , # TU_OFFSET[14][4]
    2    , # TU_OFFSET[14][5]
    2    , # TU_OFFSET[14][6]
    4    , # TU_OFFSET[14][7]
    0    , # TU_OFFSET[15][0]
    1    , # TU_OFFSET[15][1]
    2    , # TU_OFFSET[15][2]
    2    , # TU_OFFSET[15][3]
    3    , # TU_OFFSET[15][4]
    4    , # TU_OFFSET[15][5]
    5    , # TU_OFFSET[15][6]
    6    , # TU_OFFSET[15][7]
    0    , # TU_OFFSET[16][0]
    0    , # TU_OFFSET[16][1]
    0    , # TU_OFFSET[16][2]
    1    , # TU_OFFSET[16][3]
    1    , # TU_OFFSET[16][4]
    2    , # TU_OFFSET[16][5]
    2    , # TU_OFFSET[16][6]
    2    , # TU_OFFSET[16][7]
    0    , # TU_OFFSET[17][0]
    0    , # TU_OFFSET[17][1]
    1    , # TU_OFFSET[17][2]
    1    , # TU_OFFSET[17][3]
    2    , # TU_OFFSET[17][4]
    2    , # TU_OFFSET[17][5]
    3    , # TU_OFFSET[17][6]
    3    , # TU_OFFSET[17][7]
    0    , # TU_OFFSET[18][0]
    1    , # TU_OFFSET[18][1]
    1    , # TU_OFFSET[18][2]
    1    , # TU_OFFSET[18][3]
    1    , # TU_OFFSET[18][4]
    2    , # TU_OFFSET[18][5]
    2    , # TU_OFFSET[18][6]
    2    , # TU_OFFSET[18][7]
    0    , # TU_OFFSET[19][0]
    0    , # TU_OFFSET[19][1]
    1    , # TU_OFFSET[19][2]
    2    , # TU_OFFSET[19][3]
    3    , # TU_OFFSET[19][4]
    3    , # TU_OFFSET[19][5]
    3    , # TU_OFFSET[19][6]
    4    , # TU_OFFSET[19][7]
    2    , # TU_OFFSET[20][0]
    2    , # TU_OFFSET[20][1]
    1    , # TU_OFFSET[20][2]
    1    , # TU_OFFSET[20][3]
    1    , # TU_OFFSET[20][4]
    1    , # TU_OFFSET[20][5]
    0    , # TU_OFFSET[20][6]
    0    , # TU_OFFSET[20][7]
    0    , # TU_OFFSET[21][0]
    0    , # TU_OFFSET[21][1]
    0    , # TU_OFFSET[21][2]
    0    , # TU_OFFSET[21][3]
    0    , # TU_OFFSET[21][4]
    0    , # TU_OFFSET[21][5]
    0    , # TU_OFFSET[21][6]
    15   , # TU_OFFSET[21][7]
    9    , # TU_OFFSET[22][0]
    9    , # TU_OFFSET[22][1]
    8    , # TU_OFFSET[22][2]
    8    , # TU_OFFSET[22][3]
    8    , # TU_OFFSET[22][4]
    8    , # TU_OFFSET[22][5]
    7    , # TU_OFFSET[22][6]
    7    , # TU_OFFSET[22][7]
    12   , # TU_OFFSET[23][0]
    11   , # TU_OFFSET[23][1]
    11   , # TU_OFFSET[23][2]
    10   , # TU_OFFSET[23][3]
    10   , # TU_OFFSET[23][4]
    10   , # TU_OFFSET[23][5]
    10   , # TU_OFFSET[23][6]
    10     # TU_OFFSET[23][7]
    ]

sot_tap_delays  = [
  5  , # SOF_OFFSET[0]
  5  , # SOF_OFFSET[1]
  5  , # SOF_OFFSET[2]
  2  , # SOF_OFFSET[3]
  9  , # SOF_OFFSET[4]
  0  , # SOF_OFFSET[5]
  2  , # SOF_OFFSET[6]
  0  , # SOF_OFFSET[7]
  11 , # SOF_OFFSET[8]
  1  , # SOF_OFFSET[9]
  6  , # SOF_OFFSET[10]
  0  , # SOF_OFFSET[11]
  0  , # SOF_OFFSET[12]
  1  , # SOF_OFFSET[13]
  0  , # SOF_OFFSET[14]
  11 , # SOF_OFFSET[15]
  2  , # SOF_OFFSET[16]
  3  , # SOF_OFFSET[17]
  11 , # SOF_OFFSET[18]
  4  , # SOF_OFFSET[19]
  1  , # SOF_OFFSET[20]
  12 , # SOF_OFFSET[21]
  0  , # SOF_OFFSET[22]
  0   # SOF_OFFSET[23]
  ]

def main():

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
                    for bit in range (8):

                        print ( "VFAT #%s, Trigger Bit %s, Tap Delay=%s" % (vfat, bit, trig_tap_delays[vfat*8+bit]))
                        global_bit = vfat*8+bit
                        address=global_bit / 6 # 5 bits per tap means 6 taps per 32 bit register
                        mask=0x1f << 5*(global_bit % 6)

                        f.write('%s<node id="TAP_DELAY_VFAT%s_BIT%s" address="0x%X" permission="rw"\n' % (padding, vfat, bit, address))
                        f.write('%s    mask="0x%08X"\n' % (padding, mask))
                        f.write('%s    description="uncalibrated 78 ps tap delay"\n' % padding)
                        f.write('%s    fw_signal="trig_tap_delay(%s)"\n' % (padding, global_bit))
                        f.write('%s    fw_default="%s"/>\n' % (padding, trig_tap_delays[global_bit]))

                for vfat in range (24):

                    sot_base_address = 191 / 6 + 1
                    address = sot_base_address + vfat/6
                    mask=0x1f << 5*(vfat % 6) # 6 vfats per register

                    f.write('%s<node id="SOT_TAP_DELAY_VFAT%s" address="0x%X" permission="rw"\n' % (padding, vfat, address))
                    f.write('%s    mask="0x%08X"\n' % (padding, mask))
                    f.write('%s    description="uncalibrated 78 ps tap delay"\n' % padding)
                    f.write('%s    fw_signal="sot_tap_delay(%s)"\n' % (padding, vfat))
                    f.write('%s    fw_default="%s"/>\n' % (padding, sot_tap_delays[vfat]))

        f.close

if __name__ == '__main__':
    main()
