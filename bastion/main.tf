# Create bastion sg
resource "aws_security_group" "sg_bastion" {
  name        = "sg_${var.name}_${var.project}_${var.environment}"
  description = "Security group for bastion hosts"
  vpc_id      = "${var.vpc_id}"

  tags {
    Name        = "${var.project}-${var.environment}-sg_${var.name}"
    Environment = "${var.environment}"
    Project     = "${var.project}"
  }
}

# Add a rule to security group sg_all to allow SSH connection from the bastion server
resource "aws_security_group_rule" "sg_bastion_in_ssh" {
  type                     = "ingress"
  security_group_id        = "${var.sg_all_id}"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.sg_bastion.id}"
}

resource "aws_security_group_rule" "sg_bastion_out_ssh" {
  type                     = "egress"
  security_group_id        = "${aws_security_group.sg_bastion.id}"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${var.sg_all_id}"
}

module "bastion_host" {
  source                 = "../instance"
  name                   = "${var.name}"
  subnets                = "${var.subnets}"
  project                = "${var.project}"
  environment            = "${var.environment}"
  ami                    = "${var.ami}"
  instance_type          = "${var.instance_type}"
  key_name               = "${var.ssh_key_name}"
  sgs                    = "${concat(list("${aws_security_group.sg_bastion.id}"),"${var.sgs}")}"
  instance_count         = "1"
  termination_protection = "${var.termination_protection}"
  ebs_optimized          = "${var.ebs_optimized}"
  root_vl_type           = "${var.root_vl_type}"
  root_vl_size           = "${var.root_vl_size}"
  root_vl_delete         = "${var.root_vl_delete}"
  user_data              = "${var.user_data}"
  public_ip              = "true"
  ebs_block_devices      = ["${var.ebs_block_devices}"]
  ebs_enabled            = "${var.ebs_enabled}"
}

resource "aws_eip" "bastion_eip" {
  vpc      = true
  instance = "${element(module.bastion_host.instance_ids, 0)}"
}

resource "aws_iam_role_policy" "policy" {
  name   = "policy_${var.name}_${var.project}_${var.environment}"
  role   = "${module.bastion_host.role_id}"
  policy = "${var.policy}"
}
