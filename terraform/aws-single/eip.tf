resource "aws_eip" "octohost-single-terraform" {
    instance = "${aws_instance.master.id}"
}
