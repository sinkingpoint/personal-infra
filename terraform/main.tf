provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

module "network" {
  source = "modules/network"
}

module "compute" {
  source = "modules/compute"
  sinking_vpc = "${module.network.sinking_vpc_id}"
  sinking_subnet_eu_west_2a = "${module.network.sinking_subnet_eu_west_2a}"
  sinking_subnet_eu_west_2b = "${module.network.sinking_subnet_eu_west_2b}"
  sinking_subnet_eu_west_2c = "${module.network.sinking_subnet_eu_west_2c}"
}

