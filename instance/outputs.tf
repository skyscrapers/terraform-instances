output "instance_ids" {
  value = ["${aws_instance.instance.*.id}"]
}

output "role_id" {
  value = "${aws_iam_role.role.id}"
}
