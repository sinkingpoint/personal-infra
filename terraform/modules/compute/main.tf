data "aws_ami" "debian-stretch" {
  most_recent = true

  filter {
    name   = "name"
    values = ["debian-stretch-hvm-x86_64-gp2-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["379101102735"]
}

data "aws_s3_bucket" "database_backups" {
  bucket = "sinking-database-backups"
}
