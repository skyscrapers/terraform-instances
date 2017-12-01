output "bastion_sg_id" {
  value = "${aws_security_group.sg_bastion.id}"
}

output "instance_id" {
  value = "${module.bastion_host.instance_ids[0]}"
}

output "instance_az" {
  value = "${module.bastion_host.instance_azs[0]}"
}

output "instance_key_name" {
  value = "${module.bastion_host.instance_key_names[0]}"
}

output "instance_public_dns" {
  value = "${module.bastion_host.instance_public_dns[0]}"
}

output "instance_public_ip" {
  value = "${module.bastion_host.instance_public_ips[0]}"
}

output "instance_network_interface_id" {
  value = "${module.bastion_host.instance_network_interface_ids[0]}"
}

output "instance_private_ip" {
  value = "${module.bastion_host.instance_private_ip[0]}"
}

output "instance_vpc_security_group_id" {
  value = "${aws_security_group.sg_bastion.id}"
}

output "instance_subnet_id" {
  value = "${module.bastion_host.instance_subnet_ids[0]}"
}

output "iam_role_id" {
  value = "${module.bastion_host.role_id}"
}
