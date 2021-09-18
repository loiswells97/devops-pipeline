variable "flavor" { default = "m1.large" }
variable "image" { default = "Debian Buster 10.3.0" }
variable "name1" { default = "Debian NGINX VM" }

variable "keypair" { default = "c2075016_key" } # you may need to change this
variable "network" { default = "c2075016_network" }   # you need to change this

variable "pool" { default = "cscloud_private_floating" }
variable "server1_script" { default = "./nginx_server.sh" }
variable "security_description" { default = "Terraform security group" }
variable "security_name" { default = "coursework_security_nginx" }
