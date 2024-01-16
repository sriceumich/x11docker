#!/bin/bash

# Start the SSH Daemon
/usr/sbin/sshd -D &

# Wait indefinitely
tail -f /dev/null
