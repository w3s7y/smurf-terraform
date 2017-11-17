# add comment here alan
resource "aws_elb" "bar" {
  name = "backend-lb"

  listener {
    instance_port     = 10240
    instance_protocol = "http"
    lb_port           = 10240
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:10240/login"
    interval            = 10
  }

  instances           = ["${aws_instance.aza_ciserver.id}", "${aws_instance.azb_ciserver.id}", "${aws_instance.azc_ciserver.id}"]
  subnets             = ["${aws_subnet.team2_web_subnet_a.id}", "${aws_subnet.team2_web_subnet_b.id}", "${aws_subnet.team2_web_subnet_c.id}"]
  security_groups     = ["${aws_security_group.team2_backend_sg.id}"]
  connection_draining = true
}
