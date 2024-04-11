# module name (the prefix verilator generates, namely the `xxx` in `Vxxx.h`)
MODULE:=top

# multithreaded simulation model
THREADS:=1

# use this option to specify the top module, remove all other top modules
# should correspond to `MODULE` otherwise this makefile won't work
# left empty to not use
TOPMODULE:=

# default is `obj_dir`
MDIR:=

VSRC_D:=.
VSRC_D_RECUR:=vsrc
CSRC_D:=.
CSRC_D_RECUR:=csrc

SIM_FLAGS:=+trace

WAVE:=waveform.vcd

# tell `V$(MODULE).mk` to generate debuging information
# export CXXFLAGS+=-g
