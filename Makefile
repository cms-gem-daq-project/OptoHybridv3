.PHONY = all clean

VER_ARG =
ifdef version
VER_ARG = -v $(version)
endif

all: update

update:
	cd tools && sh update_oh_firmware.sh ge21 $(VER_ARG) | ccze -A
	cd tools && sh update_oh_firmware.sh ge11 -l long $(VER_ARG) | ccze -A
	cd tools && sh update_oh_firmware.sh ge11 -l short $(VER_ARG) | ccze -A

