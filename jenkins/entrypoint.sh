#!/bin/bash
# Set permissions for docker.sock if it's mounted as a volume
sudo chown root:docker /var/run/docker.sock
/usr/local/bin/jenkins.sh
