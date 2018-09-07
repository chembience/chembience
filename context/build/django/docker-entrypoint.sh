#!/bin/bash
set -e

echo "Initializing Django app container using UID $CHEMBIENCE_UID : GID $CHEMBIENCE_GID"

if id "app" >/dev/null 2>&1; then
    echo "User exists, skipping creation."
else
    echo "Creating user ..." && \
    groupadd -g $CHEMBIENCE_GID app && \
    useradd --shell /bin/bash -u $CHEMBIENCE_UID -g $CHEMBIENCE_GID -o -c "" -M app && \
    export HOME=/home/app && \
    echo "Done."
fi

if [ -z "$(ls -A /home/app)" ]; then
    echo "Initializing home directory for django app ..."
    cp -rf /opt/django/* /home/app/
    mv /home/app/app-context/* /home/app/
    mv /home/app/project-template/appsite/ /home/app/appsite
    mv /home/app/env /home/app/.env
    mv /home/app/circleci /home/app/.circleci
    rm -rf /home/app/docker-compose.init.yml /home/app/project-template /home/app/app-context
    chown -R $CHEMBIENCE_UID:$CHEMBIENCE_GID /home/app
    echo "Done."
else
    echo "Django app home directory isn't empty; skipping initializing content there"
fi

exec "$@"
