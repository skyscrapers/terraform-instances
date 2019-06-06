output "user_datas" {
  value = [data.template_file.metadata_puppet.*.rendered]
}

