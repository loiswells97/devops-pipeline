#!/bin/bash

cd ~

sudo apt-get update

echo "Installing MariaDB..."
sudo apt-get install mariadb-server -y
sudo systemctl start mariadb
sudo systemctl status mariadb
sudo systemctl enable mariadb

cat << `EOF` >> wellbeing_portal.key
-----BEGIN OPENSSH PRIVATE KEY-----
# Private key here
-----END OPENSSH PRIVATE KEY-----
`EOF`

echo "Saved private key :)"

chmod 400 wellbeing_portal.key
touch .ssh/known_hosts
ssh-keyscan git.cardiff.ac.uk >> .ssh/known_hosts
chmod 644 .ssh/known_hosts

echo "Cloning the GitLab project..."
sudo apt-get install git -y
ssh-agent bash -c 'ssh-add wellbeing_portal.key; git clone git@git.cardiff.ac.uk:c2075016/wellbeing-portal-with-tests.git' -yes
chmod 777 wellbeing-portal-with-tests

echo "Setting up the environment..."
cd ~/wellbeing-portal-with-tests/
sudo mysql -u root < SSOSS_CircusSkill.sql
sudo mysql -u root -e "USE SSOSS_CircusSkill;"
sudo mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '<PASSWORD>'; FLUSH PRIVILEGES;"
echo "Done :)"

echo "Installing Java..."
sudo apt-get install curl -y
sudo curl -O https://download.java.net/java/GA/jdk11/9/GPL/openjdk-11.0.2_linux-x64_bin.tar.gz
sudo tar zxvf openjdk-11.0.2_linux-x64_bin.tar.gz
sudo mv jdk-11.0.2 /usr/local/
export JAVA_HOME=/usr/local/jdk-11.0.2
export PATH=$PATH:$JAVA_HOME/bin


curl -u admin:'<PASSWORD>' -X GET "http://10.72.99.53:8082/artifactory/devops-coursework-gradle-release-local/uk/ac/cf/nsa/web/wellbeing-portal/wellbeing-portal/0.0.1-SNAPSHOT/" --output info
LINE=$(tail -3 info | head -1)
ARTIFACT=$(echo $LINE | cut -d '"' -f 2)

curl -u admin:'<PASSWORD>' -X GET http://10.72.99.53:8082/artifactory/devops-coursework-gradle-release-local/uk/ac/cf/nsa/web/wellbeing-portal/wellbeing-portal/0.0.1-SNAPSHOT/$ARTIFACT --output latest_jar.jar
java -jar latest_jar.jar
