#!/bin/bash
set -e

echo "Initializing RDKit app container using UID $CHEMBIENCE_UID : GID $CHEMBIENCE_GID"

if id "app" >/dev/null 2>&1; then
    echo "User exists, skipping creation."
else
    echo "Creating app user ..." && \
    groupadd -g $CHEMBIENCE_GID app && \
    useradd --shell /bin/bash -u $CHEMBIENCE_UID -g $CHEMBIENCE_GID -o -c "" -M app && \
    export HOME=/home/app && \
    echo "Done."
fi

if [ -z "$(ls -A /home/app)" ]; then
    echo "Initializing home directory for RDKit app ..."
    cp -rf /opt/rdkit/* /home/app
    mv /home/app/app-context/* /home/app/
    mv /home/app/env /home/app/.env
    rm -rf /home/app/docker-compose.init.yml /home/app/app-context
    chown -R $CHEMBIENCE_UID:$CHEMBIENCE_GID /home/app
    echo "Done."
else
    echo "RDKit app home directory isn't empty; skipping initializing content there"
fi

exec "$@"
