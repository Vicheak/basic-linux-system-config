# Update Your System
sudo dnf update -y
# Install Apache (httpd)
sudo dnf install -y httpd
# Start and Enable Apache
sudo systemctl start httpd
sudo systemctl enable httpd


# If system does not have firewall-d, install like below
# Install Firewalld
sudo dnf install -y firewalld
# Enable and Start Firewalld
sudo systemctl enable --now firewalld
# Verify Firewalld is Running
sudo systemctl status firewalld


# Allow HTTP and HTTPS Traffic in the Firewall
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https
sudo firewall-cmd --reload
# Check Active Firewall Zones
sudo firewall-cmd --get-active-zones
# List Rules for a Specific Zone
sudo firewall-cmd --zone=public --list-all
# List All Open Ports
sudo firewall-cmd --list-ports
# List Allowed Services
sudo firewall-cmd --list-services
# List All Rules in All Zones
sudo firewall-cmd --list-all-zones
# Check Default Zone
sudo firewall-cmd --get-default-zone
# Check Permanent Rules
sudo firewall-cmd --permanent --list-all
# Remove HTTP and HTTPS Rules
sudo firewall-cmd --permanent --remove-service=http
sudo firewall-cmd --permanent --remove-service=https


# Check web server status
sudo systemctl status httpd
