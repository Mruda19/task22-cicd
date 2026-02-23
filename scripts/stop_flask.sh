#!/bin/bash
# scripts/stop_flask.sh

CONTAINER_NAME=my-flask-app

echo "Stopping container if it exists..."
docker rm -f $CONTAINER_NAME 2>/dev/null || true

echo "Container stopped."