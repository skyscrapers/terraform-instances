terraform {
  required_version = ">= 0.12"
}

module "is_ebs_optimised" {
  source        = "../is_ebs_optimised"
  instance_type = var.instance_type
}

resource "aws_instance" "instance" {
  count                       = var.ebs_enabled ? var.instance_count : 0
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key_name
  iam_instance_profile        = aws_iam_instance_profile.profile[0].id
  vpc_security_group_ids      = var.sgs
  subnet_id                   = element(var.subnets, count.index)
  disable_api_termination     = var.termination_protection
  ebs_optimized               = module.is_ebs_optimised.is_ebs_optimised
  associate_public_ip_address = var.public_ip
  user_data                   = element(var.user_data, count.index)

  root_block_device {
    volume_type           = var.root_vl_type
    volume_size           = var.root_vl_size
    delete_on_termination = var.root_vl_delete
  }

  dynamic "ebs_block_device" {
    for_each = [var.ebs_block_devices]
    content {
      # TF-UPGRADE-TODO: The automatic upgrade tool can't predict
      # which keys might be set in maps assigned here, so it has
      # produced a comprehensive set here. Consider simplifying
      # this after confirming which keys can be set in practice.

      delete_on_termination = lookup(ebs_block_device.value, "delete_on_termination", null)
      device_name           = ebs_block_device.value.device_name
      encrypted             = lookup(ebs_block_device.value, "encrypted", null)
      iops                  = lookup(ebs_block_device.value, "iops", null)
      snapshot_id           = lookup(ebs_block_device.value, "snapshot_id", null)
      volume_size           = lookup(ebs_block_device.value, "volume_size", null)
      volume_type           = lookup(ebs_block_device.value, "volume_type", null)
    }
  }

  tags = merge(
    var.tags,
    {
      "Name"        = "${var.project}-${var.environment}-${var.name}${count.index + 1}"
      "Function"    = var.name
      "Environment" = var.environment
      "Project"     = var.project
    },
  )

  lifecycle {
    ignore_changes = [
      key_name,
      user_data,
    ]
  }

  credit_specification {
    cpu_credits = var.cpu_credits
  }
}

resource "aws_instance" "instance_no_ebs" {
  count                       = var.ebs_enabled ? 0 : var.instance_count
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key_name
  iam_instance_profile        = aws_iam_instance_profile.profile[0].id
  vpc_security_group_ids      = var.sgs
  subnet_id                   = element(var.subnets, count.index)
  disable_api_termination     = var.termination_protection
  ebs_optimized               = module.is_ebs_optimised.is_ebs_optimised
  associate_public_ip_address = var.public_ip
  user_data                   = element(var.user_data, count.index)

  root_block_device {
    volume_type           = var.root_vl_type
    volume_size           = var.root_vl_size
    delete_on_termination = var.root_vl_delete
  }

  tags = merge(
    var.tags,
    {
      "Name"        = "${var.project}-${var.environment}-${var.name}${count.index + 1}"
      "Function"    = var.name
      "Environment" = var.environment
      "Project"     = var.project
    },
  )

  lifecycle {
    ignore_changes = [
      key_name,
      user_data,
    ]
  }
}
