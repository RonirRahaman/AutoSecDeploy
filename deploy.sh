#!/bin/bash

echo "Starting AutoSecDeploy..."

# Define lof file
LOG_FILE="logs/deployment.log"
mkdir -p logs
touch $LOG_FILE

# Log function
log() {
     echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

# 1. Update and upgrade system
log "Updating system..."
sudo dnf update -y

# 2. Install necessary packages
log "Installing security packages..."
bash scripts/install_packages.sh

# 3. Configure Firewall
log "Configuring Firewall..."
bash scripts/setup_firewall.sh

# 4. Harden SSH
log "Hardening SSH..."
bash scripts/harden_ssh.sh

# 5. Setup Fail2ban
log "Setting up Fail2ban..."
bash scripts/setup_fail2ban.sh

# 6. Secure Web Server (Optional)
log "Securing Web Server..."
bash scripts/secure_apache.sh

# 7. Generate Report
log "Generating Security Report..."
python3 report/generate_report.py

log "AutoSecDeploy completed successfully!"

