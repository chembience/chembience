#!/bin/bash
set -e

source .env

docker-compose -f $DJANGO_APP_HOME/docker-compose.yml down
docker-compose -f $RDKIT_APP_HOME/docker-compose.yml down
docker-compose -f $JUPYTER_APP_HOME/docker-compose.yml down
docker-compose -f $CHEMBIENCE_SPHERE/docker-compose.yml down


rm -rf $CHEMBIENCE_SPHERE \
&& rm -rf $DJANGO_APP_HOME \
&& rm -rf $RDKIT_APP_HOME \
&& rm -rf $JUPYTER_APP_HOME
