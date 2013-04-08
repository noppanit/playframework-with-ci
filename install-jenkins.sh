echo "APT::Cache-Limit "100000000";" >> /etc/apt/apt.conf.d/70debconf






wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'

sudo apt-get update
sudo apt-get -y --force-yes install jenkins
