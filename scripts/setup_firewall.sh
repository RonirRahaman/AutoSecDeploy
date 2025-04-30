#!/bin/bash

# Configure basic firewall rules usind UFW

#Set default policies
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Allow necessary ports
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https

# Enable UFW
sudo ufw --force enable


