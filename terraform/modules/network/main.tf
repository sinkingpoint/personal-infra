resource "aws_vpc" "sinking_internally" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  assign_generated_ipv6_cidr_block = true

  tags {
    Name = "sinking_internally"
  }
}

resource "aws_internet_gateway" "sinking_gateway" {
  vpc_id = "${aws_vpc.sinking_internally.id}"

  tags {
    Name = "sinking_gateway"
  }
}

resource "aws_subnet" "sinking_subnet-eu-west-2a" {
  vpc_id = "${aws_vpc.sinking_internally.id}"
  availability_zone = "eu-west-2a"
  cidr_block = "10.0.1.0/24"

  tags {
    Name = "Sinking Subnet - eu-west-2a"
  }
}

resource "aws_subnet" "sinking_subnet-eu-west-2b" {
  vpc_id = "${aws_vpc.sinking_internally.id}"
  availability_zone = "eu-west-2b"
  cidr_block = "10.0.2.0/24"

  tags {
    Name = "Sinking Subnet - eu-west-2b"
  }
}

resource "aws_subnet" "sinking_subnet-eu-west-2c" {
  vpc_id = "${aws_vpc.sinking_internally.id}"
  availability_zone = "eu-west-2c"
  cidr_block = "10.0.3.0/24"

  tags {
    Name = "Sinking Subnet - eu-west-2c"
  }
}

resource "aws_route_table" "sinking_routes" {
  vpc_id = "${aws_vpc.sinking_internally.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.sinking_gateway.id}"
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id = "${aws_internet_gateway.sinking_gateway.id}"
  }

  tags {
    Name = "sinking_routes"
  }
}

resource "aws_main_route_table_association" "route_table_apply" {
  vpc_id = "${aws_vpc.sinking_internally.id}"
  route_table_id = "${aws_route_table.sinking_routes.id}"
}
