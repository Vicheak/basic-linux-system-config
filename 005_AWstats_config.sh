# configure log analyzer with AWstats
# AWStats is a powerful log analyzer used for website traffic analysis. 
# It processes server log files (Apache, Nginx, FTP, Mail logs, etc.) and generates detailed web traffic reports.

# install package
dnf config-manager --set-enabled crb
dnf install perl-Switch -y
dnf install awstats -y
# verify installation
rpm -q awstats

# follow your site domain
cp /etc/awstats/awstats.master-server.conf /etc/awstats/awstats.myapp.cheakautomate.online.conf
# or
cp /etc/awstats/awstats.localhost.conf /etc/awstats/awstats.myapp.cheakautomate.online.conf
vim /etc/awstats/awstats.myapp.cheakautomate.online.conf

# update awstats access
vim /etc/httpd/conf.d/awstats.conf

# run awstats to update reports
/usr/share/awstats/wwwroot/cgi-bin/awstats.pl -config=myapp.cheakautomate.online -update

# set cronjob for auto report
crontab -e
# add to last line for crontab (run every 15 minutes)
# */15 * * * * /usr/share/awstats/wwwroot/cgi-bin/awstats.pl -config=myapp.cheakautomate.online -update > /dev/null 2>&1

# access awstats web interface
# https://myapp.cheakautomate.online/awstats/awstats.pl

# secure awstats
htpasswd -c /etc/httpd/.htpasswd admin
# update config to enable authentication, by following awstats_auth.conf
vim /etc/httpd/conf.d/awstats.conf
