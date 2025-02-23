#!/bin/bash
set -e

if ! id "app" >/dev/null 2>&1; then
    groupadd -g $CHEMBIENCE_GID app && \
    useradd --shell /bin/bash -u $CHEMBIENCE_UID -g $CHEMBIENCE_GID -o -c "" -M app
fi

gosu app bash -c "
  initdb -D /home/postgres/postgres_data && \
  pg_ctl -D /home/postgres/postgres_data start
"

echo 'done'
#export PYTHONPATH=/home/app:/share:$PYTHONPATH

#gosu app "$@"

#gosu myuser bash -c "whoami && pwd && ls -l"

