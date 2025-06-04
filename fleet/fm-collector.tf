resource "grafana_fleet_management_collector" "fm_collector" {
  provider = grafana.fm

  id = "prod_collector"
  remote_attributes = {
    "env" = "PROD"
  }
  enabled = true
}