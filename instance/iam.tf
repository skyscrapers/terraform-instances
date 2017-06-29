resource "aws_iam_instance_profile" "profile" {
  name  = "profile_${var.name}_${var.project}_${var.environment}"
  count = "${var.instance_count == "0" ? 0 : 1}"
  role  = "${aws_iam_role.role.name}"
}

resource "aws_iam_role" "role" {
  name  = "role_${var.name}_${var.project}_${var.environment}"
  count = "${var.instance_count == "0" ? 0 : 1}"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
