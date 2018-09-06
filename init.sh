#!/bin/bash

env-prepare.sh

source .env

mkdir -p $CHEMBIENCE_SPHERE \
&& mkdir -p $CHEMBIENCE_SHARE \
&& mkdir -p $DJANGO_APP_HOME \
&& mkdir -p $RDKIT_APP_HOME \
&& mkdir -p $JUPYTER_APP_HOME

docker-compose -f ./context/base/sphere/docker-compose.init.yml run --rm base
docker-compose -f ./context/base/django/docker-compose.init.yml run --rm django
docker-compose -f ./context/base/rdkit/docker-compose.init.yml run --rm rdkit
docker-compose -f ./context/base/jupyter/docker-compose.init.yml run --rm jupyter

cp .env $CHEMBIENCE_SHARE \
&& cp .env $DJANGO_APP_HOME \
&& cp .env $RDKIT_APP_HOME \
&& cp .env $JUPYTER_APP_HOME





