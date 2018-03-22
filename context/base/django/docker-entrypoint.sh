#!/bin/bash

echo "Starting with UID : $CHEMBIENCE_UID : $CHEMBIENCE_GID : $CHEMBIENCE_HOME : $CHEMBIENCE_USER"
if id "$CHEMBIENCE_USER" >/dev/null 2>&1; then
    echo "User exists, skipping creation."
else
    echo "Creating user and environment..."
    groupadd -g $CHEMBIENCE_GID $CHEMBIENCE_USER
    useradd --shell /bin/bash -u $CHEMBIENCE_UID -g $CHEMBIENCE_GID -G root -o -c "" -M $CHEMBIENCE_USER
    export HOME=$CHEMBIENCE_HOME
    chown $CHEMBIENCE_UID:$CHEMBIENCE_GID /home/chembience
fi

if [ -z "$(ls -A /home/app)" ]; then
    echo "Initializing home directory for django app ..."
    cp -rf /opt/django/* /home/app
    mv /home/app/project_template/appsite /home/app
    mv /home/app/app-context/* /home/app/
    mv /home/app/build-app /home/app/build
    mv /home/app/env /home/app/.env
    rm -rf /home/app/docker-entrypoint.sh /home/app/docker-compose.init.yml /home/app/project_template /home/app/app-context
    mv /home/app/docker-compose.app.yml /home/app/docker-compose.yml
    chown -R $CHEMBIENCE_UID:$CHEMBIENCE_GID /home/app
    echo "Done."
else
    echo "Django app home directory isn't empty; skipping initializing content there"
fi

exec "$@"
