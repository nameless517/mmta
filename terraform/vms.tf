resource "hcloud_server" "server" {
  name = "master-${local.name}"
  image = "${var.image}"
  server_type = "${var.server_type}"
  location = "${var.location}"
  backups = "false"
  ssh_keys = ["${hcloud_ssh_key.user.id}"
  user_data = "${data.template_file.instance.rendered}"

  provisioner "file" {
    source = "user-data/file"
    destination = "/root/file"
  }
}

resource "hcloud_ssh_key" "user" {
  name = "user"
  public_key = "${var.public_key}"
}

