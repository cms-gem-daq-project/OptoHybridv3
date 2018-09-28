def write_mapping_nomap (filename):
    padding="        "
    #filename.write ("%s-- constants written for 1-to-1 (nomap);\n" % (padding))
    for channel in range (128):

        if (channel % 2 == 0):
            sbit_channel = channel // 2

            filename.write ("%sstrips_out(I)(%2d) <= channels_in(I)(%d);\n" %(padding, sbit_channel, sbit_channel))
