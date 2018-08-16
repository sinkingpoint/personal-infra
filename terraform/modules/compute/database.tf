resource "aws_instance" "database_template" {
  ami = "${data.aws_ami.debian-stretch.id}"
  instance_type = "t2.micro"
  availability_zone = "eu-west-2a"
  subnet_id = "${var.sinking_subnet_eu_west_2a}"
  vpc_security_group_ids = ["${aws_security_group.public_ssh.id}"]
  user_data = "${file("${path.module}/init_scripts/db.sh")}"
  associate_public_ip_address = true
  key_name = "personal-infra"
}

