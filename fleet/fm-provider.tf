locals {
  fm_id    = data.grafana_cloud_stack.stack.fleet_management_user_id
  fm_token = grafana_cloud_access_policy_token.fm_token.token
  fm_url   = data.grafana_cloud_stack.stack.fleet_management_url
}

provider "grafana" {
  alias = "fm"

  fleet_management_auth = "${local.fm_id}:${local.fm_token}"
  fleet_management_url  = local.fm_url
}