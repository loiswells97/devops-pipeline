# This is the main.tf file for the auto-scaling group containing the application servers.
# Adapted from https://blog.gruntwork.io/an-introduction-to-terraform-f17df9c6d180

provider "aws" {
  region = "eu-west-2"
}

data "aws_availability_zones" "all" {}

resource "aws_launch_configuration" "example" {
  image_id           = "ami-050949f5d3aede071"
  instance_type = "m5.large"
  vpc_security_group_ids  = [aws_security_group.CourseworkSecurity.id]

  user_data = <<-EOF
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

              EOF

    lifecycle{
      create_before_destroy = true
      ignore_changes = [load_balancers, target_group_arns]
    }
}

resource "aws_autoscaling_group" "example" {
  launch_configuration = aws_launch_configuration.example.id
  availability_zones = data.aws_availability_zones.all.names

  min_size=2
  max_size=10

  tag {
    key = "Name"
    value = "ApplicationASG"
    propagate_at_launch = true
  }

}


resource "aws_security_group" "CourseworkSecurity" {
  name="JenkinsSecurity"

  ingress {
    from_port = 8080
    to_port = 8080
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

Adapted from https://github.com/hashicorp/learn-terraform-advanced-deployments

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.64.0"

  name = "main-vpc"
  cidr = var.vpc_cidr_block

  azs             = data.aws_availability_zones.available.names
  private_subnets = slice(var.private_subnet_cidr_blocks, 0, var.private_subnet_count)
  public_subnets  = slice(var.public_subnet_cidr_blocks, 0, var.public_subnet_count)

  enable_nat_gateway = false
  enable_vpn_gateway = var.enable_vpn_gateway
}

module "lb_security_group" {
  source  = "terraform-aws-modules/security-group/aws//modules/web"
  version = "3.17.0"

  name        = "lb-sg"
  description = "Security group for load balancer with HTTP ports open within VPC"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_lb" "app" {
  name               = "load_balancer"
  internal           = false
  load_balancer_type = "application"
  subnets            = module.vpc.public_subnets
  security_groups    = [module.lb_security_group.this_security_group_id]
}

resource "aws_lb_listener" "app" {
  load_balancer_arn = aws_lb.app.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.example.arn
  }
}

resource "aws_lb_target_group" "example" {
  name="app_load_balancer"
  port = 80
  protocol = "HTTP"
  vpc_id = module.vpc.id

  health_check {
    port     = 80
    protocol = "HTTP"
    timeout  = 5
    interval = 10
  }
}

# Adapted from https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_attachment
resource "aws_autoscaling_attachment" "example" {
  autoscaling_group_name = aws_autoscaling_group.example.id
  elb = aws_elb.app.id
}
