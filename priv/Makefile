APP = erim_xml
REBAR_ROOT_DIR ?= ..

constfiles = \
	$(REBAR_ROOT_DIR)/src/erim_known_attrs.erl \
	$(REBAR_ROOT_DIR)/src/erim_known_elems.erl \
	$(REBAR_ROOT_DIR)/src/erim_known_nss.erl \
	$(REBAR_ROOT_DIR)/include/internal/erim_known_attrs.hrl \
	$(REBAR_ROOT_DIR)/include/internal/erim_known_elems.hrl \
	$(REBAR_ROOT_DIR)/include/internal/erim_known_nss.hrl

CLEANFILES = $(constfiles)

build=$(REBAR_ROOT_DIR)/priv/erim_known.es

all: $(constfiles)

$(REBAR_ROOT_DIR)/src/erim_known_%.erl: erim_known_%.in $(build)
	@mkdir -p $(@D)
	$(build) $* erl $< > $@

$(REBAR_ROOT_DIR)/include/internal/erim_known_%.hrl: erim_known_%.in $(build)
	@mkdir -p $(@D)
	$(build) $* hrl $< > $@

clean:
	-rm -f $(CLEANFILES)

.PHONY: all clean
