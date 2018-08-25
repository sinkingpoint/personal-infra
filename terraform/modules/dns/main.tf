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
  type    = "A"
  value   = "${var.wiki}"
  proxied = true
}

resource "cloudflare_record" "prometheus" {
  domain  = "${var.domain}"
  name    = "prometheus"
  type    = "A"
  value   = "${var.prometheus}"
  proxied = true
}

resource "cloudflare_record" "prometheus_in" {
  domain  = "${var.domain}"
  name    = "prometheus.in"
  type    = "A"
  value   = "${var.prometheus}"
  proxied = false
}

resource "cloudflare_record" "grafana" {
  domain  = "${var.domain}"
  name    = "grafana"
  type    = "A"
  value   = "${var.grafana}"
  proxied = true
}
