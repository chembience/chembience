#!/bin/bash
set -e

if ! id "app" >/dev/null 2>&1; then
    groupadd -g "$CHEMBIENCE_GID" app && \
    useradd --shell /bin/bash -u "$CHEMBIENCE_UID" -g "$CHEMBIENCE_GID" -o -c "" -M app
fi



mkdir -p /home/app

chown -R app:app /home/app
cd /home/app
#gosu app source activate chembience
gosu app django-admin startproject appsite --template=/home/template
gosu app mkdir -p backup

#chown -R app.app appsite backup
echo `whoami`

exec "$@"

