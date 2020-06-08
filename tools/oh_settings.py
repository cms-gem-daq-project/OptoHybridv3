#/usr/env python2
import datetime
now = datetime.datetime.now()

# START: OH_VERSION
gem_version = "ge21"
oh_version  = "v3c"
geb_version = "v3c"
geb_length  = "short"
firmware_version_major   = "03"
firmware_version_minor   = "02"
firmware_release_version = "09"
firmware_year            = 2020
firmware_month           = 6
firmware_day             = 8
# END: OH_VERSION

hybrid_version           = "v3b"

ge21_five_cluster        = True

ge11_full_cluster_builder = False

release_hardware        = "00"
fpga_type                = "NULL"

use_channel_to_strip_mapping = False

USE_INVERTED_NUMBERING = False
num_vfats   = -1

if (gem_version == "ge21"):

    num_vfats = 12
    num_sbits = 8*num_vfats

    USE_INVERTED_NUMBERING = False

    release_hardware        = "2A"

    fpga_type = "A7"
    fpga_series7 = 1
    fpga_series6 = 0

    mxelinks = 1
    mxready  = 2
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

    fpga_type = "V6"
    fpga_series7 = 0
    fpga_series6 = 1

    mxelinks = 2
    mxready  = 1
    mxleds   = 16
    mxresets = 12

else:
    num_vfats = -1
    num_sbits = -1
    USE_INVERTED_NUMBERING = False
