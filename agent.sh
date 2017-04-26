echo "Adding repos..."
yum install -y http://repo.zabbix.com/zabbix/3.2/rhel/7/x86_64/zabbix-release-3.2-1.el7.noarch.rpm &>/dev/null
echo "Done."

echo "Installing zabbix-agent..."
yum install -y zabbix-agent &>/dev/null
echo "Done."

echo "Copying configs..."
cp /vagrant/zabbix_agentd.conf /etc/zabbix/
echo "Done."

echo "Starting zabbix-agent..."
systemctl start zabbix-agent
echo "Started."

echo "======Agent node is ready======"