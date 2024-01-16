#!/bin/bash

# Define your Docker image names
X11_SERVER_IMAGE="x11-server-image-$(id -u)"
APP_CONTAINER_IMAGE="app-container-image-$(id -u)"

docker network create x11-network-$(id -u)

# Build Docker images
echo "Building X11 Server Docker image..."
docker build \
    --build-arg USER_ID=$(id -u) \
    --build-arg GROUP_ID=$(id -g) \
    --build-arg USER_NAME=$(id -un) \
    --build-arg SSHD_PORT=2220 \
    -t $X11_SERVER_IMAGE ./x11

echo "Building Application Docker image..."
docker build \
    --build-arg USER_ID=$(id -u) \
    --build-arg GROUP_ID=$(id -g) \
    --build-arg USER_NAME=$(id -un) \
    --build-arg SSHD_PORT=2222 \
    -t $APP_CONTAINER_IMAGE ./app 
