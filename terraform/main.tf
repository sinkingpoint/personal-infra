provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

provider "cloudflare" {
  email = "${var.cloudflare_email}"
  token = "${var.cloudflare_token}"
}

module "network" {
  source = "modules/network"
}

module "compute" {
  source                    = "modules/compute"
  sinking_vpc               = "${module.network.sinking_vpc_id}"
  sinking_subnet_eu_west_2a = "${module.network.sinking_subnet_eu_west_2a}"
  sinking_subnet_eu_west_2b = "${module.network.sinking_subnet_eu_west_2b}"
  sinking_subnet_eu_west_2c = "${module.network.sinking_subnet_eu_west_2c}"
}

module "dns" {
  source = "modules/dns"
  domain = "sinkingpoint.com"

  corvus     = "${module.compute.db_ip}"
  corvus_in  = "${module.compute.db_internal_ip}"
  wiki       = "${module.compute.bookstack_cname_target}"
  prometheus = "${module.compute.prometheus_cname_target}"
  grafana    = "${module.compute.grafana_cname_target}"
}
