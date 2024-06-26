# the master module name
MASTER:=cputs

# multithreaded simulation model
THREADS:=1

MDIR:=obj_dir

# ANYTHING under `INC_D` will be regarded as header files!
# including `.h`, `.hpp` and cxx-style `algorithm`
# would not search recursively, specify each instead
INC_D:=include
# would not search recursively, specify each instead
LIB_D:=lib

# after the `RAW_WAVE` file is generated by user's program,
# mv it into `WAVE_D` and rename it corresponding to current modulename
WAVE_D:=wave
RAW_WAVE:=waveform.vcd

# MCXXFLAGS+=-g
MCXXFLAGS+=-std=gnu++23
MLDFLAGS+=

SIM_FLAGS:=+trace

# compile all the files in this directory as a single module, recursively searching
MASTER_D:=master

# treat every directory under this directory as a sub module,
# with a modulename the same as its directory name,
# use argument `submodule` to specify which to compile
# `submodule` take precedence of `nvboard`
SUB_D:=sub

# treat every directory under this directory as a nvboard module,
# with a modulename the same as its directory name,
# use argument `nvboard` to specify which to compile
# `submodule` take precedence of `nvboard`
#
# when using nvboard, the lib file `libnvboard.a` under LIB_D is required
# however no need to set MLDFLAGS mannally
NVB_D:=nvb
