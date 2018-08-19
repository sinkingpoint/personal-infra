resource "aws_security_group" "public_ssh" {
  name        = "allow_public_ssh"
  description = "Allow SSH from the internet"
  vpc_id      = "${var.sinking_vpc}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "internal_mysql" {
  name        = "Internal MySQL"
  description = "Allow MySQL traffic from internal"
  vpc_id      = "${var.sinking_vpc}"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
}

resource "aws_security_group" "internal_8080" {
  name        = "Internal 8080"
  description = "Allow 8080 from the internet"
  vpc_id      = "${var.sinking_vpc}"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
}

resource "aws_security_group" "public_80" {
  name        = "Public 80"
  description = "Allow 80 from the internet"
  vpc_id      = "${var.sinking_vpc}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
