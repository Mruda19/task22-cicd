#!/bin/bash
set -e

REGION=ap-southeast-1
REPOSITORY_NAME=hello-repo
CONTAINER_NAME=hello-container

ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
IMAGE=$ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/$REPOSITORY_NAME:latest

echo "Stopping old container if exists..."
docker stop $CONTAINER_NAME || true
docker rm $CONTAINER_NAME || true

echo "Logging into ECR..."
aws ecr get-login-password --region $REGION | \
docker login --username AWS --password-stdin $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com

echo "Pulling latest image..."
docker pull $IMAGE

echo "Starting new container..."
docker run -d -p 80:5000 --name $CONTAINER_NAME $IMAGE

echo "Deployment completed successfully."