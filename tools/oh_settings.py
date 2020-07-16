#/usr/env python2
import datetime
now = datetime.datetime.now()

# START: OH_VERSION
gem_version = "ge21"
oh_version  = "v3c"
geb_version = "v3c"
geb_length  = ""
firmware_version_major   = 3
firmware_version_minor   = 4
firmware_release_version = 0
firmware_year            = 2020
firmware_month           = 7
firmware_day             = 16
# END: OH_VERSION

if (gem_version == "ge21"):
    num_vfats = 12
    num_sbits = 8*num_vfats
    USE_INVERTED_NUMBERING = False
    release_hardware        = "2A"
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
else:
    num_vfats = -1
    num_sbits = -1
