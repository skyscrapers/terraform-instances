output "instance_ids" {
  value = ["${concat(aws_instance.instance.*.id,aws_instance.instance_no_ebs.*.id)}"]
}

output "instance_azs" {
  value = ["${concat(aws_instance.instance.*.availability_zone, aws_instance.instance_no_ebs.*.availability_zone) }"]
}

output "instance_key_names" {
  value = ["${concat(aws_instance.instance.*.key_name, aws_instance.instance_no_ebs.*.key_name)}"]
}

output "instance_public_dns" {
  value = ["${concat(aws_instance.instance.*.public_dns, aws_instance.instance_no_ebs.*.public_dns)}"]
}

output "instance_public_ips" {
  value = ["${concat(aws_instance.instance.*.public_ip, aws_instance.instance_no_ebs.*.public_ip)}"]
}

output "instance_network_interface_ids" {
  value = ["${concat(aws_instance.instance.*.network_interface_id, aws_instance.instance_no_ebs.*.network_interface_id)}"]
}

output "instance_private_dns" {
  value = ["${concat(aws_instance.instance.*.private_dns, aws_instance.instance_no_ebs.*.private_dns)}"]
}

output "instance_private_ip" {
  value = ["${concat(aws_instance.instance.*.private_ip, aws_instance.instance_no_ebs.*.private_ip)}"]
}

output "instance_vpc_security_group_ids" {
  value = ["${concat(aws_instance.instance.*.vpc_security_group_ids, aws_instance.instance_no_ebs.*.vpc_security_group_ids)}"]
}

output "instance_subnet_ids" {
  value = ["${concat(aws_instance.instance.*.subnet_id, aws_instance.instance_no_ebs.*.subnet_id) }"]
}

output "role_id" {
  value = "${aws_iam_role.role.0.id}"
}

output "role_name" {
  value = "${aws_iam_role.role.0.name}"
}
