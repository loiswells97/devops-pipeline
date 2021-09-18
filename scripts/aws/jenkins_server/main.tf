# This is the main.tf file for the Jenkins instance.
# Adapted from https://blog.gruntwork.io/an-introduction-to-terraform-f17df9c6d180

provider "aws" {
  region = "eu-west-2"
}

resource "aws_instance" "example" {
  ami           = "ami-050949f5d3aede071"
  instance_type = "m5.xlarge"
  vpc_security_group_ids  = [aws_security_group.JenkinsSecurity.id]

  user_data = <<-EOF
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

              echo "Installing JFrog Artifactory"
              sudo apt-get install gnupg2 -y
              wget -qO - https://api.bintray.com/orgs/jfrog/keys/gpg/public.key | sudo apt-key add -
              sudo sh -c 'echo deb https://jfrog.bintray.com/artifactory-debs bionic main > /etc/apt/sources.list.d/jfrog.list'
              sudo apt-get update -y
              sudo apt-get install jfrog-artifactory-oss -y

              sudo systemctl start artifactory
              sudo systemctl enable artifactory
              sudo systemctl status artifactory

              Adapted from https://computingforgeeks.com/how-to-install-and-use-aws-cli-on-linux-ubuntu-debian-centos/
              sudo apt-get -y install python-pip
              sudo pip install --upgrade pip
              sudo pip install awscli

              echo "Done"

              EOF

  tags = {
    Name = "Debian Jenkins VM"
  }
}

resource "aws_security_group" "JenkinsSecurity" {
  name="JenkinsSecurity"

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ngress {
    from_port = 8081
    to_port = 8081
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ngress {
    from_port = 8082
    to_port = 8082
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ngress {
    from_port = 8083
    to_port = 8083
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
