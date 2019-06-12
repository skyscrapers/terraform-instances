variable "project" {
}

variable "environment" {
}

variable "name" {
  default = "bastion"
}

variable "subnets" {
  description = "The subnets where the bastion host must be placed in."
  type        = list(string)
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
  type    = list(string)
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
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF

}

variable "termination_protection" {
  default = false
}

variable "root_vl_type" {
  default = "gp2"
}

variable "root_vl_size" {
  default = "30"
}

variable "root_vl_delete" {
  default = true
}

variable "user_data" {
  default = [""]
  type = list(string)
}

variable "ebs_block_devices" {
  type = list(map(string))
  default = []
}

variable "tags" {
  description = "Optional tags"
  type = map(string)
  default = {}
}

variable "cpu_credits" {
  type        = string
  description = "The type of cpu credits to use"
  default     = "standard"
}
