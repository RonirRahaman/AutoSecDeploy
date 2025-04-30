#!/bin/bash

# Install security packages
sudo dnf install -y ufw fail2ban openssh-server nginx

# Start services
sudo systemctl enable --now sshd
sudo systemctl enable --now ufw
sudo systemctl enable --now fail2ban
sudo systemctl enable --now nginx

