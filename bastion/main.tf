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

module "bastion_host" {
  source                 = "../instance"
  name                   = "${var.name}"
  subnets                = "${var.subnets}"
  project                = "${var.project}"
  environment            = "${var.environment}"
  ami                    = "${var.ami}"
  instance_type          = "${var.instance_type}"
  key_name               = "${var.ssh_key_name}"
  public_ip              = "${var.public_ip}"
  sgs                    = "${concat(list("${aws_security_group.sg_bastion.id}"),"${var.sgs}")}"
  instance_count         = "${var.instance_count}"
  termination_protection = "${var.termination_protection}"
  ebs_optimized          = "${var.ebs_optimized}"
  root_vl_type           = "${var.root_vl_type}"
  root_vl_size           = "${var.root_vl_size}"
  root_vl_delete         = "${var.root_vl_delete}"
  user_data              = "${var.user_data}"
}

resource "aws_eip" "bastion_eip" {
  vpc      = true
  count    = "${var.instance_count}"
  instance = "${module.bastion_host.instance_ids[count]}"
}

resource "aws_iam_role_policy" "policy" {
  name   = "policy_${var.name}_${var.project}_${var.environment}"
  role   = "${module.bastion_host.role_id}"
  policy = "${var.policy}"
}
