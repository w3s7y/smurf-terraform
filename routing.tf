resource "aws_route_table" "team2_web_subnet_route_table" {
  vpc_id = "${aws_vpc.team2_vpc.id}"

  tags {
    Name = "team2 web subnet route table"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.team2_gw.id}"
  }
}

resource "aws_route_table_association" "team2_web_subnet_assoc_a" {
  subnet_id      = "${aws_subnet.team2_web_subnet_a.id}"
  route_table_id = "${aws_route_table.team2_web_subnet_route_table.id}"
}

resource "aws_route_table_association" "team2_web_subnet_assoc_b" {
  subnet_id      = "${aws_subnet.team2_web_subnet_b.id}"
  route_table_id = "${aws_route_table.team2_web_subnet_route_table.id}"
}

resource "aws_route_table_association" "team2_web_subnet_assoc_c" {
  subnet_id      = "${aws_subnet.team2_web_subnet_c.id}"
  route_table_id = "${aws_route_table.team2_web_subnet_route_table.id}"
}

resource "aws_route_table_association" "team2_backend_subnet_assoc_a" {
  subnet_id      = "${aws_subnet.team2_backend_subnet_a.id}"
  route_table_id = "${aws_vpc.team2_vpc.main_route_table_id}"
}

resource "aws_route_table_association" "team2_backend_subnet_assoc_b" {
  subnet_id      = "${aws_subnet.team2_backend_subnet_b.id}"
  route_table_id = "${aws_vpc.team2_vpc.main_route_table_id}"
}

resource "aws_route_table_association" "team2_backend_subnet_assoc_c" {
  subnet_id      = "${aws_subnet.team2_backend_subnet_c.id}"
  route_table_id = "${aws_vpc.team2_vpc.main_route_table_id}"
}

# This would normally point to a NAT gateway deployed into the frontend subnet (DMZ).
# For test just point it directly to the internet GW.
resource "aws_route" "team2_nat_route" {
  route_table_id         = "${aws_vpc.team2_vpc.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.team2_gw.id}"
}
