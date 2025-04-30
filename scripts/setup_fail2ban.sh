#!/bin/bash

# Install Fail2ban
sudo dnf install -y fail2ban

# Enable and start the service
sudo systemctl enable fail2ban
sudo systemctl start fail2ban

# Create basic jail configuration for SSH
sudo bash -c 'cat > /etc/fail2ban/jail.d/sshd.conf <<EOF
[sshd]
enabled = true
port = ssh
logpath = %(sshd_log)s
backend = systemd
EOF'

# Restart Fail2ban to apply config
sudo systemctl restart fail2ban
