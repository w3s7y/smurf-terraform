# Placeholder for creating backend servers.
resource "aws_instance" "aza_ciserver" {
  ami                    = "${lookup(var.aws_amis, "${var.ci_server_ami}")}"
  instance_type          = "${var.default_instance}"
  subnet_id              = "${aws_subnet.team2_backend_subnet_a.id}"
  vpc_security_group_ids = ["${aws_security_group.team2_backend_sg.id}"]
  user_data              = "${file("cibootstrap.sh")}"
  key_name               = "${aws_key_pair.team2_key.key_name}"

  tags {
    Name = "AZ-A CI Server"
  }
}

resource "aws_instance" "azb_ciserver" {
  ami                    = "${lookup(var.aws_amis, "${var.ci_server_ami}")}"
  instance_type          = "${var.default_instance}"
  subnet_id              = "${aws_subnet.team2_backend_subnet_b.id}"
  vpc_security_group_ids = ["${aws_security_group.team2_backend_sg.id}"]
  user_data              = "${file("cibootstrap.sh")}"
  key_name               = "${aws_key_pair.team2_key.key_name}"

  tags {
    Name = "AZ-B CI Server"
  }
}

resource "aws_instance" "azc_ciserver" {
  ami                    = "${lookup(var.aws_amis, "${var.ci_server_ami}")}"
  instance_type          = "${var.default_instance}"
  subnet_id              = "${aws_subnet.team2_backend_subnet_c.id}"
  vpc_security_group_ids = ["${aws_security_group.team2_backend_sg.id}"]
  user_data              = "${file("cibootstrap.sh")}"
  key_name               = "${aws_key_pair.team2_key.key_name}"

  tags {
    Name = "AZ-C CI Server"
  }
}
