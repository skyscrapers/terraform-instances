resource "aws_iam_instance_profile" "profile" {
  count = "${var.instance_count == "0" ? 0 : 1}"
  name  = "profile_${var.name}_${var.project}_${var.environment}"
  role  = "${aws_iam_role.role.name}"
}

resource "aws_iam_role" "role" {
  count = "${var.instance_count == "0" ? 0 : 1}"
  name  = "role_${var.name}_${var.project}_${var.environment}"

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
