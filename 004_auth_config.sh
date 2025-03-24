# config authentication with web server
vim /etc/httpd/conf.d/auth_basic.conf

# add new credential
htpasswd -c /etc/httpd/conf/.htpasswd dev
# prompt for password (password will be hashed)

# content in file .htpasswd
# dev:$apr1$vBpAc9gB$wfxbdBrkD7BGv3mNKFm851 (follow this format)

# create dir for auth
mkdir /var/www/html/auth

# create .html page for test auth
