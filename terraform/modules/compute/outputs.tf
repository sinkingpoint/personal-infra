output "db_internal_ip" {
  value = "${aws_instance.database_master.private_ip}"
}

output "db_ip" {
  value = "${aws_instance.database_master.public_ip}"
}
