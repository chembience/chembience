#!/bin/bash

groupadd -g $CHEMBIENCE_GID $CHEMBIENCE_USER && \
    useradd --shell /bin/bash -u $CHEMBIENCE_UID -g $CHEMBIENCE_GID -o -c "" -M $CHEMBIENCE_USER


export PYTHONPATH=/home/app:/home/share:$PYTHONPATH

exec "$@"

