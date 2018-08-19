data "aws_s3_bucket" "database_backups" {
  bucket = "sinking-database-backups"
}

resource "aws_iam_policy" "database_policy" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
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

resource "aws_iam_role" "database_role" {
  name = "database_role"

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

resource "aws_iam_policy_attachment" "database_policy_role" {
  name       = "database_role_attachment"
  policy_arn = "${aws_iam_policy.database_policy.arn}"
  roles      = ["${aws_iam_role.database_role.name}"]
}

resource "aws_iam_instance_profile" "database_profile" {
  name = "database_profile"
  role = "${aws_iam_role.database_role.name}"
}

resource "aws_instance" "database_master" {
  ami               = "${data.aws_ami.debian-stretch.id}"
  instance_type     = "t2.micro"
  availability_zone = "eu-west-2a"
  subnet_id         = "${var.sinking_subnet_eu_west_2a}"

  vpc_security_group_ids = [
    "${aws_security_group.public_ssh.id}",
    "${aws_security_group.internal_mysql.id}",
    "${aws_security_group.internal_node_exporter.id}",
  ]

  user_data                   = "${file("${path.module}/init_scripts/db.sh")}"
  associate_public_ip_address = true
  key_name                    = "personal-infra"
  iam_instance_profile        = "${aws_iam_instance_profile.database_profile.name}"
}
