# Install mod_ssl
yum install -y mod_ssl

# Create SSL certificates
mkdir -p /etc/pki/tls/certs/
chmod 700 /etc/pki/tls/cecerts
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/pki/tls/certs/server.key -out /etc/pki/tls/certs/server.crt

# Configure SSL by following ssl.conf
vim /etc/httpd/conf.d/ssl.conf
sudo systemctl restart httpd

# General setup for the virtual host, inherited from global configuration
DocumentRoot "/var/www/html"
ServerName myapp.cheakautomate.online:443
SSLCertificateFile /etc/pki/tls/certs/server.crt
SSLCertificateKeyFile /etc/pki/tls/certs/server.key

# Register Domain with any provider and then add DNS record point to server's public IP
# Example : namecheap, name.com, godaddy, aws, ...

Record Type      Host                            Answer           TTL
A                myapp.cheakautomate.online      159.65.136.16    300


# If there are any issues, consider
# Check verify mod_ssl
httpd -M | grep ssl
vim /etc/httpd/conf/httpd.conf
# Add this directive
LoadModule ssl_module modules/mod_ssl.so

#Redirect HTTP to HTTPS
<VirtualHost *:80>
    ServerName myapp.cheakautomate.online
    Redirect permanent / https://myapp.cheakautomate.online/
</VirtualHost>


# ====================================================================================================
# Since you're using a self-signed certificate (as per the openssl command),
# browsers will warn that the certificate is not trusted by default. To avoid the "unsecured" warning, 
# you should use a certificate issued by a trusted Certificate Authority (CA).

# Install certbot
sudo dnf install epel-release
sudo dnf install certbot python3-certbot-apache
# Obtain free SSL Certificate
sudo certbot --apache -d myapp.cheakautomate.online
# Automatically configure Apache to use SSL.
# Request a free SSL certificate from Let's Encrypt for myapp.cheakautomate.online

# Automatic Renewal
# Let's Encrypt certificates are only valid for 90 days, so it's important to set up automatic renewal.
sudo certbot renew --dry-run
