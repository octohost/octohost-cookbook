provider "digitalocean" {
  token = "${var.do_token}"
}

resource "digitalocean_droplet" "octohost" {
  image = "${var.image_id}"
  name = "octohost"
  region = "nyc3"
  size = "1gb"
  private_networking = true
  ssh_keys = [ssh-keys-go-here]
}
