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

variable "vpc_id" {

}

variable "sg_all_id" {

}

variable "ssh_key_name" {

}
