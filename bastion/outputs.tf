output "bastion_sg_id" {
  value = "${aws_security_group.sg_bastion.id}"
}

output "instance_id" {
  value = ["${module.bastion_host.instance_ids}"]
}

output "instance_az" {
  value = ["${module.bastion_host.instance_azs}"]
}

output "instance_placement_group" {
  value = ["${module.bastion_host.instance_placement_groups}"]
}

output "instance_key_name" {
  value = ["${module.bastion_host.instance_key_names}"]
}

output "instance_public_dns" {
  value = ["${module.bastion_host.instance_public_dns}"]
}

output "instance_public_ip" {
  value = ["${module.bastion_host.instance_public_ips}"]
}

output "instance_network_interface_id" {
  value = ["${module.bastion_host.instance_network_interface_ids}"]
}

output "instance_private_ip" {
  value = ["${module.bastion_host.instance_private_ip}"]
}

output "instance_vpc_security_group_id" {
  value = ["${module.bastion_host.instance_vpc_security_group_ids}"]
}

output "instance_subnet_id" {
  value = ["${module.bastion_host.instance_subnet_ids}"]
}
