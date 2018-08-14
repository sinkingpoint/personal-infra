variable "region" {
    default = "europe-west2-a"
}

variable "ssh_key_file" {
    default = "~/.ssh/colin.pub"
}

variable "ssh_user" {
    default = "colin"
}

provider "google" {
  credentials = "${file("personalinfra.json")}"
  project     = "personal-infra-197122"
  region      = "${var.region}"
}

resource "google_compute_instance" "db" {
    count = 1
    name = "db"
    machine_type = "f1-micro"
    zone = "${var.region}"
    boot_disk {
        initialize_params {
            image = "debian-cloud/debian-9"
        }
    }

    metadata_startup_script = "${file("init_scripts/db.sh")}"

    network_interface {
        network = "default"
        access_config {}
    }

    metadata {
        sshKeys = "${var.ssh_user}:${file(var.ssh_key_file)}"
    }
}
