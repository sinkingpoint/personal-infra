resource "aws_security_group" "public_ssh" {
  name = "allow_public_ssh"
  description = "Allow SSH from the internet"
  vpc_id = "${var.sinking_vpc}"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}
