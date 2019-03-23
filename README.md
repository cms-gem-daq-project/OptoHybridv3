# Firmware for the Optohybrid v3 

Releases are labeled as version_major.version_minor.version_patch.hardware_id

Many parameters and settings inside of the Optohybrid firmware are compile-time programmed.  These can be updated with a single bash script, which is run by

cd tools
./update_oh_firmware.sh <gem_station> <oh_version> <geb_version> <geb_length> <firmware_version>

e.g. sh update_oh_firmware.sh ge11 v3c v3c long 03.01.06

You should make sure to run this. All firmware development is done with GE1/1 firmware as the "master" with commits done there, and the GE2/1 firmware branch mirroring it only as a clone.. development should not be commited directly to the GE2/1 firmware branch. 

This script also generates PDF latex documentation, so you should make sure it runs appropriately and you have a latex compiler installed if you are releasing firmware. 


Note the hardware versions are denoted as: 

i.e. in HARDWARE_VERSION XY

x=chamber type (0=ge11 short, 1=ge11 long, 2=ge21) 
y=hardware generation

Specifically, 

GE1/1 v3b Short: 0B
GE1/1 v3C Short: 0C 
GE1/1 v3C Long: 1C
GE2/1 v1: 2A
