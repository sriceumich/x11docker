# Dockerfile for Application Container
FROM ubuntu:latest

# Arguments to take host user's UID and GID
ARG USER_ID
ARG GROUP_ID
ARG USER_NAME
ARG SSHD_PORT

# Avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y software-properties-common
RUN add-apt-repository universe

RUN apt-get update && apt-get install curl -y  && curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null

# Install SSH, X11 apps, and rviz
RUN apt-get update && apt-get install -y \
    ssh \
    x11-apps \
    ros-humble-desktop
    
RUN rm -rf /var/lib/apt/lists/*fo

# Generate SSH host keys
RUN ssh-keygen -A

# Configure SSH for X11 forwarding
RUN echo "X11Forwarding yes" >> /etc/ssh/ssh_config \
    && echo "X11UseLocalhost no" >> /etc/ssh/ssh_config \
    && mkdir /var/run/sshd

# Create a new group and user with host user's UID, GID, and username
RUN addgroup --gid $GROUP_ID $USER_NAME
RUN adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID $USER_NAME
# Add user to sudoers with NOPASSWD
RUN echo "$USER_NAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USER_NAME
RUN chmod 0440 /etc/sudoers.d/$USER_NAME

# Set the working directory
WORKDIR /home/$USER_NAME

# Switch to the new user
USER $USER_NAME

RUN ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -q -N ""
RUN echo "source /opt/ros/humble/setup.bash" >> /home/$USER_NAME/.bashrc

# Reset user to root
USER root

RUN echo "Port $SSHD_PORT" >> /etc/ssh/sshd_config

# Copy the start script
COPY start.sh /start.sh

# Make the script executable
RUN chmod +x /start.sh

# Start the script
CMD ["/start.sh"]

