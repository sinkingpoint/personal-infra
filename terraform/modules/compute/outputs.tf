output "db_internal_ip" {
  value = "${aws_instance.database_master.private_ip}"
}

output "db_ip" {
  value = "${aws_instance.database_master.public_ip}"
}

output "bookstack_internal_ip" {
  value = "${aws_instance.bookstack_instance.private_ip}"
}

output "bookstack_ip" {
  value = "${aws_instance.bookstack_instance.public_ip}"
}

output "prometheus_internal_ip" {
  value = "${aws_instance.prometheus_instance.private_ip}"
}

output "prometheus_ip" {
  value = "${aws_instance.prometheus_instance.public_ip}"
}

output "grafana_internal_ip" {
  value = "${aws_instance.grafana_instance.private_ip}"
}

output "grafana_ip" {
  value = "${aws_instance.grafana_instance.public_ip}"
}

output "jenkins_ip" {
  value = "${aws_instance.jenkins_instance.public_ip}"
}
