#!/bin/bash
set -e

./env-prepare.sh

docker-compose -f ./context/build/docker-compose.build.yml build
docker-compose -f ./context/app/docker-compose.build.yml build
