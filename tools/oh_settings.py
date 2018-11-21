import datetime
now = datetime.datetime.now()

# START: OH_VERSION
gem_version = "ge11"
oh_version  = "v3c"
geb_version = "v3c"
geb_length  = "long"
firmware_version_major   = "03"
firmware_version_minor   = "01"
firmware_release_version = "06"
# END: OH_VERSION

firmware_year            = now.year
firmware_month           = now.month
firmware_day             = now.day

release_hardware        = "00"
fpga_type                = "NULL"

USE_INVERTED_NUMBERING = False
num_vfats   = 0

if (gem_version == "ge21"):

    num_vfats = 12
    num_sbits = 8*num_vfats

    USE_INVERTED_NUMBERING = False

    release_hardware        = "2A"

    fpga_type = "ARTIX7"
    fpga_series7 = 1
    fpga_series6 = 0

    mxelinks = 1
    mxleds   = 1
    mxresets = 1

elif (gem_version == "ge11"):

    num_vfats = 24
    num_sbits = 8*num_vfats

    USE_INVERTED_NUMBERING = True

    if (geb_version=="v3c" and geb_length == "long"):
        release_hardware        = "1C"
    if (geb_version=="v3c" and geb_length == "short"):
        release_hardware        = "0C"
    if (geb_version=="v3b" and geb_length == "short"):
        release_hardware        = "0B"

    fpga_type = "VIRTEX6"
    fpga_series7 = 0
    fpga_series6 = 1

    mxelinks = 2
    mxleds   = 16
    mxresets = 12

else:
    num_vfats = -1
    num_sbits = -1
    USE_INVERTED_NUMBERING = False


# This is numbered in GEB-1 numbering, i.e. i2c bus numbering - 1
ROTATED_SLOTS = [
        0, # 0
        0, # 1
        0, # 2
        0, # 3
        0, # 4
        0, # 5
        0, # 6
        0, # 7
        0, # 8
        0, # 9
        0, # 10
        0, # 11
        0, # 12
        0, # 13
        0, # 14
        0, # 15
        0, # 16
        0, # 17
        0, # 18
        0, # 19
        0, # 20
        0, # 21
        0, # 22
        0  # 23
]
