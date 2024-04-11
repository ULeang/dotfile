################################################################################
# Check for sanity to avoid later confusion

ifneq ($(words $(CURDIR)),1)
 $(error Unsupported: GNU Make cannot build in directories containing spaces, build elsewhere: '$(CURDIR)')
endif

################################################################################
# Set up variables

# If $VERILATOR_ROOT isn't in the environment, we assume it is part of a
# package install, and verilator is in your path. Otherwise find the
# binary relative to $VERILATOR_ROOT (such as when inside the git sources).
ifeq ($(VERILATOR_ROOT),)
VERILATOR:=verilator
VERILATOR_COVERAGE:=verilator_coverage
else
export VERILATOR_ROOT
VERILATOR:=$(VERILATOR_ROOT)/bin/verilator
VERILATOR_COVERAGE:=$(VERILATOR_ROOT)/bin/verilator_coverage
endif

# Generate C++ in executable form
VERILATOR_FLAGS+=--cc --exe
# Generate makefile dependencies (not shown as complicates the Makefile)
#VERILATOR_FLAGS+=-MMD
# Optimize
VERILATOR_FLAGS+=--x-assign fast
# Warn abount lint issues; may not want this on less solid designs
VERILATOR_FLAGS+=-Wall
# Make waveforms
VERILATOR_FLAGS+=--trace
# Check SystemVerilog assertions
VERILATOR_FLAGS+=--assert
# Generate coverage analysis
VERILATOR_FLAGS+=--coverage
# Run Verilator in debug mode
#VERILATOR_FLAGS+=--debug
# Add this trace to get a backtrace in gdb
#VERILATOR_FLAGS+=--gdbbt

include config.mk

################################################################################

ifeq ($(MDIR),)
MDIR:=obj_dir
endif

VERILATOR_FLAGS+=$(addprefix --top-module ,$(TOPMODULE))
VERILATOR_FLAGS+=$(addprefix --Mdir ,$(MDIR))
VERILATOR_FLAGS+=$(addprefix --threads ,$(THREADS))

VSRC_D+=$(foreach d,$(VSRC_D_RECUR),$(shell zsh -c 'echo $(d)/**/*(FN)'))
VSRC_D+=$(VSRC_D_RECUR)
CSRC_D+=$(foreach d,$(CSRC_D_RECUR),$(shell zsh -c 'echo $(d)/**/*(FN)'))
CSRC_D+=$(CSRC_D_RECUR)

VSRC:=$(wildcard $(addsuffix /*.sv,$(VSRC_D)))
CSRC+=$(wildcard $(addsuffix /*.cpp,$(CSRC_D)))

EXECUTABLE:=$(MDIR)/V$(MODULE)

VERILATOR_INPUT:=$(VSRC) $(CSRC)

default: $(EXECUTABLE)

.PHONY: verilate
verilate:
	@echo
	@echo '### VERILATING ###############'
	@echo
	$(VERILATOR) $(VERILATOR_FLAGS) $(VERILATOR_INPUT)

.PHONY: build
build:
	@echo
	@echo '### BUILDING   ###############'
	@echo
	$(MAKE) -j -C $(MDIR) -f V$(MODULE).mk V$(MODULE)

.PHONY: sim
sim: $(EXECUTABLE)
	@echo
	@echo '### SIMULATING ###############'
	@echo
	./$< $(SIM_FLAGS)

.PHONY: wave
wave: $(WAVE)
	@echo
	@echo '### WAVING     ###############'
	@echo
	gtkwave $^

$(EXECUTABLE): $(VERILATOR_INPUT)
	@echo
	@echo '### VERILATING ###############'
	@echo
	$(VERILATOR) $(VERILATOR_FLAGS) $^
	@echo
	@echo '### BUILDING   ###############'
	@echo
	$(MAKE) -j -C $(MDIR) -f V$(MODULE).mk V$(MODULE)

$(WAVE): $(EXECUTABLE)
	@echo
	@echo '### SIMULATING ###############'
	@echo
	./$< $(SIM_FLAGS)

.PHONY: rewave
rewave: $(EXECUTABLE)
	@echo
	@echo '### SIMULATING - FORCE #######'
	@echo
	./$< $(SIM_FLAGS)
	@echo
	@echo '### WAVING - FORCE    ########'
	@echo
	gtkwave $(WAVE)


.PHONY: lint
lint:
	@echo
	@echo '### LINTING    ###############'
	@echo
	$(VERILATOR) --lint-only $(VSRC)

.PHONY: clean
clean:
	@rm -rf $(MDIR) $(WAVE)
