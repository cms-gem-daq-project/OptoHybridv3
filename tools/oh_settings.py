import datetime
now = datetime.datetime.now()

# START: OH_VERSION
gem_version = "ge11"
oh_version  = "v3c"
geb_version = "v3c"
geb_length  = "long"
firmware_version_major   = "03"
firmware_version_minor   = "02"
firmware_release_version = "04"
# END: OH_VERSION

hybrid_version           = "v3b"

ge21_five_cluster        = True

ge11_full_cluster_builder = False

firmware_year            = now.year
firmware_month           = now.month
firmware_day             = now.day

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

    fpga_type = "ARTIX7"
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

    fpga_type = "VIRTEX6"
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
