resource "cloudflare_record" "corvus" {
  domain = "${var.domain}"
  name   = "corvus"
  type   = "A"
  value  = "${var.corvus}"
}

resource "cloudflare_record" "corvus_in" {
  domain = "${var.domain}"
  name   = "corvus.in"
  type   = "A"
  value  = "${var.corvus_in}"
}

resource "cloudflare_record" "wiki" {
  domain = "${var.domain}"
  name   = "wiki-2"
  type   = "CNAME"
  value  = "${var.wiki}"
}
