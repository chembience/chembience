#!/bin/bash
set -e

if ! id "app" >/dev/null 2>&1; then
    groupadd -g "$CHEMBIENCE_GID" app && \
    useradd --shell /bin/bash -u "$CHEMBIENCE_UID" -g "$CHEMBIENCE_GID" -o -c "" -M app
fi

if [ ! -d /home/app/appsite ]; then
  echo "Creating appsite directory ..."
  cd /home/app
  django-admin startproject appsite --template=/home/template &&
  mkdir backup
  chown -R app:app /home/app
fi

cd /home/app/appsite

exec "$@"

