BINDIR=.
INCLUDEDIR=./header
SRCDIR=./src
BUILDDIR=./build

TARGET=sample
CROSSCOMPILE=
CFLAGS=-O0 -g -Wall
CPPFLAGS=
ASFLAGS=
LDFLAGS=

INCFLAGS=-I$(INCLUDEDIR)

CFLAGS+=$(INCFLAGS)

CC=$(CROSSCOMPILE)gcc
AS=$(CROSSCOMPILE)as
LD=$(CROSSCOMPILE)ld
GDB=$(CROSSCOMPILE)gdb
OBJDUMP=$(CROSSCOMPILE)objdump
OBJCOPY=$(CROSSCOMPILE)objcopy

BINTARGET=$(addprefix $(BINDIR)/,$(TARGET))
SRCS_C=$(wildcard $(SRCDIR)/*.c)
SRCS_ASM=$(wildcard $(SRCDIR)/*.S)
OBJS=$(patsubst %.c,$(BUILDDIR)/%.o,$(notdir $(SRCS_C)))
OBJS+=$(patsubst %.S,$(BUILDDIR)/%.o,$(notdir $(SRCS_ASM)))
DEPS=$(patsubst %.c,$(BUILDDIR)/%.d,$(notdir $(SRCS_C)))
DEPS+=$(patsubst %.S,$(BUILDDIR)/%.d,$(notdir $(SRCS_ASM)))

.PHONY: all
all: $(BINTARGET)

$(BINTARGET): $(OBJS)
	@$(CC) -o $@ $^ $(CPPFLAGS) $(CFLAGS)

$(BUILDDIR)/%.o: $(SRCDIR)/%.c
	@$(CC) -o $@ -c $< $(CPPFLAGS) $(CFLAGS)
$(BUILDDIR)/%.o: $(SRCDIR)/%.S
	@$(CC) -o $@ -c $< $(CPPFLAGS) $(CFLAGS)

$(BUILDDIR)/%.d: $(SRCDIR)/%.c
	@set -e; rm -f $@; \
	 $(CC) -MM -MF $@.$$$$ $< $(CFLAGS); \
	 sed 's,\($*\.o\)[ :]*,$(BUILDDIR)/\1 $@ : ,g' < $@.$$$$ > $@; \
	 rm -f $@.$$$$
$(BUILDDIR)/%.d: $(SRCDIR)/%.S
	@set -e; rm -f $@; \
	 $(CC) -MM -MF $@.$$$$ $< $(CFLAGS); \
	 sed 's,\($*\.o\)[ :]*,$(BUILDDIR)/\1 $@ : ,g' < $@.$$$$ > $@; \
	 rm -f $@.$$$$

.PHONY: run
run: all
	@./$(BINTARGET)

.PHONY: debug
debug: all
	@$(GDB) $(BINTARGET) -q

.PHONY: clean
clean:
	@rm -f $(BINTARGET) $(OBJS) $(DEPS)

-include $(DEPS)
