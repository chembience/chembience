#!/bin/bash

groupadd -g $CHEMBIENCE_GID app && \
    useradd --shell /bin/bash -u $CHEMBIENCE_UID -g $CHEMBIENCE_GID -o -c "" -M app


export PYTHONPATH=/home/app:/home/share:$PYTHONPATH

exec "$@"

