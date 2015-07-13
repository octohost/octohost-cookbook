provider "openstack" {
  user_name  = "${var.os_username}"
  tenant_name = "${var.os_tenant_name}"
  password  = "${var.os_password}"
  auth_url  = "${var.os_auth_url}"
  endpoint_type = "public"
}

resource "openstack_compute_instance_v2" "octohost" {
  name = "octohost"
  image_id = "${var.image_id}"
  flavor_id = "${var.flavor_id}"
  key_pair = "${var.key_pair}"
  region = "${var.os_region_name}"

  provisioner "remote-exec" {
    scripts = [
      "./scripts/user-data.sh"
    ]
  }
}
