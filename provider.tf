# Terraforms provider block
variable "AWSKEY" {}

variable "AWSSECRET" {}

provider "aws" {
  access_key = "${var.AWSKEY}"
  secret_key = "${var.AWSSECRET}"
  region     = "${var.aws_region}"
}

# Supply an SSH Keypair for users
resource "aws_key_pair" "team2_key" {
  key_name   = "team2_key"
  public_key = "${file("${var.ssh_public_key}")}"
}
