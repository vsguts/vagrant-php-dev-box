# pre
apt-get update

# nfs
apt-get install nfs-common

# mysql
export DEBIAN_FRONTEND=noninteractive
apt-get install -q -y mysql-server mysql-client
mysqladmin -u root password root
cp /etc/mysql/my.cnf /etc/mysql/my.cnf.bak
sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/my.cnf
service mysql restart
export DEBIAN_FRONTEND=

# apache
apt-get install -q -y apache2
a2enmod rewrite
a2enmod ssl
a2ensite default-ssl

echo "" >> /etc/apache2/apache2.conf
echo "ServerName localhost" >> /etc/apache2/apache2.conf

# apache: AllowOverrid (replace setting between 9 and 15 string of the vhost config)
cp /etc/apache2/sites-available/default /etc/apache2/sites-available/default.bak
sed -i '9,15s/AllowOverride None/AllowOverride All/g' /etc/apache2/sites-available/default
cp /etc/apache2/sites-available/default-ssl /etc/apache2/sites-available/default-ssl.bak
sed -i '10,16s/AllowOverride None/AllowOverride All/g' /etc/apache2/sites-available/default-ssl

# php
apt-get install -q -y php5 php-pear php5-dev php5-mysql php5-curl make
cp /etc/php5/apache2/php.ini /etc/php5/apache2/php.ini.bak
sed -i 's/display_errors = Off/display_errors = On/g' /etc/php5/apache2/php.ini
sed -i 's/html_errors = Off/html_errors = On/g' /etc/php5/apache2/php.ini
sed -i 's/post_max_size = 8M/post_max_size = 128M/g' /etc/php5/apache2/php.ini
sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 122M/g' /etc/php5/apache2/php.ini
sed -i 's/session.gc_maxlifetime = 1440/session.gc_maxlifetime = 86400/g' /etc/php5/apache2/php.ini

echo "" >> /etc/php5/apache2/php.ini
echo "" >> /etc/php5/cli/php.ini
echo "; gvs" >> /etc/php5/apache2/php.ini
echo "; gvs" >> /etc/php5/cli/php.ini

# php xdebug
apt-get install -q -y php5-xdebug
echo "" >> /etc/php5/mods-available/xdebug.ini
echo "xdebug.remote_enable = 1" >> /etc/php5/mods-available/xdebug.ini
echo "xdebug.remote_port = 9000" >> /etc/php5/mods-available/xdebug.ini
echo "xdebug.remote_host=10.0.2.2" >> /etc/php5/mods-available/xdebug.ini
echo "xdebug.remote_handler=dbgp" >> /etc/php5/mods-available/xdebug.ini
echo ";xdebug.remote_log=\"/var/log/xdebug/xdebug.log\"" >> /etc/php5/mods-available/xdebug.ini
# pecl install xdebug
# echo "extension=xdebug.so" >> /etc/php5/apache2/php.ini
# echo "extension=xdebug.so" >> /etc/php5/cli/php.ini

pecl install redis
echo "extension=redis.so" >> /etc/php5/apache2/php.ini
echo "extension=redis.so" >> /etc/php5/cli/php.ini

# additions
apt-get install -q -y redis-server

# final
service apache2 restart

# common
apt-get install -q -y postfix
apt-get install -q -y zsh
apt-get install -q -y git
apt-get install -q -y curl
apt-get install -q -y vim
apt-get install -q -y htop
apt-get install -q -y mc
apt-get install -q -y tmux screen

# tools
apt-get install -q -y phpmyadmin

# common config
echo "10.0.2.2    gvs.u.simtech" >> /etc/hosts

# post:
# dpkg-reconfigure phpmyadmin
# dpkg-reconfigure locales
