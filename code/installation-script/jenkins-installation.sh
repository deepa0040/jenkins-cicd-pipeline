#!/bin/bash
# Jenkins Installation Script - Debian/Ubuntu

set -e  # Exit on error

echo "=== Updating system packages ==="
sudo apt-get update -y
sudo apt-get install -y wget gnupg curl software-properties-common apt-transport-https

echo "=== Adding Jenkins repository key ==="
sudo mkdir -p /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

echo "=== Adding Jenkins repository ==="
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" \
  | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

echo "=== Updating package list ==="
sudo apt-get update -y

echo "=== Installing dependencies (Java 21, fontconfig) ==="
sudo apt-get install -y fontconfig openjdk-21-jre

echo "=== Installing Jenkins ==="
sudo apt-get install -y jenkins

echo "=== Enabling and starting Jenkins service ==="
sudo systemctl enable jenkins
sudo systemctl start jenkins

echo "=== Checking Jenkins status ==="
sudo systemctl status jenkins --no-pager

echo "=== Verifying Java version ==="
java -version

echo "=== Jenkins installation completed successfully ==="
echo "Access Jenkins at: http://<your-server-ip>:8080"
echo "Initial admin password (use this to unlock Jenkins):"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
