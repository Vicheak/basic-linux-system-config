# CGI (Common Gateway Interface) is a standard that enables web servers to execute 
# external scripts or programs to generate dynamic content for web pages.

# How CGI Works

# Step 1 : User Requests a Web Page
# A user visits a URL that triggers a CGI script, such as: http://example.com/cgi-bin/script.py

# Step 2 : Web Server Calls the CGI Script
# The web server (e.g., Apache, Nginx) executes the CGI script located in the cgi-bin directory.

# Step 3 : Script Processes the Request
# The script (written in Python, Perl, Bash, or another language) processes input, interacts with a database, or performs calculations.

# Step 4 : Script Sends Output to the Server
# The script generates an HTTP response with content-type headers (e.g., text/html, application/json).

# Step 5 : Web Server Sends Response to User
# The processed data is sent back to the browser as a dynamically generated web page.

# Check status web console system
systemctl status cockpit.socket
# Install perl
sudo dnf install -y perl 
# Install PHP
yum -y install php php-mbstring php-pear
# Install Ruby
yum install -y ruby


# Below is how to configure CGI execution
sudo vim /etc/httpd/conf/httpd.conf
<Directory "/var/www/html">
    #
    # Possible values for the Options directive are "None", "All",
    # or any combination of:
    #   Indexes Includes FollowSymLinks SymLinksifOwnerMatch ExecCGI MultiViews
    #
    # Note that "MultiViews" must be named *explicitly* --- "Options All"
    # doesn't give it to you.
    #
    # The Options directive is both complicated and important.  Please see
    # http://httpd.apache.org/docs/2.4/mod/core.html#options
    # for more information.
    #
    #Options Indexes FollowSymLinks ExecCGI
    #Options All
    Options FollowSymLinks ExecCGI

    #
    # AllowOverride controls what directives may be placed in .htaccess files.
    # It can be "All", "None", or any combination of the keywords:
    #   Options FileInfo AuthConfig Limit
    #
    #AllowOverride None
    AllowOverride All

    #
    # Controls who can get stuff from this server.
    #
    Require all granted
</Directory>

#
# DirectoryIndex: sets the file that Apache will serve if a directory
# is requested.
#
<IfModule dir_module>
    DirectoryIndex index.html index.cgi index.rb index.php
</IfModule>


# Access Log (records all requests to the server)
sudo cat /var/log/httpd/access_log
# Error Log (records errors and issues)
sudo cat /var/log/httpd/error_log
# View Log in realtime
tail -f /var/log/httpd/access_log
tail -f /var/log/httpd/error_log


# Add permission for exec file
chmod +x /var/www/html/index.cgi
# Check SELinux context
ls -lZ /var/www/html/index.cgi
# Expected output
-rwxr-xr-x. apache apache unconfined_u:object_r:httpd_sys_script_exec_t:s0 /var/www/html/index.cgi
# Fix issue SELinux context not allow exec file
chcon -t httpd_sys_script_exec_t /var/www/html/index.cgi


# If the issue exec file is not solved, try this
# Add execute permission to script file
chown apache:apache /var/www/html
chown apache:apache /var/www/html/index.cgi


# Test script manually
sudo -u apache /var/www/html/index.cgi


# Get status of httpd
getsebool -a | grep httpd
# Set httpd exec to true
setsebool -P httpd_execmem 1


# Test config syntax
apachectl configtest
