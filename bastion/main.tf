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
    source = "github.com/skyscrapers/terraform-instances//instance?ref=425204d"
    name = "bastion"
    subnets = "${var.subnets}"
    project = "${var.project}"
    environment = "${var.environment}"
    ami = "${var.ami}"
    instance_type = "${var.instance_type}"
    key_name = "${var.ssh_key_name}"
    public_ip = true
    sgs = "${concat(list("${aws_security_group.sg_bastion.id}"),"${var.sgs}")}"
}

resource "aws_eip" "bastion_eip" {
  vpc       = true
  instance  = "${module.bastion_host.instance_ids[0]}"
}

resource "aws_iam_role_policy" "policy" {
    name = "policy_bastion_${var.project}_${var.environment}"
    role = "${module.bastion_host.role_id}"
    policy = "${var.policy}"
}
