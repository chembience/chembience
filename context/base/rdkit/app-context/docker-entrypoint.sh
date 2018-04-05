#!/bin/bash

#echo "Starting RDKit app with UID $CHEMBIENCE_UID : GID $CHEMBIENCE_GID"

groupadd -g $CHEMBIENCE_GID $CHEMBIENCE_USER && \
    useradd --shell /bin/bash -u $CHEMBIENCE_UID -g $CHEMBIENCE_GID -o -c "" -M $CHEMBIENCE_USER

export PYTHONPATH=/home/app:/opt/share:$PYTHONPATH

gosu chembience "$@"

