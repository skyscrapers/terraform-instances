output "user_datas" {
  value = templatefile("${path.module}/templates/metadata.tftpl", {
    number       = count.index + 1
    environment  = var.environment == "production" ? "" : "-${var.environment}"
    project      = var.project == null ? "" : "-${var.project}"
    customer     = var.customer
    function     = var.function
    puppetmaster = var.puppetmaster
    domain       = var.domain
  })
}
