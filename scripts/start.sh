#!/bin/bash

AWS_REGION=ap-southeast-1
ACCOUNT_ID=989615686095
REPOSITORY_NAME=hello-repo

REPOSITORY_URI=$ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$REPOSITORY_NAME

echo "Logging into Amazon ECR..."
aws ecr get-login-password --region $AWS_REGION | \
docker login --username AWS --password-stdin $ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com

echo "Pulling latest Docker image..."
docker pull $REPOSITORY_URI:latest

echo "Stopping existing container if running..."
docker stop hello-container || true
docker rm hello-container || true

echo "Starting new container..."
docker run -d -p 5000:5000 --name hello-container \
$REPOSITORY_URI:latest