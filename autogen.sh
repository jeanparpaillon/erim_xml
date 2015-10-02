#!/bin/sh

set -e

(
    cd $(dirname $0) && \
	autoreconf -ivf && \
	./configure $@
)

exit 0
