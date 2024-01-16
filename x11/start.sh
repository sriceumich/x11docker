#!/bin/bash

# Start the SSH daemon
/usr/sbin/sshd -D &


# Start Xvfb
Xvfb :0 -screen 0 1024x768x24 &

# Wait indefinitely
tail -f /dev/null


