resource "aws_iam_policy" "prometheus_policy" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "ec2:Describe*",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "elasticloadbalancing:Describe*",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "cloudwatch:ListMetrics",
        "cloudwatch:GetMetricStatistics",
        "cloudwatch:Describe*"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "autoscaling:Describe*",
      "Resource": "*"
    },
    {
      "Sid": "Stmt1534460117429",
      "Action": [
        "s3:DeleteObject",
        "s3:DeleteObjectTagging",
        "s3:DeleteObjectVersion",
        "s3:DeleteObjectVersionTagging",
        "s3:GetObject",
        "s3:GetObjectAcl",
        "s3:GetObjectTagging",
        "s3:GetObjectTorrent",
        "s3:GetObjectVersion",
        "s3:GetObjectVersionAcl",
        "s3:GetObjectVersionForReplication",
        "s3:GetObjectVersionTagging",
        "s3:GetObjectVersionTorrent",
        "s3:GetReplicationConfiguration",
        "s3:PutObject",
        "s3:PutObjectAcl",
        "s3:PutObjectTagging",
        "s3:PutObjectVersionAcl",
        "s3:ReplicateObject",
        "s3:RestoreObject"
      ],
      "Effect": "Allow",
      "Resource": "${data.aws_s3_bucket.database_backups.arn}/*"
    }
  ]
}
EOF
}

resource "aws_iam_role" "prometheus_role" {
  name = "prometheus_role"

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

resource "aws_iam_policy_attachment" "prometheus_policy_role" {
  name       = "prometheus_role_attachment"
  policy_arn = "${aws_iam_policy.prometheus_policy.arn}"
  roles      = ["${aws_iam_role.prometheus_role.name}"]
}

resource "aws_iam_instance_profile" "prometheus_profile" {
  name = "prometheus_profile"
  role = "${aws_iam_role.prometheus_role.name}"
}

resource "aws_launch_configuration" "prometheus_launch_conf" {
  name_prefix                 = "prometheus_launch_conf"
  image_id                    = "${data.aws_ami.debian-stretch.id}"
  instance_type               = "t2.nano"
  user_data                   = "${file("${path.module}/init_scripts/prometheus.sh")}"
  iam_instance_profile        = "${aws_iam_instance_profile.prometheus_profile.name}"
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

resource "aws_autoscaling_group" "prometheus_autoscaling_group" {
  min_size             = 1
  max_size             = 1
  launch_configuration = "${aws_launch_configuration.prometheus_launch_conf.id}"
  vpc_zone_identifier  = ["${var.sinking_subnet_eu_west_2a}"]

  tag {
    key                 = "Name"
    value               = "Prometheus"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_elb" "prometheus_elb" {
  name            = "prometheus-elb"
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
    target              = "HTTP:8080/graph"
    interval            = 30
  }

  tags {
    Name = "prometheus_elb"
  }
}

resource "aws_autoscaling_attachment" "prometheus_elb_attachment" {
  autoscaling_group_name = "${aws_autoscaling_group.prometheus_autoscaling_group.id}"
  elb                    = "${aws_elb.prometheus_elb.id}"
}
