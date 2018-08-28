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
  value   = "${var.prometheus_in}"
  proxied = false
}

resource "cloudflare_record" "grafana" {
  domain  = "${var.domain}"
  name    = "grafana"
  type    = "A"
  value   = "${var.grafana}"
  proxied = true
}

resource "cloudflare_record" "alertmanager" {
  domain  = "${var.domain}"
  name    = "alertmanager"
  type    = "A"
  value   = "${var.prometheus}"
  proxied = true
}

resource "cloudflare_record" "alertmanager_in" {
  domain  = "${var.domain}"
  name    = "alertmanager.in"
  type    = "A"
  value   = "${var.prometheus_in}"
  proxied = false
}

resource "cloudflare_record" "jenkins" {
  domain  = "${var.domain}"
  name    = "jenkins"
  type    = "A"
  value   = "${var.jenkins}"
  proxied = false
}
