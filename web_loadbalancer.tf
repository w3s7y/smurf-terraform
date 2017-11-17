# placeholder for load balancer, scaling group, launch config and alarms code
resource "aws_elb" "team2_elb" {
  name    = "team2-load-balancer"
  subnets = ["${aws_subnet.team2_web_subnet_a.id}", "${aws_subnet.team2_web_subnet_b.id}", "${aws_subnet.team2_web_subnet_c.id}"]

  listener {
    instance_port     = 8080
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8080/"
    interval            = 10
  }

  security_groups             = ["${aws_security_group.team2_web_sg.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400
}

resource "aws_autoscaling_group" "team2_web_asg" {
  vpc_zone_identifier  = ["${aws_subnet.team2_web_subnet_a.id}", "${aws_subnet.team2_web_subnet_b.id}", "${aws_subnet.team2_web_subnet_c.id}"]
  name                 = "team2_asg"
  max_size             = "${var.asg_max}"
  min_size             = "${var.asg_min}"
  desired_capacity     = "${var.asg_desired}"
  force_delete         = true
  launch_configuration = "${aws_launch_configuration.team2_web_lc.name}"
  load_balancers       = ["${aws_elb.team2_elb.name}"]
  health_check_type    = "EC2"

  tag {
    key                 = "Name"
    value               = "team2_web_asg"
    propagate_at_launch = "true"
  }
}

resource "aws_autoscaling_policy" "web-asp-up" {
  name                   = "team2-asp-up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = "${aws_autoscaling_group.team2_web_asg.name}"
}

resource "aws_autoscaling_policy" "web-asp-down" {
  name                   = "team2-asp-down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = "${aws_autoscaling_group.team2_web_asg.name}"
}

resource "aws_cloudwatch_metric_alarm" "network-alarm-up" {
  alarm_name          = "network-alarm-up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "NetworkPacketsIn"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "1500"

  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.team2_web_asg.name}"
  }

  alarm_description = "This metric monitors ec2 network packets utilization"
  alarm_actions     = ["${aws_autoscaling_policy.web-asp-up.arn}"]
}

resource "aws_cloudwatch_metric_alarm" "network-alarm-down" {
  alarm_name          = "network-alarm-down"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "NetworkPacketsIn"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "500"

  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.team2_web_asg.name}"
  }

  alarm_description = "This metric monitors ec2 network packets utilization"
  alarm_actions     = ["${aws_autoscaling_policy.web-asp-down.arn}"]
}

resource "aws_launch_configuration" "team2_web_lc" {
  name            = "team2_terrraform_lc"
  image_id        = "${lookup(var.aws_amis, "${var.ami_ref}")}"
  instance_type   = "${var.default_instance}"
  security_groups = ["${aws_security_group.team2_web_sg.id}"]
  key_name        = "${aws_key_pair.team2_key.key_name}"
  user_data       = "${file("install.sh")}"
}

output "Load Balancer DNS name" {
  value = "${aws_elb.team2_elb.dns_name}"
}
