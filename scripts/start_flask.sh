#!/bin/bash
# scripts/start_flask.sh

REPOSITORY_URI=989615686095.dkr.ecr.ap-southeast-1.amazonaws.com/hello-repo
IMAGE_TAG=latest
CONTAINER_NAME=my-flask-app
PORT=5000

echo "Stopping any existing container..."
docker rm -f $CONTAINER_NAME 2>/dev/null || true

echo "Logging into ECR..."
aws ecr get-login-password --region ap-southeast-1 | docker login --username AWS --password-stdin $REPOSITORY_URI

echo "Pulling the latest image..."
docker pull $REPOSITORY_URI:$IMAGE_TAG

echo "Running container..."
docker run -d --name $CONTAINER_NAME -p $PORT:5000 $REPOSITORY_URI:$IMAGE_TAG

echo "Container started successfully!"