resource "aws_subnet" "team2_web_subnet_a" {
  cidr_block              = "192.168.2.0/28"
  vpc_id                  = "${aws_vpc.team2_vpc.id}"
  map_public_ip_on_launch = true
  availability_zone       = "eu-west-1a"

  tags {
    Name = "team2 web subnet - AZ-A"
  }
}

resource "aws_subnet" "team2_web_subnet_b" {
  cidr_block              = "192.168.2.16/28"
  vpc_id                  = "${aws_vpc.team2_vpc.id}"
  map_public_ip_on_launch = true
  availability_zone       = "eu-west-1b"

  tags {
    Name = "team2 web subnet AZ-B"
  }
}

resource "aws_subnet" "team2_web_subnet_c" {
  cidr_block              = "192.168.2.32/28"
  vpc_id                  = "${aws_vpc.team2_vpc.id}"
  map_public_ip_on_launch = true
  availability_zone       = "eu-west-1c"

  tags {
    Name = "team2 web subnet - AZ-C"
  }
}

resource "aws_subnet" "team2_backend_subnet_a" {
  cidr_block              = "192.168.2.48/28"
  vpc_id                  = "${aws_vpc.team2_vpc.id}"
  map_public_ip_on_launch = true
  availability_zone       = "eu-west-1a"

  tags {
    Name = "team2 backend subnet - AZ-A"
  }
}

resource "aws_subnet" "team2_backend_subnet_b" {
  cidr_block              = "192.168.2.64/28"
  vpc_id                  = "${aws_vpc.team2_vpc.id}"
  map_public_ip_on_launch = true
  availability_zone       = "eu-west-1b"

  tags {
    Name = "team2 backend subnet - AZ-B"
  }
}

resource "aws_subnet" "team2_backend_subnet_c" {
  cidr_block              = "192.168.2.80/28"
  vpc_id                  = "${aws_vpc.team2_vpc.id}"
  map_public_ip_on_launch = true
  availability_zone       = "eu-west-1c"

  tags {
    Name = "team2 backend subnet - AZ-C"
  }
}
