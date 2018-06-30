#!/bin/bash
set -e

echo "Initializing Jupyter app container using UID $CHEMBIENCE_UID : GID $CHEMBIENCE_GID"

if id "app" >/dev/null 2>&1; then
    echo "User exists, skipping creation."
else
    echo "Creating user ..." && \
    groupadd -g $CHEMBIENCE_GID app && \
    useradd --shell /bin/bash -u $CHEMBIENCE_UID -g $CHEMBIENCE_GID -o -c "" -M app && \
    export HOME=$CHEMBIENCE_HOME && \
    echo "Done."
fi

if [ -z "$(ls -A /home/app)" ]; then
    echo "Initializing home directory for Jupyter app ..."
    cp -rf /opt/jupyter/* /home/app
    mv /home/app/app-context/* /home/app/
    mv /home/app/env /home/app/.env
    rm -rf /home/app/docker-compose.init.yml /home/app/app-context
    mkdir -p /home/app/.local/share/jupyter/kernels
    cp -r /root/.local/share/jupyter/kernels/* /home/app/.local/share/jupyter/kernels
    mkdir -p $JUPYTER_NOTEBOOK_DIR
    chown -R $CHEMBIENCE_UID:$CHEMBIENCE_GID /home/app
    echo "Done."
else
    echo "Jupyter app home directory isn't empty; skipping initializing content there"
fi

exec "$@"
