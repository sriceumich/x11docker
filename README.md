# X11 Docker Containers
# Overview
This repository contains Dockerfiles and scripts to set up and run two Docker containers: one acting as an X11 server using Xvfb (X Virtual FrameBuffer), and another as an application container capable of running X11 applications, specifically configured for ROS 2 Humble and rviz. The setup allows for running graphical applications in a Dockerized environment and forwarding their display to a local machine using X11 forwarding over SSH.

# Files Description
Dockerfile: Dockerfile to create the X11 server and application containers.
start.sh: A script to start the X11 server (Xvfb) and the SSH daemon (sshd) in the container.
build.sh: A script to build Docker images.
run.sh: A script to run Docker containers.
xorg.conf: Configuration file for the Xorg server (if needed).
# Prerequisites
Docker installed on your system.
Basic knowledge of Docker commands and concepts.
SSH client on your local machine.
# Setting up the Docker Containers
# Build the Docker Images

Use the build.sh script to build the Docker images. This script reads the provided Dockerfiles and builds images for both the X11 server and the application container.

bash

./build.sh
# Run the Docker Containers

After building the images, use the run.sh script to start the containers. This script initializes the containers with the necessary configurations, including network settings and port mappings.

bash

./run.sh
# Using the Application Container
SSH into the Container

To access the application container, use SSH with X11 forwarding. Replace container_username with the username inside the Docker container, host_ip_address with the IP address of the Docker host, and port with the SSH port if not the default (22).

bash

ssh -X container_username@host_ip_address -p port
Launch rviz

Inside the container, after setting up the ROS environment, you can start rviz:

bash

rviz2
rviz should open, and its window should appear on your local machine's display.

# Customization
You can modify the Dockerfile to include additional packages or change configurations.
The start.sh script can be adjusted to start other services or applications as needed.
xorg.conf provides a template for Xorg server configuration and can be modified for specific requirements.
# Security Considerations
Ensure to use secure SSH practices, such as key-based authentication.
Running containers in host network mode has security implications; use caution and understand the risks.
Keep your Docker environment updated to the latest security patches.
# Support
For additional help or to report issues, please file an issue on the GitHub repository.


