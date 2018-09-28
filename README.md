# Firmware for the Optohybrid v3 

Releases are labeled as version_major.version_minor.version_patch.hardware_id

e.g. version 3.0.0.A is the 0th release for the v3a electronics, and 3.0.0.B will be the 0th release for the v3b electronics

Many parameters and settings inside of the Optohybrid firmware are compile-time programmed.  These can be updated with a single bash script, which is run by

cd tools
./update_oh_firmware.sh <gem_station> <oh_version> <geb_version> <geb_length> <firmware_version>

e.g. sh update_oh_firmware.sh ge11 v3c v3c long 03.01.06
