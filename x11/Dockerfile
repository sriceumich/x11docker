# Dockerfile for X11 Server Container
FROM ubuntu:latest

# Avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install Xvfb
RUN apt-get update && apt-get install -y xvfb x11-utils ssh

# Generate SSH host keys
RUN ssh-keygen -A

# Set up user and groups
RUN groupadd seanrice -g 1000
RUN useradd seanrice -m -s /bin/bash -u 1000 -g 1000
RUN usermod -aG sudo seanrice
RUN usermod -aG video seanrice
RUN usermod -aG dialout seanrice
RUN echo 'seanrice ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN echo "Port 2220" >> /etc/ssh/sshd_config

WORKDIR /home/seanrice
#USER root
#RUN echo "allowed_users=anybody" >> /etc/X11/Xwrapper.config
USER seanrice
# Set the display environment variable
ENV DISPLAY=:0

# Copy the xorg.conf file with dummy driver configuration
#COPY xorg.conf /etc/X11/xorg.conf

# Set the display environment variable
ENV DISPLAY=:0

# Copy the startup script
COPY start.sh /start.sh

# Make the script executable
RUN chmod +x /start.sh

# Run the startup script
CMD ["/start.sh"]

