sudo apt-get update

echo "APT::Cache-Limit "100000000";" >> /etc/apt/apt.conf.d/70debconf

wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'

sudo apt-get -y --force-yes install jenkins

sudo apt-get -y --force-yes install apache2
sudo a2enmod proxy
sudo a2enmod proxy_http
sudo a2enmod vhost_alias
sudo a2dissite default

echo '<VirtualHost *:80>
	ServerAdmin webmaster@localhost
	ServerName ci.company.com
	ServerAlias ci
	ProxyRequests Off
	<Proxy *>
		Order deny,allow
		Allow from all
	</Proxy>
	ProxyPreserveHost on
	ProxyPass / http://localhost:8080/
</VirtualHost>' >> /etc/apache2/sites-available/jenkins

sudo a2ensite jenkins
sudo sh -c 'echo "ServerName localhost" >> /etc/apache2/conf.d/name' && sudo service apache2 restart
sudo apache2ctl restart

