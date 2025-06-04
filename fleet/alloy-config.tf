resource "local_file" "alloy_config" {
  filename = "C:\\Program Files\\GrafanaLabs\\Alloy\\config.alloy"
  content = templatefile(
    "config.alloy.tftpl",
    {
      fm_id        = local.fm_id,
      fm_url       = local.fm_url,
    },
  )
  directory_permission = "0644"
  file_permission      = "0644"
}