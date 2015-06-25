APP = erim_xml
REBAR_ROOT_DIR ?= ..
REBAR_SRC_DIRS ?= $(REBAR_ROOT_DIR)/src

srcdir = $(shell echo $(REBAR_SRC_DIRS) | awk -F ':' '{print $$1}')
includedir = $(abspath $(srcdir)/../include)
privdir = $(abspath $(srcdir)/../priv)

constfiles = \
	$(srcdir)/erim_known_attrs.erl \
	$(srcdir)/erim_known_elems.erl \
	$(srcdir)/erim_known_nss.erl \
	$(includedir)/internal/erim_known_attrs.hrl \
	$(includedir)/internal/erim_known_elems.hrl \
	$(includedir)/internal/erim_known_nss.hrl

CLEANFILES = $(constfiles)

build=$(privdir)/erim_known.es

all: $(constfiles)

$(srcdir)/erim_known_%.erl: erim_known_%.in $(build)
	@mkdir -p $(@D)
	$(build) $* erl $< > $@

$(includedir)/internal/erim_known_%.hrl: erim_known_%.in $(build)
	@mkdir -p $(@D)
	$(build) $* hrl $< > $@

clean:
	-rm -f $(CLEANFILES)

.PHONY: all clean
