#!/bin/bash

SSH_CONFIG="/etc/ssh/sshd_config"

# Backup original SSH config
sudo cp $SSH_CONFIG "${SSH_CONFIG}.bak"

# Disable root login
sudo sed -i 's/^#PermitRootLogin.*/PermitRootLogin no/' $SSH_CONFIG

# Disable password authentication (use only SSH keys)
sudo sed -i 's/^#PasswordAuthentication.*/PasswordAuthentication no/' $SSH_CONFIG

# Set protocol to 2
sudo sed -i 's/^Protocol.*/Protocol 2/' $SSH_CONFIG

# Restart SSH services
sudo systemctl restart sshd




