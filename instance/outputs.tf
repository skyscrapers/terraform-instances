output "instance_ids" {
  value = ["${var.ebs_enabled ? aws_instance.instance.*.id : aws_instance.instance_no_ebs.*.id}"]
}

output "instance_azs" {
  value = ["${var.ebs_enabled ? aws_instance.instance.*.availability_zone : aws_instance.instance_no_ebs.*.availability_zone}"]
}

output "instance_placement_groups" {
  value = ["${var.ebs_enabled ? aws_instance.instance.*.placement_group : aws_instance.instance_no_ebs.*.placement_group}"]
}

output "instance_key_names" {
  value = ["${var.ebs_enabled ? aws_instance.instance.*.key_name : aws_instance.instance_no_ebs.*.key_name}"]
}

output "instance_public_dns" {
  value = ["${var.ebs_enabled ? aws_instance.instance.*.public_dns : aws_instance.instance_no_ebs.*.public_dns}"]
}

output "instance_public_ips" {
  value = ["${var.ebs_enabled ? aws_instance.instance.*.public_ip : aws_instance.instance_no_ebs.*.public_ip}"]
}

output "instance_network_interface_ids" {
  value = ["${var.ebs_enabled ? aws_instance.instance.*.network_interface_id : aws_instance.instance_no_ebs.*.network_interface_id}"]
}

output "instance_private_dns" {
  value = ["${var.ebs_enabled ? aws_instance.instance.*.private_dns : aws_instance.instance_no_ebs.*.private_dns}"]
}

output "instance_private_ip" {
  value = ["${var.ebs_enabled ? aws_instance.instance.*.private_ip : aws_instance.instance_no_ebs.*.private_ip}"]
}

output "instance_vpc_security_group_ids" {
  value = ["${var.ebs_enabled ? aws_instance.instance.*.instance_vpc_security_group_ids : aws_instance.instance_no_ebs.*.instance_vpc_security_group_ids}"]
}

output "instance_subnet_ids" {
  value = ["${var.ebs_enabled ? aws_instance.instance.*.subnet_id : aws_instance.instance_no_ebs.*.subnet_id}"]
}

output "role_id" {
  value = "${aws_iam_role.role.id}"
}
