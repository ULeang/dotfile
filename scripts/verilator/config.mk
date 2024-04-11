################################################################################
# module name (the prefix verilator generates, namely the `xxx` in `Vxxx.h`)
MODULE:=alu

# multithreaded simulation model
THREADS:=

# use this option to specify the top module, remove all other top modules
# should correspond to `MODULE` otherwise this makefile won't work
# left empty to not use
TOPMODULE:=

# default is `obj_dir`
MDIR:=obj_dir

VSRC_D:=.
VSRC_D_RECUR:=vsrc
CSRC_D:=.
CSRC_D_RECUR:=csrc

SIM_FLAGS:=+trace

WAVE:=waveform.vcd
