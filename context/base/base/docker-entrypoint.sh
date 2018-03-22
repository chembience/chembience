#!/bin/bash

echo "Starting with UID : $CHEMBIENCE_UID : $CHEMBIENCE_GID : $CHEMBIENCE_HOME : $CHEMBIENCE_USER"
if id "$CHEMBIENCE_USER" >/dev/null 2>&1; then
    echo "User exists, skipping creation."
else
    echo "Creating user ..." && \
    groupadd -g $CHEMBIENCE_GID $CHEMBIENCE_USER && \
    useradd --shell /bin/bash -u $CHEMBIENCE_UID -g $CHEMBIENCE_GID -o -c "" -M $CHEMBIENCE_USER && \
    export HOME=$CHEMBIENCE_HOME && \
    echo "Done."
fi

if [ -z "$(ls -A /home/chembience)" ];  then
    echo "Initializing home directory for Chembience ..."
    cp /opt/chembience/bin/* /home/chembience
    cp /opt/chembience/bin/.env /home/chembience
    chown -R $CHEMBIENCE_UID:$CHEMBIENCE_GID /home/chembience
    echo "Done."
else
    echo "Chembience home directory isn't empty, skipping initializing content there"
fi



exec "$@"