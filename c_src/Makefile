APP = erim_xml
REBAR_ROOT_DIR ?= ..
REBAR_BUILD_DIR ?= ../build/_default

CC ?= gcc

builddir = $(REBAR_BUILD_DIR)/lib/$(APP)/priv/lib
ports = erim_xml_libxml2.so erim_xml_expat.so erim_xml_expat_legacy.so

check-defined = $(if $(strip $($1)),,$(error "$1" is not defined))

$(call check-defined ERLANG_ROOT_DIR)
$(call check-defined ERLANG_ERTS_VER)
$(call check-defined ERLANG_LIB_DIR_erl_interface)
$(call check-defined ERLANG_LIB_VER_erl_interface)

CFLAGS ?= -O3 -std=c99 -finline-functions -Wall -Wmissing-prototypes -fPIC
CFLAGS += -I$(ERLANG_ROOT_DIR)/erts-$(ERLANG_ERTS_VER)/include -I$(ERLANG_LIB_DIR_erl_interface)/include

LDFLAGS ?= -shared
LDFLAGS += -L$(ERLANG_LIB_DIR_erl_interface)/lib -lerl_interface -lei -lei_st

all: $(ports)

erim_xml_expat.so: $(builddir)/erim_xml_expat.so
erim_xml_expat_legacy.so: $(builddir)/erim_xml_expat_legacy.so
erim_xml_libxml2.so: $(builddir)/erim_xml_libxml2.so

$(builddir)/erim_xml_expat.so: erim_driver.o erim_xml.o erim_xml_expat.o
	@mkdir -p $(builddir)
	$(CC) $^ $(LDFLAGS) $(EXPAT_LDFLAGS) -o $@

$(builddir)/erim_xml_expat_legacy.so: erim_driver.o erim_xml.o erim_xml_legacy.o
	@mkdir -p $(builddir)
	$(CC) $^ $(LDFLAGS) $(EXPAT_LDFLAGS) -o $@

$(builddir)/erim_xml_libxml2.so: erim_driver.o erim_xml.o erim_xml_libxml2.o
	@mkdir -p $(builddir)
	$(CC) $^ $(LDFLAGS) $(XML2_LIBS) -o $@

%.o: %.c
	$(CC) $(CFLAGS) $(XML2_CFLAGS) $(EXPAT_CFLAGS) -c $<

clean:
	-rm -f $(addprefix $(builddir)/,$(ports))

.PHONY: all compile clean
