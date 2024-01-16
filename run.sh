#!/bin/bash

# Define your Docker image names
X11_SERVER_IMAGE="x11-server-image"
APP_CONTAINER_IMAGE="app-container-image"

# Run the X11 server container
echo "Running X11 Server container..." 
docker run -d --name x11-server-container --network host  -v /tmp/.X11-unix-docker:/tmp/.X11-unix $X11_SERVER_IMAGE

X11_SERVER_IP=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' x11-server-container)
echo "X11 Server IP: $X11_SERVER_IP"

# Run the application container with environment variable for X11 display
echo "Running Application container..."
docker run -d --name app-container --privileged --network host -e DISPLAY=:0 $APP_CONTAINER_IMAGE

APP_CONTAINER_IMAGE=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' app-container)
echo "App Container IP: $APP_CONTAINER_IMAGE"

docker run -e --name app-python-plot -e DISPLAY=:0 $APP_CONTAINER_IMAGE
docker run  -e DISPLAY=:0 -v /tmp/.X11-unix:/tmp/.X11-unix python-plot


#logon
ssh -X -p 2222 seanrice@wailord.engin.umich.edu

