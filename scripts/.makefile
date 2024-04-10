# TODO:the master bin name
MASTER:=sample
# TODO:where to place the master bin
MASTER_D:=.
# TODO:the master src name, with a `main` entry
MASTER_SRC_NAME:=main.c
# TODO:where to search the master src
MASTER_SRC_D:=. src

# TODO:pass to CC with `-I` option
INC_D:=. include
# TODO:pass to CC with `-L` option
LIB_D:=. lib

# TODO:where to search the src with a suffix `.c`, these files are those without a `main` entry
SRC_D:=.
# TODO:recursively add all non-empty directories into `SRC_D`, including self
SRC_D_RECUR:=src
# TODO:exclude where not to search the src
SRC_D_EXCLU:=src/bin
# TODO:recursively exclude where not to search the src
SRC_D_EXCLU_RECUR:=

# TODO:similar to `SRC_D`, but is for assembly with a suffix `.S`
ASM_D:=.
ASM_D_RECUR:=src/asm
ASM_D_EXCLU:=
ASM_D_EXCLU_RECUR:=

# TODO:where to place the intermediate files
BUILD_D:=build
# TODO:sub directory under `BUILD_D` to place the object files with a suffix `.o`
BUILD_OBJ:=obj
# TODO:sub directory under `BUILD_D` to place the dependency files with a suffix `.d`
BUILD_DEP:=dep

# TODO:where to search the bins' src, each of which with a `main` entry, and will be compiled into seperate executables
BIN_SRC_D:=src/bin
# TODO:where to place the bins
BIN_D:=bin

# TODO:similar to `BIN_SRC_D`, but under the notion of `test` with a different way to execute
TEST_SRC_D:=test
TEST_D:=bin/test

# TODO:the `.so` file to build, if left empty, no lib will be generate
LIBSO:=
# TODO:the `.a` file to build, if left empty, no lib will be generate
LIBA:=
# TODO:where to place the generated lib files
LIB_BIN_D:=bin/lib

# TODO:options passed to CC
CFLAGS:=-O0 -g -Wall -Wextra
# TODO:options passed to CC, when the `RELEASE` argument is not empty
CFLAGS_RELEASE:=-O2 -DNDEBUG
# TODO:libs to link, names listed here will be packed into `-lx` option and passed to CC
LIBS:=
# TODO:the `-std=` option passed to CC
STD:=gnu17

# PASS TO CC WHEN CREATE SO
CCSOFLAGS:=-fPIC
# PASS TO AR
ARFLAGS:=
# PASS TO C PRE-PROCESSOR
CPPFLAGS:=
# PASS TO AS
ASFLAGS:=
# PASS TO LD
LDFLAGS:=
# crosscompile prefix to form the tool-chain, such as `riscv64-linux-gnu-`
CROSSCOMPILE:=

CC:=$(CROSSCOMPILE)gcc
AS:=$(CROSSCOMPILE)as
AR:=$(CROSSCOMPILE)ar
LD:=$(CROSSCOMPILE)ld
GDB:=$(CROSSCOMPILE)gdb
OBJDUMP:=$(CROSSCOMPILE)objdump
OBJCOPY:=$(CROSSCOMPILE)objcopy
VALGRIND:=valgrind

SRC_D+=$(foreach d,$(SRC_D_RECUR),$(shell zsh -c 'echo $(d)/**/*(FN)'))
SRC_D+=$(SRC_D_RECUR)
SRC_D:=$(filter-out $(foreach d,$(SRC_D_EXCLU_RECUR),$(shell zsh -c 'echo $(d)/**/*(FN)')) $(SRC_D_EXCLU_RECUR),$(SRC_D))
SRC_D:=$(filter-out $(SRC_D_EXCLU),$(SRC_D))

ASM_D+=$(foreach d,$(ASM_D_RECUR),$(shell zsh -c 'echo $(d)/**/*(FN)'))
ASM_D+=$(ASM_D_RECUR)
ASM_D:=$(filter-out $(foreach d,$(ASM_D_EXCLU_RECUR),$(shell zsh -c 'echo $(d)/**/*(FN)')) $(ASM_D_EXCLU_RECUR),$(ASM_D))
ASM_D:=$(filter-out $(ASM_D_EXCLU),$(ASM_D))

BUILD_OBJ_D:=$(BUILD_D)/$(BUILD_OBJ)
BUILD_DEP_D:=$(BUILD_D)/$(BUILD_DEP)

CFLAGS:=$(if $(RELEASE),$(CFLAGS_RELEASE),$(CFLAGS))
CFLAGS+=$(addprefix -I,$(INC_D))
CFLAGS+=$(addprefix -L,$(LIB_D))
CFLAGS+=$(addprefix -l,$(LIBS))
CFLAGS+=$(addprefix -std=,$(STD))

vpath $(MASTER_SRC) $(MASTER_SRC_D)
vpath %.o $(BUILD_OBJ_D)
vpath %.d $(BUILD_DEP_D)
vpath %.c $(SRC_D) $(BIN_SRC_D) $(TEST_SRC_D)
vpath %.S $(ASM_D)
vpath %.h $(INC_D)

MASTER_SRC:=$(wildcard $(addsuffix /$(MASTER_SRC_NAME),$(MASTER_SRC_D)))
ifeq ($(words $(MASTER_SRC)),0)
MASTER_BIN:=
else ifeq ($(words $(MASTER_SRC)),1)
MASTER_BIN:=$(addprefix $(MASTER_D)/,$(MASTER))
else
MASTER_BIN:=$(error multiple `$(MASTER_SRC_NAME)` found!)
endif
MASTER_OBJ:=$(patsubst %.c,$(BUILD_OBJ_D)/%.o,$(MASTER_SRC_NAME))
MASTER_DEP:=$(patsubst %.c,$(BUILD_DEP_D)/%.d,$(MASTER_SRC_NAME))

SO_FILE:=$(addprefix $(LIB_BIN_D)/,$(LIBSO))
A_FILE:=$(addprefix $(LIB_BIN_D)/,$(LIBA))

BINS_SRC:=$(filter-out $(MASTER_SRC),$(notdir $(wildcard $(addsuffix /*.c,$(BIN_SRC_D)))))
BINS:=$(addprefix $(BIN_D)/,$(patsubst %.c,%,$(BINS_SRC)))
BINS_OBJ:=$(patsubst %.c,$(BUILD_OBJ_D)/%.o,$(BINS_SRC))
BINS_DEP:=$(patsubst %.c,$(BUILD_DEP_D)/%.d,$(BINS_SRC))

TEST_SRC:=$(filter-out $(MASTER_SRC),$(notdir $(wildcard $(addsuffix /*.c,$(TEST_SRC_D)))))
TEST_BIN:=$(addprefix $(TEST_D)/,$(patsubst %.c,%,$(TEST_SRC)))
TEST_OBJ:=$(patsubst %.c,$(BUILD_OBJ_D)/%.o,$(TEST_SRC))
TEST_DEP:=$(patsubst %.c,$(BUILD_DEP_D)/%.d,$(TEST_SRC))

SRC:=$(filter-out $(MASTER_SRC),$(notdir $(wildcard $(addsuffix /*.c,$(SRC_D)))))
ASM:=$(filter-out $(MASTER_SRC),$(notdir $(wildcard $(addsuffix /*.S,$(ASM_D)))))
OBJ:=$(patsubst %.c,$(BUILD_OBJ_D)/%.o,$(SRC))
OBJ+=$(patsubst %.S,$(BUILD_OBJ_D)/%.o,$(ASM))
DEP:=$(patsubst %.c,$(BUILD_DEP_D)/%.d,$(SRC))
DEP+=$(patsubst %.S,$(BUILD_DEP_D)/%.d,$(ASM))

.PHONY: all
all: $(MASTER_BIN) $(BINS) $(TEST_BIN) $(SO_FILE) $(A_FILE)

$(MASTER_BIN): $(MASTER_OBJ) $(OBJ)
	@$(CC) -o $@ $^ $(CPPFLAGS) $(CFLAGS)

$(BINS): $(BIN_D)/%: $(BUILD_OBJ_D)/%.o $(OBJ)
	@$(CC) -o $@ $^ $(CPPFLAGS) $(CFLAGS)

$(TEST_BIN): $(TEST_D)/%: $(BUILD_OBJ_D)/%.o $(OBJ)
	@$(CC) -o $@ $^ $(CPPFLAGS) $(CFLAGS)

$(SO_FILE): $(OBJ)
	@$(CC) -o $@ -shared $^ $(CPPFLAGS) $(CFLAGS) $(CCSOFLAGS)
$(A_FILE): $(OBJ)
	@$(AR) rcs $@ $^ $(ARFLAGS)

$(BUILD_OBJ_D)/%.o: %.c
	@$(CC) -o $@ -c $< $(CPPFLAGS) $(CFLAGS)
$(BUILD_OBJ_D)/%.o: %.S
	@$(CC) -o $@ -c $< $(CPPFLAGS) $(CFLAGS)

# FIX: the `.`, `/` and many chars in `BUILD_D` will interfere sed's behaviour, avoid them
fixsedcmd=$(subst /,\/,$(patsubst ./%,%,$(1)))
__use_by_sed_dep:=$(call fixsedcmd,$(BUILD_DEP_D))
__use_by_sed_obj:=$(call fixsedcmd,$(BUILD_OBJ_D))
$(BUILD_DEP_D)/%.d: %.c
	@set -e; rm -f $@; \
		$(CC) -MM -MF $@ $< $(CFLAGS); \
		sed -i 's/\(.\+\)\.o:.*/$(__use_by_sed_dep)\/\1\.d $(__use_by_sed_obj)\/\0/' $@
$(BUILD_DEP_D)/%.d: %.S
	@set -e; rm -f $@; \
		$(CC) -MM -MF $@ $< $(CFLAGS); \
		sed -i 's/\(.\+\)\.o:.*/$(__use_by_sed_dep)\/\1\.d $(__use_by_sed_obj)\/\0/' $@

# HACK:USE ENV-VAR `RUN` and `WITHARG` TO SET THE PROG TO RUN
ifeq ($(RUN),)
TARGET=./$(patsubst ./%,%,$(if $(MASTER_BIN),$(MASTER_BIN),$(error no master bin!use `RUN` and `WITHARG` to set target to run!))) $(WITHARG)
else
TARGET=./$(patsubst ./%,%,$(BIN_D))/$(RUN) $(WITHARG)
endif
.PHONY: run
run: all
	@$(TARGET)

# HACK:USE ENV-VAR `TOOLARG` TO SET THE TOOL ARGS TO RUN
.PHONY: valgrind
valgrind: all
	@$(VALGRIND) $(TOOLARG) --track-origins=yes $(TARGET)

.PHONY: debug
debug: all
	@$(GDB) $(TOOLARG) -q --args $(TARGET)

.PHONY: test
test: $(TEST_BIN)
ifeq ($(TEST),)
	$(error no test set, use env-var `TEST` and `TESTARG`)
else
	./$(patsubst ./%,%,$(TEST_D))/$(TEST) $(TESTARG)
endif

.PHONY: valtest
valtest: $(TEST_BIN)
ifeq ($(TEST),)
	$(error no test set, use env-var `TEST` and `TESTARG`)
else
	@$(VALGRIND) $(TOOLARG) --track-origins=yes $(patsubst ./%,%,$(TEST_D))/$(TEST) $(TESTARG)
endif

.PHONY: gdbtest
gdbtest: $(TEST_BIN)
ifeq ($(TEST),)
	$(error no test set, use env-var `TEST` and `TESTARG`)
else
	@$(GDB) $(TOOLARG) -q --args $(patsubst ./%,%,$(TEST_D))/$(TEST) $(TESTARG)
endif

.PHONY: clean
clean:
	@rm -rf $(MASTER_BIN) $(BUILD_D) $(BIN_D) $(TEST_D) $(LIB_BIN_D)

_mk_build_path:=$(shell mkdir -p $(BUILD_OBJ_D) $(BUILD_DEP_D))
ifneq ($(words $(BINS_SRC)),0)
_mk_bin_path:=$(shell mkdir -p $(BIN_D))
endif
ifneq ($(words $(TEST_SRC)),0)
_mk_bin_path:=$(shell mkdir -p $(TEST_D))
endif
ifneq ($(words $(LIBSO)),0)
_mk_bin_path:=$(shell mkdir -p $(LIB_BIN_D))
endif
ifneq ($(words $(LIBA)),0)
_mk_bin_path:=$(shell mkdir -p $(LIB_BIN_D))
endif
ifneq ($(MAKECMDGOALS),clean)
-include $(MASTER_DEP) $(BINS_DEP) $(DEP) $(TEST_DEP)
endif
