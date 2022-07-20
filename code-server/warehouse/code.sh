#!/bin/bash
# Script that mimics the open-from-stdin functionality of VSCode
if [ "$1" == "-" ]; then
    TEMP=$(mktemp /tmp/stdin_XXXXXX)
    cat > "$TEMP"
    exec code-server -r "$TEMP"
    exit 0
fi;

# Pass through everything else to `code-server`
# Shellcheck SC2068 = quoting variables to prevent globbing - we want that here.
# shellcheck disable=SC2068
exec code-server $@