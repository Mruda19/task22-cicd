#!/bin/bash
set -e

REGION=ap-south-1
REPOSITORY_NAME=hello-repo
CONTAINER_NAME=hello-container

ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
IMAGE=$ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/$REPOSITORY_NAME:latest

docker stop $CONTAINER_NAME || true
docker rm $CONTAINER_NAME || true

aws ecr get-login-password --region $REGION | \
docker login --username AWS --password-stdin $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com

docker pull $IMAGE

docker run -d -p 80:5000 --name $CONTAINER_NAME $IMAGE