# Create common security group
resource "aws_security_group" "sg_bastion" {
  name        = "sg_bastion_${var.project}_${var.environment}"
  description = "Security group on which rules can be added to allow more access into the environments"
  vpc_id      = "${var.vpc_id}"

  tags {
    Name        = "${var.project}-${var.environment}-sg_bastion"
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
  name                   = "bastion"
  subnets                = "${var.subnets}"
  project                = "${var.project}"
  environment            = "${var.environment}"
  ami                    = "${var.ami}"
  instance_type          = "${var.instance_type}"
  key_name               = "${var.ssh_key_name}"
  public_ip              = true
  sgs                    = "${concat(list("${aws_security_group.sg_bastion.id}"),"${var.sgs}")}"
  instance_count         = "${var.instance_count}"
  termination_protection = "${var.termination_protection}"
  ebs_optimized          = "${var.ebs_optimized}"
  public_ip              = false
  root_vl_type           = "${var.root_vl_type}"
  root_vl_size           = "${var.root_vl_size}"
  root_vl_delete         = "${var.root_vl_delete}"
  user_data              = "das"
}

resource "aws_eip" "bastion_eip" {
  vpc      = true
  count    = "${var.instance_count}"
  instance = "${module.bastion_host.instance_ids[count]}"
}

resource "aws_iam_role_policy" "policy" {
  name   = "policy_bastion_${var.project}_${var.environment}"
  role   = "${module.bastion_host.role_id}"
  policy = "${var.policy}"
}
