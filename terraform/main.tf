provider "hcloud" {
token = "${var.hcloud_token}"
}

resource "random_string" "name" {
length = 3
special = false
upper = false
}

locals {
name = "${var.name}-${terraform.env}-${random_string.name.result}"
}
