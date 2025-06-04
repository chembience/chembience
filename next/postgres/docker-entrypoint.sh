#!/bin/bash
set -e

echo "🔧 Starting custom Postgres entrypoint..."

echo "📛 CHEMBIENCE_UID=${CHEMBIENCE_UID}, CHEMBIENCE_GID=${CHEMBIENCE_GID}"

# Create user and group if not exist
if ! id "app" >/dev/null 2>&1; then
    echo "➕ Creating user 'app'..."
    groupadd -g "$CHEMBIENCE_GID" app
    useradd --shell /bin/bash -u "$CHEMBIENCE_UID" -g "$CHEMBIENCE_GID" -o -c "" -M app
else
    echo "✅ User 'app' already exists."
fi

# Ensure home and data directories exist
mkdir -p /home/postgres
chown -R "$CHEMBIENCE_UID":"$CHEMBIENCE_GID" /home/postgres

#DATA_DIR="/home/postgres/postgres_data"

if [ ! -d "/home/postgres/postgres_data" ]; then
    echo "🗃 Initializing PostgreSQL data directory ..."
    gosu app initdb -D "/home/postgres/postgres_data"

    echo "⚙️ Replacing PostgreSQL config files if available..."
    if [ -f /postgresql.conf ]; then
        echo "  ✅ Copying custom postgresql.conf"
        cp /postgresql.conf "/home/postgres/postgres_data/postgresql.conf"
    else
        echo "  ⚠️  /postgresql.conf not found, using default"
    fi

    if [ -f /pg_hba.conf ]; then
        echo "  ✅ Copying custom pg_hba.conf"
        cp /pg_hba.conf "/home/postgres/postgres_data/pg_hba.conf"
    else
        echo "  ⚠️  /pg_hba.conf not found, using default"
    fi

    echo "🚀 Starting temporary server to configure initial DB..."
    gosu app pg_ctl -D "/home/postgres/postgres_data" -o "-c listen_addresses='localhost'" -w start

    echo "USER $POSTGRES_USER"
    echo "NAME $POSTGRES_NAME"

    echo "📦 Creating user/database..."
    gosu app psql --username=app --dbname=postgres <<-EOSQL
        CREATE USER $POSTGRES_USER WITH PASSWORD '$POSTGRES_PASSWORD';
        CREATE DATABASE $POSTGRES_NAME OWNER $POSTGRES_USER;
        GRANT ALL PRIVILEGES ON DATABASE $POSTGRES_NAME TO $POSTGRES_USER;
EOSQL

    echo "🛑 Stopping temporary server..."
    gosu app pg_ctl -D "/home/postgres/postgres_data" -m fast -w stop
else
    echo "📂 Using existing data directory"
fi


#echo "🚀 Launching PostgreSQL server..."
#exec gosu app postgres -D "$DATA_DIR"

echo "🚦 Starting postgres main process: $*"
exec "$@"