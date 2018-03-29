resource "aws_instance" "instance" {
  count                       = "${var.ebs_enabled ? var.instance_count : 0}"
  ami                         = "${var.ami}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.key_name}"
  iam_instance_profile        = "${aws_iam_instance_profile.profile.id}"
  vpc_security_group_ids      = ["${var.sgs}"]
  subnet_id                   = "${element(var.subnets, count.index)}"
  disable_api_termination     = "${var.termination_protection}"
  ebs_optimized               = "${contains(var.ebs_optimized_list,var.instance_type)}"
  associate_public_ip_address = "${var.public_ip}"
  user_data                   = "${element(var.user_data, count.index)}"

  root_block_device {
    volume_type           = "${var.root_vl_type}"
    volume_size           = "${var.root_vl_size}"
    delete_on_termination = "${var.root_vl_delete}"
  }

  ebs_block_device = ["${var.ebs_block_devices}"]

  tags = "${merge("${var.tags}",
    map("Name", "${var.project}-${var.environment}-${var.name}${count.index + 1}",
      "Function", "${var.name}",
      "Environment", "${var.environment}",
      "Project", "${var.project}"))
  }"

  lifecycle {
    ignore_changes = ["key_name", "user_data"]
  }
}

module "is_ebs_optimised" {
  source        = "../is_ebs_optimised"
  instance_type = "${var.instance_type}"
}

resource "aws_instance" "instance_no_ebs" {
  count                       = "${var.ebs_enabled ? 0 : var.instance_count}"
  ami                         = "${var.ami}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.key_name}"
  iam_instance_profile        = "${aws_iam_instance_profile.profile.id}"
  vpc_security_group_ids      = ["${var.sgs}"]
  subnet_id                   = "${element(var.subnets, count.index)}"
  disable_api_termination     = "${var.termination_protection}"
  ebs_optimized               = "${module.is_ebs_optimised.is_ebs_optimised}"
  associate_public_ip_address = "${var.public_ip}"
  user_data                   = "${element(var.user_data, count.index)}"

  root_block_device {
    volume_type           = "${var.root_vl_type}"
    volume_size           = "${var.root_vl_size}"
    delete_on_termination = "${var.root_vl_delete}"
  }

  tags = "${merge("${var.tags}",
    map("Name", "${var.project}-${var.environment}-${var.name}${count.index + 1}",
      "Function", "${var.name}",
      "Environment", "${var.environment}",
      "Project", "${var.project}"))
  }"

  lifecycle {
    ignore_changes = ["key_name", "user_data"]
  }
}
