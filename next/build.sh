#!/bin/bash
set -e

docker compose build rdkit
docker compose build postgres
docker compose build django