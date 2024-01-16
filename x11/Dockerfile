# Dockerfile for X11 Server Container
FROM ubuntu:latest

# Arguments to take host user's UID and GID
ARG USER_ID
ARG GROUP_ID
ARG USER_NAME
ARG SSHD_PORT

# Avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install Xvfb
RUN apt-get update && apt-get install -y xvfb x11-utils ssh

# Generate SSH host keys
RUN ssh-keygen -A

# Create a new group and user with host user's UID, GID, and username
RUN addgroup --gid $GROUP_ID $USER_NAME
RUN adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID $USER_NAME
# Add user to sudoers with NOPASSWD
RUN echo "$USER_NAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USER_NAME
RUN chmod 0440 /etc/sudoers.d/$USER_NAME

RUN echo "Port 2220" >> /etc/ssh/sshd_config

WORKDIR /home/$USER_ID
#USER root
#RUN echo "allowed_users=anybody" >> /etc/X11/Xwrapper.config
USER $USER_ID

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

