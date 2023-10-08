HEADERDIR=.
SRCDIR=.
BUILDDIR=.

vpath %.h $(HEADERDIR)
vpath %.c $(SRCDIR)
vpath %.S $(SRCDIR)
vpath %.o $(BUILDDIR)

CROSSCOMPILE=
CC=$(CROSSCOMPILE)gcc
GDB=$(CROSSCOMPILE)gdb
OBJDUMP=$(CROSSCOMPILE)objdump
OBJCOPY=$(CROSSCOMPILE)objcopy

CFLAGS=-Wall -O2

TARGETS=

SRCS_C=$(wildcard *.c)
SRCS_ASM=$(wildcard *.S)
OBJS=$(patsubst %.c,%.o,$(SRCS_C))
OBJS+=$(patsubst %.S,%.o,$(SRCS_ASM))

.PHONY: all
all: $(TARGETS)
	@echo 'Done'

$(TARGETS): $(OBJS)
	$(CC) -o $@ $^ $(CFLAGS)

%.o:
	$(CC) -o $@ -c $< $(CFLAGS)

$(patsubst %.c,%.d,$(SRCS_C)): %.d: %.c
	@set -e; rm -f $@; \
	 $(CC) -MM $< $(INCFLAGS) > $@.$$$$; \
	 sed 's,\($*\.o\)[ :]*,\1 $@ : ,g' < $@.$$$$ > $@; \
	 rm -f $@.$$$$

$(patsubst %.S,%.d,$(SRCS_ASM)): %.d: %.S
	@set -e; rm -f $@; \
	 $(CC) -MM $< $(INCFLAGS) > $@.$$$$; \
	 sed 's,\($*\.o\)[ :]*,\1 $@ : ,g' < $@.$$$$ > $@; \
	 rm -f $@.$$$$

.PHONY: clean
clean:
	rm -f $(OBJS) $(patsubst %.o,%.d,$(OBJS)){,.*}

-include $(patsubst %.o,%.d,$(OBJS))
