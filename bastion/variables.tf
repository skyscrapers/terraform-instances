variable "project" {
}

variable "environment" {
}

variable "subnets" {
  description = "The subnets where the bastion host must be placed in."
  type = "list"
}

variable "ami" {
  description = "The id of the AMI created by Packer for the bastion host"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "vpc_id" {

}

variable "sg_all_id" {
  description = "ID of the generic security group that will be extended to allow SSH access from the bastion host"
}

variable "sgs" {
  type = "list"
  default = []
}

variable "ssh_key_name" {

}

variable "policy" {
  default = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "ecs:Describe*"
        ],
        "Effect": "Allow",
        "Resource": "*"
      }
    ]
  }
EOF
}