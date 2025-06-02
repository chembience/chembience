#!/bin/bash
set -e

if ! id "app" >/dev/null 2>&1; then
    groupadd -g $CHEMBIENCE_GID app && \
    useradd --shell /bin/bash -u $CHEMBIENCE_UID -g $CHEMBIENCE_GID -o -c "" -M app
fi

if [ ! -d "/home/postgres/postgres_data" ]; then
    gosu app initdb -D /home/postgres/postgres_data
fi

exec gosu app postgres -D /home/postgres/postgres_data




dyvfsf