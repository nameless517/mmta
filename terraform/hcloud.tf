variable "hcloud_token"

provider "hcloud" {
  token = "${var.hcloud_token}"
}

resource "hcloud_server" "locust_mst" {
  name  = "locust_mst"
  image = "debian-12"
  server_type = "cx11"
}

resource "hcloud_server" "locust_wrk01" {
  name  = "locust_wrk01"
  image = "debian-12"
  server_type = "cx11"
}

resource "hcloud_server" "locust_wrk02" {
  name  = "locust_wrk02"
  image = "debian-12"
  server_type = "cx11"
}
