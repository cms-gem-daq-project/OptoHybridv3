.PHONY = all clean

ifdef version
VER_ARG = -v $(version)
else
VER_ARG =
endif

CCZE := $(shell command -v ccze 2> /dev/null)
ifndef CCZE
COLORIZE =
else
COLORIZE = | ccze -A
endif

update:
	@cd tools && sh update_oh_firmware.sh ge21 $(VER_ARG)
	@cd tools && sh update_oh_firmware.sh ge11 -l long $(VER_ARG)
	@cd tools && sh update_oh_firmware.sh ge11 -l short $(VER_ARG)

clean:
	@find . -name "*.jou" -exec rm {} \;

clean_projects:
	rm -rf VivadoProject/

all:  update create synth impl

create: create_oh21-75 create_oh21-200 create_oh11-long create_oh11-short
synth: synth_oh21-75 synth_oh21-200 synth_oh11-long synth_oh11-short
impl: impl_oh21-75 impl_oh21-200 impl_oh11-long impl_oh11-short

oh21: oh21-200 oh21-75
oh21-200: impl_oh21-200
oh21-75: impl_oh21-75
oh11: oh11-long oh11-short
oh11-long: impl_oh11-long
oh11-short: impl_oh11-short

################################################################################
# Create
################################################################################

create_oh21: create_oh21-200 create_oh21-75
synth_oh21: synth_oh21-200 synth_oh21-75
impl_oh21: impl_oh21-200 impl_oh21-75

################################################################################
# Generics
################################################################################

create_%:
	@echo -------------------------------------------------------------------------------- $(COLORIZE)
	@echo Creating Project $(patsubst create_%,%,$@)                                       $(COLORIZE)
	@echo -------------------------------------------------------------------------------- $(COLORIZE)
	@time Hog/CreateProject.sh $(patsubst create_%,%,$@)                                   $(COLORIZE)

synth_%: create_%
	@echo -------------------------------------------------------------------------------  $(COLORIZE)
	@echo Launching Synthesis $(patsubst synth_%,%,$@)                                     $(COLORIZE)
	@echo -------------------------------------------------------------------------------- $(COLORIZE)
	@time Hog/LaunchSynthesis.sh $(patsubst synth_%,%,$@)                                  $(COLORIZE)

impl_%: create_% synth_%
	@echo -------------------------------------------------------------------------------- $(COLORIZE)
	@echo Launching Implementation $(patsubst impl_%,%,$@)                                 $(COLORIZE)
	@echo -------------------------------------------------------------------------------- $(COLORIZE)
	@time Hog/LaunchImplementation.sh $(patsubst impl_%,%,$@                               $(COLORIZE))

