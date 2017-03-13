output "instance_ids" {
  value = ["${aws_instance.instance.*.id}"]
}

output "instance_azs" {
  value = ["${aws_instance.instance.*.availability_zone}"]
}

output "instance_placement_groups" {
  value = ["${aws_instance.instance.*.placement_group}"]
}

output "instance_key_names" {
  value = ["${aws_instance.instance.*.key_name}"]
}

output "instance_public_dns" {
  value = ["${aws_instance.instance.*.public_dns}"]
}

output "instance_public_ips" {
  value = ["${aws_instance.instance.*.public_ip}"]
}

output "instance_network_interface_ids" {
  value = ["${aws_instance.instance.*.network_interface_id}"]
}

output "instance_private_dns" {
  value = ["${aws_instance.instance.*.private_dns}"]
}

output "instance_private_ip" {
  value = ["${aws_instance.instance.*.private_ip}"]
}

output "instance_vpc_security_group_ids" {
  value = ["${aws_instance.instance.*.instance_vpc_security_group_ids}"]
}

output "instance_subnet_ids" {
  value = ["${aws_instance.instance.*.subnet_id}"]
}

output "role_id" {
  value = "${aws_iam_role.role.id}"
}

output "instance_az" {
  value = ["${aws_instance.instance.*.availability_zone}"]
}
