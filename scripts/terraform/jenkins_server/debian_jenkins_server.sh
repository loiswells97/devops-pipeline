#!/bin/bash
cd ~

sudo apt-get update

sudo apt-get install wget -y
sudo apt-get install unzip -y
sudo apt-get install git -y


echo "Installing MariaDB..."
sudo apt-get install mariadb-server -y
sudo systemctl start mariadb
sudo systemctl status mariadb
sudo systemctl enable mariadb

sudo mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '<PASSWORD>'; FLUSH PRIVILEGES;"

echo "Installing gradle..."
wget https\://services.gradle.org/distributions/gradle-6.7.1-bin.zip
sudo mkdir /opt/gradle
sudo apt-get install unzip -y
sudo unzip -d /opt/gradle gradle-6.7.1-bin.zip
export PATH=$PATH:/opt/gradle/gradle-6.7.1/bin
echo gradle -v

echo "Installing terraform..."
cd /home/vagrant
wget https://releases.hashicorp.com/terraform/0.12.31/terraform_0.12.31_linux_amd64.zip
unzip terraform_0.12.31_linux_amd64.zip
sudo mv terraform /usr/local/bin/

echo "Installing Java 11..."
sudo apt-get install openjdk-11-jdk -y

echo "Installing Jenkins..."
sudo apt-get install gnupg -y
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > \
    /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get install jenkins -y

sudo systemctl start jenkins
systemctl status jenkins
sudo systemctl enable jenkins

echo "Installing GitLab server key..."
touch .ssh/known_hosts
ssh-keyscan git.cardiff.ac.uk >> .ssh/known_hosts
chmod 644 .ssh/known_hosts

echo "Installing Google Chrome..."
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt-get install ./google-chrome-stable_current_amd64.deb -y



echo "Done :D"
