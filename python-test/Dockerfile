# Use an official Python runtime as a parent image
FROM python:3.8-slim

# Arguments to take host user's UID and GID
ARG USER_ID
ARG GROUP_ID
ARG USER_NAME

# Set the working directory in the container
WORKDIR /usr/src/app

# Avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install any needed packages
RUN apt-get update && apt-get install -y \
    python3-tk \
    && rm -rf /var/lib/apt/lists/* 

RUN apt-get update && apt-get install -y python3-pip && pip3 install matplotlib numpy  tk-dev libagg-dev

# Install Python dependencies
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy the Python script into the container
COPY plot_generator.py .

# Run the script when the container launches
CMD ["python3", "plot_generator.py"]
