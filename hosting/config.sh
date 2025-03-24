# config in file /etc/httpd/conf/httpd.conf

Alias /backend "/var/www/backend/backend/Admin"
Alias /system "/var/www/backend/backend/Admin"

<Directory "/var/www/backend/backend/Admin">
    Options +FollowSymLinks -Indexes
    AllowOverride All
    Require all granted
</Directory>

# Redirect /backend to index.php inside the Admin/PHP directory
RewriteEngine On
RewriteRule ^/backend$ /backend/PHP/index.php [L]
RewriteRule ^/system$ /backend/PHP/index.php [L]

# Error page
<Directory "/var/www/html/errors">
    Require all granted
    Options +FollowSymLinks -Indexes
</Directory>

<Directory "/var/www/backend/errors">
    Require all granted
    Options +FollowSymLinks -Indexes
</Directory>

ErrorDocument 404 /errors/404.html
