resource "aws_s3_bucket" "docker_bucket" {
  bucket = "sinking-registry"
}

resource "aws_iam_policy" "docker_policy" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:ListBucket",
        "s3:GetBucketLocation",
        "s3:ListBucketMultipartUploads"
      ],
      "Resource": "${aws_s3_bucket.docker_bucket.arn}"
    },
    {
      "Sid": "Stmt1534460117429",
      "Action": [
        "s3:PutObject",
        "s3:GetObject",
        "s3:DeleteObject",
        "s3:ListMultipartUploadParts",
        "s3:AbortMultipartUpload"
      ],
      "Effect": "Allow",
      "Resource": "${aws_s3_bucket.docker_bucket.arn}/*"
    }
  ]
}
EOF
}

resource "aws_iam_role" "docker_role" {
  name = "docker_role"

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

resource "aws_iam_policy_attachment" "docker_policy_role" {
  name       = "docker_role_attachment"
  policy_arn = "${aws_iam_policy.docker_policy.arn}"
  roles      = ["${aws_iam_role.docker_role.name}"]
}

resource "aws_iam_instance_profile" "docker_profile" {
  name = "docker_profile"
  role = "${aws_iam_role.docker_role.name}"
}

resource "aws_launch_configuration" "docker_launch_conf" {
  name_prefix                 = "docker_launch_conf"
  image_id                    = "${data.aws_ami.debian-stretch.id}"
  instance_type               = "t2.nano"
  user_data                   = "${file("${path.module}/init_scripts/docker.sh")}"
  iam_instance_profile        = "${aws_iam_instance_profile.docker_profile.name}"
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

resource "aws_autoscaling_group" "docker_autoscaling_group" {
  min_size             = 1
  max_size             = 1
  launch_configuration = "${aws_launch_configuration.docker_launch_conf.id}"
  vpc_zone_identifier  = ["${var.sinking_subnet_eu_west_2a}"]

  tag {
    key                 = "Name"
    value               = "docker"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_elb" "docker_elb" {
  name            = "docker-elb"
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
    target              = "HTTP:8080/"
    interval            = 30
  }

  tags {
    Name = "docker_elb"
  }
}

resource "aws_autoscaling_attachment" "docker_elb_attachment" {
  autoscaling_group_name = "${aws_autoscaling_group.docker_autoscaling_group.id}"
  elb                    = "${aws_elb.docker_elb.id}"
}
