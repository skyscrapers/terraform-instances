locals {
  metadatas = [
    for n in range(var.amount_of_instances) : templatefile("${path.module}/templates/metadata.tftpl", {
      number       = n
      environment  = var.environment == "production" ? "" : "-${var.environment}"
      project      = var.project == null ? "" : "-${var.project}"
      customer     = var.customer
      function     = var.function
      puppetmaster = var.puppetmaster
      domain       = var.domain
    })
  ]
}
