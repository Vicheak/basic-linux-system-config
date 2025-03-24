# config in file /etc/httpd/conf/httpd.conf

LoadModule proxy_module modules/mod_proxy.so
LoadModule proxy_http_module modules/mod_proxy_http.so

# Reverse Proxy
<VirtualHost *:443>
    ServerName linux-system-g1.myheart4u.online
    
    ProxyRequests Off
    ProxyPreserveHost On
    SSLProxyVerify none
    SSLProxyCheckPeerCN off
    SSLProxyCheckPeerName off
    
    # ProxyPass / http://localhost:9090/
    # ProxyPassReverse / http://localhost:9090/

    # Specific proxy configuration for /serverAdmin
    ProxyPass /serverAdmin http://localhost:9090/system
    ProxyPassReverse /serverAdmin http://localhost:9090/system

    SSLEngine on
    SSLCertificateFile /etc/letsencrypt/live/linux-system-g1.myheart4u.online/fullchain.pem
    SSLCertificateKeyFile /etc/letsencrypt/live/linux-system-g1.myheart4u.online/privkey.pem
    Include /etc/letsencrypt/options-ssl-apache.conf
    
    ErrorLog logs/myapp-proxy-error_log
    CustomLog logs/myapp-proxy-access_log combined
</VirtualHost>

# Supplemental configuration
#
# Load config files in the "/etc/httpd/conf.d" directory, if any.
IncludeOptional conf.d/*.conf

# =======================================================================
# check SELinux enable
getenforce
# Allow Apache to Make Network Connections
sudo setsebool -P httpd_can_network_connect 1
# Revert SELinux to enforcing mode
sudo setenforce 1
# restart web server
sudo systemctl restart httpd
