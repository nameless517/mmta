terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
    }
  }
  required_version = ">= 0.13"
}

resource "tls_private_key" "generic-ssh-key {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "hcloud_ssh_key" "primary-ssh-key" {
  name        = "primary-ssh-key"
  public_key  = tls_private_key.generic-ssh-key.public_key_openssh
}

resource "hcloud_network" "network" {
  name      = "mmta"
  ip_range  = "10.0.0.0/16"
}

resource "hcloud_network_subnet" "network_subnet"
  type          = "cloud"
  network_id    = locust.mmta
  network_zone  = "eu-central"
  ip_range      = "10.0.1.0/24"
}

resource "hcloud_server" "locust-mst" {
  name        = "locust-mst"
  server_type = "cx11"
  image       = "debian-12"
  backups     = false
  location    = "fsn1"
  labels      = {
    "environment":"test",
    "service":"locust",
    "vm_type":"master"
  }
  public_net {
    ipv4_enabled  = true
    ipv4          = hcloud_primary_ip.primary_ip_1.id
    ipv6_enabled  = false

  network {
    network_id  = locust.mmta
    ip          = "10.0.1.10"
  }
  depends_on = [
    hcloud_network_subnet.network-subnet
  ]
}

resource "hcloud_server" "locust-wrk01" {
  name        = "locust-wrk01"
  server_type = "cx11"
  image       = "debian-12"
  backups     = false
  location    = "fsn1"
  labels      = {
    "environment":"test",
    "service":"locust",
    "vm_type":"wrk01"
  }
  public_net {
    ipv4_enabled  = true
    ipv4          = hcloud_primary_ip.primary_ip_1.id
    ipv6_enabled  = false

  network {
    network_id  = locust.mmta
    ip          = "10.0.1.11"
  }
  depends_on = [
    hcloud_network_subnet.network-subnet
  ]
}

resource "hcloud_server" "locust-wrk02" {
  name        = "locust-wrk02"
  server_type = "cx11"
  image       = "debian-12"
  backups     = false
  location    = "fsn1"
  labels      = {
    "environment":"test",
    "service":"locust",
    "vm_type":"wrk02"
  }
  public_net {
    ipv4_enabled  = true
    ipv4          = hcloud_primary_ip.primary_ip_1.id
    ipv6_enabled  = false

  network {
    network_id  = locust.mmta
    ip          = "10.0.1.12"
  }
  depends_on = [
    hcloud_network_subnet.network-subnet
  ]
}
