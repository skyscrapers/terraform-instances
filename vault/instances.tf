module "vault1" {
  source        = "github.com/skyscrapers/terraform-instances//instance?ref=2.0.8"
  project       = "${var.project}"
  environment   = "${terraform.workspace}"
  name          = "vault1"
  sgs           = ["${aws_security_group.vault.id}", "${var.teleport_node_sg}"]
  subnets       = ["${var.vault1_subnet}"]
  key_name      = "${var.key_name}"
  ami           = "${var.ami}"
  instance_type = "${var.instance_type}"
  user_data     = ["${data.template_cloudinit_config.vault1.rendered}"]
}

module "vault2" {
  source        = "github.com/skyscrapers/terraform-instances//instance?ref=2.0.8"
  project       = "${var.project}"
  environment   = "${terraform.workspace}"
  name          = "vault2"
  sgs           = ["${aws_security_group.vault.id}", "${var.teleport_node_sg}"]
  subnets       = ["${var.vault2_subnet}"]
  key_name      = "${var.key_name}"
  ami           = "${var.ami}"
  instance_type = "${var.instance_type}"
  user_data     = ["${data.template_cloudinit_config.vault2.rendered}"]
}
