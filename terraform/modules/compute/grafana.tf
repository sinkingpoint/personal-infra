data "aws_ssm_parameter" "grafana_root_password" {
  name = "grafana_root_password"
}

resource "aws_iam_policy" "grafana_policy" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
          "ssm:GetParameter",
          "ssm:GetParameters"
      ],
      "Resource": "${data.aws_ssm_parameter.grafana_root_password.arn}"
    }
  ]
}
EOF
}

resource "aws_iam_role" "grafana_role" {
  name = "grafana_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "grafana_policy_role" {
  name       = "grafana_role_attachment"
  policy_arn = "${aws_iam_policy.grafana_policy.arn}"
  roles      = ["${aws_iam_role.grafana_role.name}"]
}

resource "aws_iam_instance_profile" "grafana_profile" {
  name = "grafana_profile"
  role = "${aws_iam_role.grafana_role.name}"
}

resource "aws_launch_configuration" "grafana_launch_conf" {
  name_prefix                 = "grafana_launch_conf"
  image_id                    = "${data.aws_ami.debian-stretch.id}"
  instance_type               = "t2.nano"
  user_data                   = "${file("${path.module}/init_scripts/grafana.sh")}"
  iam_instance_profile        = "${aws_iam_instance_profile.grafana_profile.name}"
  key_name                    = "personal-infra"
  associate_public_ip_address = true

  security_groups = [
    "${aws_security_group.public_ssh.id}",
    "${aws_security_group.internal_8080.id}",
    "${aws_security_group.internal_node_exporter.id}",
  ]

  root_block_device {
    volume_size = 256
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "grafana_autoscaling_group" {
  min_size             = 1
  max_size             = 1
  launch_configuration = "${aws_launch_configuration.grafana_launch_conf.id}"
  vpc_zone_identifier  = ["${var.sinking_subnet_eu_west_2a}"]

  tag {
    key                 = "Name"
    value               = "Grafana"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_elb" "grafana_elb" {
  name            = "grafana-elb"
  security_groups = ["${aws_security_group.public_80.id}"]
  subnets         = ["${var.sinking_subnet_eu_west_2a}"]

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
    target              = "HTTP:8080/login"
    interval            = 30
  }

  tags {
    Name = "grafana_elb"
  }
}

resource "aws_autoscaling_attachment" "grafana_elb_attachment" {
  autoscaling_group_name = "${aws_autoscaling_group.grafana_autoscaling_group.id}"
  elb                    = "${aws_elb.grafana_elb.id}"
}
