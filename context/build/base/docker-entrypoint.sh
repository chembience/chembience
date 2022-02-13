#!/bin/bash
set -e

echo "Initialization of base container using UID : $CHEMBIENCE_UID : $CHEMBIENCE_GID"

if id "app" >/dev/null 2>&1; then
    echo "User exists, skipping creation."
else
    echo "Creating app user ..." && \
    groupadd -g $CHEMBIENCE_GID app && \
    useradd --shell /bin/bash -u $CHEMBIENCE_UID -g $CHEMBIENCE_GID -o -c "" -M app && \
    export HOME=/home/app && \
    echo "Done."
fi

exec "$@"