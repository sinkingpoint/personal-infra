output "db_internal_ip" {
  value = "${aws_instance.database_master.private_ip}"
}

output "db_ip" {
  value = "${aws_instance.database_master.public_ip}"
}

output "bookstack_cname_target" {
  value = "${aws_elb.bookstack_elb.dns_name}"
}

output "prometheus_cname_target" {
  value = "${aws_elb.prometheus_elb.dns_name}"
}

output "grafana_cname_target" {
  value = "${aws_elb.grafana_elb.dns_name}"
}
