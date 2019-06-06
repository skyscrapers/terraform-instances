terraform {
  required_version = ">= 0.12"
}

data "template_file" "metadata_puppet" {
  count    = var.amount_of_instances
  template = file("${path.module}/templates/metadata.tpl")

  vars = {
    number       = count.index + 1
    environment  = var.environment == "production" ? "" : "-${var.environment}"
    project      = var.project == "" ? "" : "-${var.project}"
    customer     = var.customer
    function     = var.function
    puppetmaster = var.puppetmaster
    domain       = var.domain
  }
}
