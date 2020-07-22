.PHONY = all clean

VER_ARG =
ifdef version
VER_ARG = -v $(version)
endif

update:
	cd tools && sh update_oh_firmware.sh ge21 $(VER_ARG)
	cd tools && sh update_oh_firmware.sh ge11 -l long $(VER_ARG)
	cd tools && sh update_oh_firmware.sh ge11 -l short $(VER_ARG)

clean:
	rm -rf VivadoProject/

all:  update create synth impl

create: create_oh21-200 create_oh11-long create_oh11-short
synth: synth_oh21-200 synth_oh11-long synth_oh11-short
impl: impl_oh21-200 impl_oh11-long impl_oh11-short

oh21:  oh21-200 oh21-75
oh21-200:  create_oh21-200 synth_oh21-200 impl_oh21-200
oh21-75:  create_oh21-75 synth_oh21-75 impl_oh21-75
oh11-long:  create_oh11-long synth_oh11-long impl_oh11-long
oh11-short:  create_oh11-short synth_oh11-short impl_oh11-short

################################################################################
# Create
################################################################################

create_oh21: create_oh21-200 create_oh21-75
synth_oh21: synth_oh21-200 synth_oh21-75
impl_oh21: impl_oh21-200 impl_oh21-75

################################################################################
# Ohnerics
################################################################################

create_%:
	time Hog/CreateProject.sh $(patsubst create_%,%,$@)

synth_%: create_%
	time Hog/LaunchSynthesis.sh $(patsubst synth_%,%,$@)

impl_%: create_% synth_%
	time Hog/LaunchImplementation.sh $(patsubst impl_%,%,$@)
