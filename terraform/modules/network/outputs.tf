output "sinking_vpc_id" {
  value = "${aws_vpc.sinking_internally.id}"
}

output "sinking_subnet_eu_west_2a" {
  value = "${aws_subnet.sinking_subnet-eu-west-2a.id}"
}

output "sinking_subnet_eu_west_2b" {
  value = "${aws_subnet.sinking_subnet-eu-west-2b.id}"
}

output "sinking_subnet_eu_west_2c" {
  value = "${aws_subnet.sinking_subnet-eu-west-2c.id}"
}
