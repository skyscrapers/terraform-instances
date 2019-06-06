variable "amount_of_instances" {
  description = "For how many instances do you need user data"
  default     = "1"
}

variable "customer" {
  description = "Customer name"
}

variable "project" {
  description = "Name of the project"
  default     = ""
}

variable "environment" {
  description = "Environment it runs in"
}

variable "function" {
  description = "Function of the server (eg web, db, elasticsearch)"
}

variable "puppetmaster" {
  description = "Hostname of puppetmaster"
  default     = "puppetmaster01.int.skyscrape.rs"
}

variable "domain" {
  description = "Domain to set as hostname"
  default     = "skyscrape.rs"
}

