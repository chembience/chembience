#!/bin/bash
set -e  # Exit immediately on error

echo "🔧 Entrypoint started..."
echo "Running as UID: $(id -u), GID: $(id -g)"
echo "CHEMBIENCE_UID: ${CHEMBIENCE_UID}, CHEMBIENCE_GID: ${CHEMBIENCE_GID}"

# Create user and group if they don't exist
if ! id "app" >/dev/null 2>&1; then
    echo "➕ Creating user 'app' (UID: $CHEMBIENCE_UID, GID: $CHEMBIENCE_GID)..."
    groupadd -g "$CHEMBIENCE_GID" app
    useradd --shell /bin/bash -u "$CHEMBIENCE_UID" -g "$CHEMBIENCE_GID" -o -c "" -M app
else
    echo "✅ User 'app' already exists."
fi

mkdir -p /home/app

# Initialize the Django project if not present
if [ ! -d /home/app/appsite ]; then
    echo "📦 Initializing Django project in /home/app..."

    cd /home/app

    echo "🚀 Running django-admin startproject with custom template..."
    django-admin startproject appsite --template=/home/template

    echo "📁 Creating backup directory..."
    mkdir -p backup

    echo "📋 Copying starter files (non-overwriting)..."
    cp -n /env /home/app/.env || echo "⚠️  .env already exists, skipping"
    cp -n /home/template/manage /home/app || echo "⚠️  manage already exists, skipping"
    cp -n /docker-compose.yml /home/app || echo "⚠️  docker-compose.yml already exists, skipping"

    echo "🔒 Setting ownership to app:app..."
    chown -R app:app /home/app
else
    echo "✅ Django project already initialized. Skipping setup."
fi

# Move into the Django project directory
cd /home/app/appsite

echo "🚦 Starting main process: $*"
exec "$@"
