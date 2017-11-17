# Creates num_vpc VPC resources and their internet gateways.
resource "aws_vpc" "team2_vpc" {
  cidr_block = "192.168.2.0/24"

  tags {
    Name = "team2 VPC"
  }
}

resource "aws_internet_gateway" "team2_gw" {
  vpc_id = "${aws_vpc.team2_vpc.id}"

  tags {
    Name = "team2 Internet Gateway"
  }
}
