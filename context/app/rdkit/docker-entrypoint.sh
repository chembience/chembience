#!/bin/bash
set -e

if ! id "app" >/dev/null 2>&1; then
    groupadd -g $CHEMBIENCE_GID app && \
    useradd --shell /bin/bash -u $CHEMBIENCE_UID -g $CHEMBIENCE_GID -o -c "" -M app
fi

export PYTHONPATH=/home/app:/share:$PYTHONPATH

gosu app "$@"

