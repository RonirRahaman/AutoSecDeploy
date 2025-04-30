# 🔐 AutoSecDeploy – Secure Linux Server Deployment Tool

**AutoSecDeploy** is an automated Bash + Python-based tool designed to configure and secure a Linux server with just one command. It follows best practices in server hardening, firewall setup, SSH security, fail2ban configuration, and generates a security report.

> Built as a hands-on cybersecurity project to demonstrate server automation, Linux administration, and scripting skills.

---

## 🚀 Features

- 🔄 System update and essential package installation
- 🔐 Firewall configuration (firewalld)
- 🛡️ SSH hardening (disable root login, disable password authentication)
- 👮 Fail2Ban setup for brute-force protection
- 🌐 NGINX web server setup
- 📄 Auto-generated security audit report
- 📧 Optional: Email alerts & log monitoring via Python scripts

---

## 🧰 Technologies Used

- **Bash scripting**
- **Python 3**
- **Systemd services** (firewalld, fail2ban, nginx)
- **Fedora Linux** (compatible with other RPM/Debian-based distros)

---

## 📁 Project Structure

