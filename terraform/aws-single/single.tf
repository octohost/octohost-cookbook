provider "aws" {
  region = "${var.region}"
}

resource "aws_instance" "master" {
    ami = "${lookup(var.amis, var.region)}"
    instance_type = "${var.size}"
    security_groups = ["${aws_security_group.octohost.name}"]
    key_name = "${var.key_name}"

    tags {
      Name = "octohost-master"
    }

    connection {
      user = "ubuntu"
      key_file = "${var.key_path}"
    }

    provisioner "remote-exec" {
      scripts = [
        "./scripts/user-data.sh"
      ]
    }
}
