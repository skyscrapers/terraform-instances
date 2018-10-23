locals {
  cpu_credits_available = "${contains(var.cpu_credits_list,var.instance_type)}"
}

variable "cpu_credits_list" {
  type = "list"

  default = [
    "t3.nano",
    "t3.micro",
    "t3.small",
    "t3.medium",
    "t3.large",
    "t3.xlarge",
    "t3.2xlarge",
  ]
}
