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
  domain  = "${var.domain}"
  name    = "wiki"
  type    = "CNAME"
  value   = "${var.wiki}"
  proxied = true
}

resource "cloudflare_record" "prometheus" {
  domain  = "${var.domain}"
  name    = "prometheus"
  type    = "CNAME"
  value   = "${var.prometheus}"
  proxied = true
}
