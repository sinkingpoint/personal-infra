data "aws_ssm_parameter" "wiki_db_password" {
  name = "wiki_db_password"
}

resource "aws_iam_policy" "wiki_policy" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
      {
          "Effect": "Allow",
          "Action": [
              "ssm:GetParameter"
          ],
          "Resource": "${data.aws_ssm_parameter.wiki_db_password.arn}"
      }
  ]
}
EOF
}

resource "aws_iam_role" "wiki_role" {
  name = "wiki_role"

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

resource "aws_iam_policy_attachment" "wiki_policy_role" {
  name       = "wiki_role_attachment"
  policy_arn = "${aws_iam_policy.wiki_policy.arn}"
  roles      = ["${aws_iam_role.wiki_role.name}"]
}

resource "aws_iam_instance_profile" "wiki_profile" {
  name = "wiki_profile"
  role = "${aws_iam_role.wiki_role.name}"
}

resource "aws_instance" "bookstack_instance" {
  ami                         = "${data.aws_ami.debian-stretch.id}"
  instance_type               = "t3.nano"
  user_data                   = "${file("${path.module}/init_scripts/bookstack.sh")}"
  iam_instance_profile        = "${aws_iam_instance_profile.wiki_profile.name}"
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
    Name = "Bookstack"
  }
}
