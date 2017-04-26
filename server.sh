echo "Adding repos..."
yum install -y http://repo.zabbix.com/zabbix/3.2/rhel/7/x86_64/zabbix-release-3.2-1.el7.noarch.rpm &>/dev/null
echo "Done."

echo "Installing mariadb..."
yum install -y mariadb mariadb-server
echo "Done."

/usr/bin/mysql_install_db --user=mysql
echo "Starting mariadb..."
systemctl start mariadb
echo "Started."

echo "Configuring Mariadb..."
mysql -uroot --execute='create database zabbix character set utf8 collate utf8_bin'
mysql -uroot --execute='grant all privileges on zabbix.* to zabbix@localhost identified by "zabbix"'
echo "Done."

echo "Installing zabbix-mysql..."
yum install -y zabbix-server-mysql zabbix-web-mysql
echo "Done."

echo "Creating database..."
zcat /usr/share/doc/zabbix-server-mysql-*/create.sql.gz | mysql -uzabbix "-pzabbix" zabbix
echo "Done."

echo "Editing configs..."
cp /vagrant/zabbix_server.conf /etc/zabbix/
cp /vagrant/vhost.conf /etc/httpd/conf.d/
cp /vagrant/zabbix.conf.php /etc/zabbix/web/
cp /vagrant/zabbix.conf /etc/httpd/conf.d/
echo "Done."

echo "Installing zabbix-agent..."
yum install -y zabbix-agent 
echo "Done."

echo "starting services..."
systemctl start zabbix-server
systemctl start zabbix-agent
systemctl start httpd
systemctl stop firewalld
echo "Done."

echo "=========Zabbix-server is ready======="
