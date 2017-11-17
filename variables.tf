# Variable file for week5 projects.

# Corporate network block, set this to your office IP...
variable "corp_network_cidr_block" {
  default = "195.188.112.0/24"
}

variable "ssh_public_key" {
  default = "../ssh/id_rsa.pub"
}

variable "default_instance" {
  default = "t2.micro"
}

variable "aws_region" {
  default = "eu-west-1"
}

variable "aws_amis" {
  default = {
    suse-linux-server-12    = "ami-bb7b2dc8"
    rhel-7.3                = "ami-02ace471"
    amazon-linux-2016       = "ami-9398d3e0"
    custom-server           = "ami-e6abf895"
    ubuntu-server-16.04-lts = "ami-0d77397e"
    jessie-docker-puppet    = "ami-63431b10"
    jenkins-ci-server       = "ami-9d3f65ee"
    smurf-production        = "ami-1d32686e"
  }
}

variable "ami_ref" {
  default = "smurf-production"
}

variable "ci_server_ami" {
  default = "jenkins-ci-server"
}

variable "db_port" {
  default = 3306
}

variable "app_port" {
  default = 8080
}

variable "asg_min" {
  description = "Min numbers of servers in ASG"
  default     = "1"
}

variable "asg_max" {
  description = "Max numbers of servers in ASG"
  default     = "3"
}

variable "asg_desired" {
  description = "Desired numbers of servers in ASG"
  default     = "1"
}
