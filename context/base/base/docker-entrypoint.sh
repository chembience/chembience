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

if [ -z "$(ls -A /home/sphere)" ];  then
    echo "Initialization of Chembience sphere directory ..."
    cp /opt/chembience/bin/* /home/sphere
    cp /opt/chembience/bin/.env /home/sphere
    chown -R $CHEMBIENCE_UID:$CHEMBIENCE_GID /home/sphere
    echo "Done."
else
    echo "Chembience sphere directory isn't empty, skipping initializing content there"
fi

if [ -z "$(ls -A /share)" ];  then
    echo "Initialization of Chembience share directory ..."
    cp -r /opt/pychembience/chembience /share
    chown -R $CHEMBIENCE_UID:$CHEMBIENCE_GID /share
    echo "Done."
else
    echo "Chembience share directory isn't empty, skipping initializing content there"
fi



exec "$@"