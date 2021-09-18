#!/bin/bash

# This is the script corresponding to the Jenkins job DeployWellbeingPortal,
# which is triggered when the job BuildAndTestWellbeing portal succeeds.
if [ -d Terraform ]; then

# Adapted from https://stackoverflow.com/questions/36339975/how-to-automate-the-configuring-the-aws-command-line-interface-and-setting-up-pr
  aws configure set default.region eu-west-2
  aws configure set aws_access_key_id <MY_AWS_ACCESS_ID>
  aws configure set aws_secret_access_key <MY_SECRET_KEY>
  aws ecr get-login | sudo sh
# Adapted from https://awscli.amazonaws.com/v2/documentation/api/latest/reference/autoscaling/start-instance-refresh.html
  aws autoscaling start-instance-refresh --auto-scaling-group-name ApplicationASG --preferences '{"InstanceWarmup": 400, "MinHealthyPercentage": 50}'

else

  echo "There's no Terraform directory"
  cp -r ../BuildAndTestWellbeingPortal/Terraform ./
  cd Terraform

  echo "Running Terraform init for the autoscaling group..."
  /usr/local/bin/terraform init
  export AWS_ACCESS_KEY_ID=<MY_AWS_ACCESS_ID>
  export AWS_SECRET_ACCESS_KEY=<MY_SECRET_KEY>

  echo "Now time to terraform plan and apply..."
  /usr/local/bin/terraform plan
  /usr/local/bin/terraform apply -auto-approve

fi
