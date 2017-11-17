# Security groups for each subnet

resource "aws_security_group" "team2_web_sg" {
  vpc_id = "${aws_vpc.team2_vpc.id}"

  tags {
    Name = "Team 2 Webserver security group"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.corp_network_cidr_block}"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${var.corp_network_cidr_block}"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.corp_network_cidr_block}"]
  }

  egress {
    from_port   = 10240
    to_port     = 10240
    protocol    = "tcp"
    cidr_blocks = ["${aws_subnet.team2_backend_subnet_a.cidr_block}", "${aws_subnet.team2_backend_subnet_b.cidr_block}", "${aws_subnet.team2_backend_subnet_c.cidr_block}"]
  }
}

resource "aws_security_group" "team2_backend_sg" {
  vpc_id = "${aws_vpc.team2_vpc.id}"

  tags {
    Name = "Team 2 Backend security group"
  }

  ingress {
    from_port   = "10240"
    to_port     = "10240"
    protocol    = "tcp"
    cidr_blocks = ["${var.corp_network_cidr_block}"]
  }

  ingress {
    from_port   = "${var.app_port}"
    to_port     = "${var.app_port}"
    protocol    = "tcp"
    cidr_blocks = ["${var.corp_network_cidr_block}"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.corp_network_cidr_block}"]
  }

  ingress {
    from_port   = 10240
    to_port     = 10240
    protocol    = "tcp"
    cidr_blocks = ["${aws_subnet.team2_web_subnet_a.cidr_block}", "${aws_subnet.team2_web_subnet_b.cidr_block}", "${aws_subnet.team2_web_subnet_c.cidr_block}"]
  }

  ingress {
    from_port   = "${var.db_port}"
    to_port     = "${var.db_port}"
    protocol    = "tcp"
    cidr_blocks = ["${aws_subnet.team2_web_subnet_a.cidr_block}", "${aws_subnet.team2_web_subnet_b.cidr_block}", "${aws_subnet.team2_web_subnet_c.cidr_block}"]
  }

  ingress {
    from_port   = "${var.db_port}"
    to_port     = "${var.db_port}"
    protocol    = "tcp"
    cidr_blocks = ["${var.corp_network_cidr_block}"]
  }

  egress {
    from_port   = 10240
    to_port     = 10240
    protocol    = "tcp"
    cidr_blocks = ["${aws_subnet.team2_backend_subnet_a.cidr_block}", "${aws_subnet.team2_backend_subnet_b.cidr_block}", "${aws_subnet.team2_backend_subnet_c.cidr_block}"]
  }

  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["104.210.2.228/32"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
