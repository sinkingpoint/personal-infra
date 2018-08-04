variable "domain" {
    default = "sinkingpoint.com"
}

variable "cloudflare_token" {}

provider "cloudflare" {
    email = "colin@quirl.co.nz"
    token = "${var.cloudflare_token}"
}

