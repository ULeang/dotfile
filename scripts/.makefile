TARGETD=.
HEADERD=.
SRCD=.
BUILDD=.
DEPD=.

TARGETS=
CROSSCOMPILE=
CFLAGS=-O0 -g -Wall
CPPFLAGS=
ASFLAGS=
LDFLAGS=

INCFLAGS=-I$(HEADERD)

CFLAGS+=$(INCFLAGS)

vpath %.h $(HEADERD)
vpath %.c $(SRCD)
vpath %.S $(SRCD)
vpath %.o $(BUILDD)
vpath %.d $(DEPD)
vpath %   $(TARGETD)

CC=$(CROSSCOMPILE)gcc
AS=$(CROSSCOMPILE)as
LD=$(CROSSCOMPILE)ld
GDB=$(CROSSCOMPILE)gdb
OBJDUMP=$(CROSSCOMPILE)objdump
OBJCOPY=$(CROSSCOMPILE)objcopy

SRCS_C=$(notdir $(wildcard $(SRCD)/*.c))
SRCS_ASM=$(notdir $(wildcard $(SRCD)/*.S))
OBJS=$(patsubst %.c,%.o,$(SRCS_C))
OBJS+=$(patsubst %.S,%.o,$(SRCS_ASM))
DEPS=$(patsubst %.o,%.d,$(OBJS))

.PHONY: all
all: $(TARGETS)
	@echo 'Done'

$(TARGETS): $(OBJS)
	@$(CC) -o $(TARGETD)/$@ $(addprefix $(BUILDD)/,$^) $(CPPFLAGS) $(CFLAGS)

%.o: %.c
	@$(CC) -o $(BUILDD)/$@ -c $< $(CPPFLAGS) $(CFLAGS)

%.o: %.S
	@$(CC) -o $(BUILDD)/$@ -c $< $(CPPFLAGS) $(CFLAGS)

%.d: %.c
	@set -e; rm -f $(DEPD)/$@; \
	 $(CC) -MM -MF $(DEPD)/$@.$$$$ $< $(CFLAGS); \
	 sed 's,\($*\.o\)[ :]*,\1 $@ : ,g' < $(DEPD)/$@.$$$$ > $(DEPD)/$@; \
	 rm -f $(DEPD)/$@.$$$$

%.d: %.S
	@set -e; rm -f $(DEPD)/$@; \
	 $(CC) -MM -MF $(DEPD)/$@.$$$$ $< $(CFLAGS); \
	 sed 's,\($*\.o\)[ :]*,\1 $@ : ,g' < $(DEPD)/$@.$$$$ > $(DEPD)/$@; \
	 rm -f $(DEPD)/$@.$$$$

.PHONY: clean
clean:
	@rm -f $(addprefix $(TARGETD)/,$(TARGETS)) $(addprefix $(BUILDD)/,$(OBJS)) $(addprefix $(DEPD)/,$(DEPS))
	@echo 'Done'

-include $(DEPS)
