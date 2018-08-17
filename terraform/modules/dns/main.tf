resource "cloudflare_record" "sinking_record" {
  domain = "${var.domain}"
  name = "${lookup(var.records[count.index], "name")}"
  type = "${lookup(var.records[count.index], "type")}"
  value = "${lookup(var.records[count.index], "value")}"
}
