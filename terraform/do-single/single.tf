provider "digitalocean" {
  token = "${var.do_token}"
}

resource "digitalocean_droplet" "octohost" {
  image = "${var.image_id}"
  name = "${var.octohost_name}"
  region = "nyc3"
  size = "1gb"
  private_networking = true
  ssh_keys = ["${var.ssh_key}"]

  provisioner "remote-exec" {
    inline = [
        "curl -s ${var.keys_url} > /tmp/ssh-keys"
      ]
  }

  provisioner "remote-exec" {
    scripts = [
      "../scripts/consul-bootstrap-do-single.sh",
      "../scripts/install-keys.sh"
    ]
  }
}
