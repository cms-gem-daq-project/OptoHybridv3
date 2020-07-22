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

all: | update create synth impl

create: create_ge21 create_ge11-long create_ge11-short |
synth: synth_ge21 synth_ge11-long synth_ge11-short |
impl: impl_ge21 impl_ge11-long impl_ge11-short |

ge21: | create_ge21 synth_ge21 impl_ge21
ge21-200: | create_ge21-200 synth_ge21-200 impl_ge21-200
ge21-75: | create_ge21-75 synth_ge21-75 impl_ge21-75
ge11-long: | create_ge11-long synth_ge11-long impl_ge11-long
ge11-short: | create_ge11-short synth_ge11-short impl_ge11-short

################################################################################
# Create
################################################################################

create_ge21: create_ge21-200 create_ge21-75 |

create_ge21-200:
	time Hog/CreateProject.sh oh21

create_ge21-75:
	time Hog/CreateProject.sh oh21-75

create_ge11-long:
	time Hog/CreateProject.sh oh11-long

create_ge11-short:
	time Hog/CreateProject.sh oh11-short

################################################################################
# Create
################################################################################

synth_ge21: synth_ge21-200 synth_ge21-75 |

synth_ge21-200:
	time Hog/LaunchSynthesis.sh oh21

synth_ge21-75:
	time Hog/LaunchSynthesis.sh oh21-75

synth_ge11-long:
	time Hog/LaunchSynthesis.sh oh11-long

synth_ge11-short:
	time Hog/LaunchSynthesis.sh oh11-short

################################################################################
# Implementation
################################################################################

impl_ge21: impl_ge21-200 impl_ge21-75 |

impl_ge21-75:
	time Hog/LaunchImplementation.sh oh21-75

impl_ge21-200:
	time Hog/LaunchImplementation.sh oh21

impl_ge11-long:
	time Hog/LaunchImplementation.sh oh11-long

impl_ge11-short:
	time Hog/LaunchImplementation.sh oh11-short
