REBAR_ROOT_DIR ?= .
REBAR_BUILD_DIR ?= _build/default

REBAR = $(shell which rebar3 || $(REBAR_ROOT_DIR)/rebar3)

all: compile

compile: configure
	$(REBAR) compile

configure: .econfig

.econfig: rebar.config rebar.lock
	$(REBAR) econfig configure

rebar.lock: rebar.config
	$(REBAR) lock

clean:
	$(REBAR) clean

distclean: clean
	-rm -f .econfig

.PHONY: all configure compile clean
