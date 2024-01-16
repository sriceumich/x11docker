# Dockerfile for Application Container
FROM ubuntu:latest

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

# Set up user and groups
RUN groupadd -g 1000 seanrice \
    && useradd -m -s /bin/bash -u 1000 -g 1000 seanrice \
    && usermod -aG sudo seanrice \
    && echo 'seanrice ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

WORKDIR /home/seanrice
USER seanrice

RUN ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -q -N ""
RUN echo "source /opt/ros/humble/setup.bash" >> /home/seanrice/.bashrc

# Reset user to root
USER root

RUN echo "Port 2222" >> /etc/ssh/sshd_config

# Copy the start script
COPY start.sh /start.sh

# Make the script executable
RUN chmod +x /start.sh

# Start the script
CMD ["/start.sh"]

