#!/bin/bash
set -e

cp env .env

docker compose build rdkit
docker compose build postgres
docker compose build django