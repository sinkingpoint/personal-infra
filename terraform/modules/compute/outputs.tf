output "db_internal_ip" {
  value = "${aws_instance.database_template.private_ip}"
}

output "db_ip" {
  value = "${aws_instance.database_template.public_ip}"
}
