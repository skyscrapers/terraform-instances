resource "aws_instance" "instance" {
  count                       = "${var.instance_count}"
  ami                         = "${var.ami}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.key_name}"
  iam_instance_profile        = "${aws_iam_instance_profile.profile.id}"
  vpc_security_group_ids      = ["${var.sgs}"]
  subnet_id                   = "${element(var.subnets, count.index)}"
  disable_api_termination     = "${var.termination_protection}"
  ebs_optimized               = "${var.ebs_optimized}"
  associate_public_ip_address = "${var.public_ip}"
  user_data                   = "${element(var.user_data, count.index)}"

  root_block_device {
    volume_type           = "${var.root_vl_type}"
    volume_size           = "${var.root_vl_size}"
    delete_on_termination = "${var.root_vl_delete}"
  }

  ebs_block_device = ["${var.ebs_block_devices}"]

  tags {
    Name        = "${var.project}-${var.environment}-${var.name}${count.index + 1}"
    Function    = "${var.name}"
    Environment = "${var.environment}"
    Project     = "${var.project}"
  }
}
