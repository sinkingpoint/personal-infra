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

resource "aws_instance" "grafana_instance" {
  ami                         = "${data.aws_ami.debian-stretch.id}"
  instance_type               = "t2.nano"
  user_data                   = "${file("${path.module}/init_scripts/grafana.sh")}"
  iam_instance_profile        = "${aws_iam_instance_profile.grafana_profile.name}"
  key_name                    = "personal-infra"
  associate_public_ip_address = true
  availability_zone           = "eu-west-2a"
  subnet_id                   = "${var.sinking_subnet_eu_west_2a}"

  vpc_security_group_ids = [
    "${aws_security_group.public_ssh.id}",
    "${aws_security_group.public_80.id}",
    "${aws_security_group.internal_8080.id}",
    "${aws_security_group.internal_node_exporter.id}",
  ]

  tags {
    Name = "Grafana"
  }
}