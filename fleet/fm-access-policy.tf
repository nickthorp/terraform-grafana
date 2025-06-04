resource "grafana_cloud_access_policy" "fm_policy" {
  provider = grafana.cloud

  name   = "fleet-management-policy"
  region = data.grafana_cloud_stack.stack.region_slug

  scopes = [
    "fleet-management:read",
    "fleet-management:write"
  ]

  realm {
    type       = "stack"
    identifier = data.grafana_cloud_stack.stack.id
  }
}

resource "grafana_cloud_access_policy_token" "fm_token" {
  provider = grafana.cloud

  name             = "fleet-management-token"
  region           = grafana_cloud_access_policy.fm_policy.region
  access_policy_id = grafana_cloud_access_policy.fm_policy.policy_id
}