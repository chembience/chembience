#!/bin/bash
set -e

if ! id "app" >/dev/null 2>&1; then
    groupadd -g $CHEMBIENCE_GID app && \
    useradd --shell /bin/bash -u $CHEMBIENCE_UID -g $CHEMBIENCE_GID -o -c "" -M app
fi

export PYTHONPATH=/home/app:/share:$PYTHONPATH

mkdir -p /home/app/notebooks
chown -R app.app /home/app/notebooks

touch /home/app/jupyter.log
chown app.app /home/app/jupyter.log

exec "$@"

