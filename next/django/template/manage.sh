#!/bin/bash
set -e

echo "Running $@"

docker compose exec django bash -ci "gosu app bash -c 'cd /home/app/appsite && ./manage.py $*'"
