#!/bin/bash
set -e

# Define Docker container name and image
CONTAINER_NAME="my-container"
IMAGE_NAME="govio/devops-build:latest"  # You can update this dynamically based on branch or other criteria

# Stop and remove any running container with the same name
docker stop $CONTAINER_NAME || true
docker rm $CONTAINER_NAME || true

# Run the new container from the latest image
docker run -d --name $CONTAINER_NAME -p 8081:80 $IMAGE_NAME

echo "Deployment complete!"

