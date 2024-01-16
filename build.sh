#!/bin/bash

# Define your Docker image names
X11_SERVER_IMAGE="x11-server-image"
APP_CONTAINER_IMAGE="app-container-image"

docker network create x11-network

# Build Docker images
echo "Building X11 Server Docker image..."
docker build -t $X11_SERVER_IMAGE ./x11

echo "Building Application Docker image..."
docker build -t $APP_CONTAINER_IMAGE ./app
