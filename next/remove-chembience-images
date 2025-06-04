#!/bin/bash

# Load environment variables from .env file
if [ -f .env ]; then
  set -o allexport
  source .env
  set +o allexport
else
  echo ".env file not found!"
  exit 1
fi

# Check if CHEMBIENCE_VERSION is set in the .env file
if [ -z "$CHEMBIENCE_VERSION" ]; then
  echo "CHEMBIENCE_VERSION is not set in the .env file"
  exit 1
fi

# Fixed name pattern
NAME_PATTERN="^chembience/"

# Find matching images
IMAGES=$(docker images --format '{{.Repository}}:{{.Tag}} {{.ID}}' | grep -E "$NAME_PATTERN" | grep "$TAG_PATTERN")

if [ -z "$IMAGES" ]; then
  echo "No matching images found for pattern '$NAME_PATTERN' and tag pattern '$TAG_PATTERN'"
  exit 0
fi

echo "Removing matching images:"
echo "$IMAGES"

# Remove each matched image
echo "$IMAGES" | awk '{print $2}' | xargs -r docker rmi -f
