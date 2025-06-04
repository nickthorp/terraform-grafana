resource "grafana_cloud_access_policy" "alloy_policy" {
  provider = grafana.cloud

  name   = "alloy-policy"
  region = data.grafana_cloud_stack.stack.region_slug

  scopes = [
    "set:alloy-data-write"
  ]

  realm {
    type       = "stack"
    identifier = data.grafana_cloud_stack.stack.id
  }
}

resource "grafana_cloud_access_policy_token" "alloy_token" {
  provider = grafana.cloud

  name             = "alloy-token"
  region           = grafana_cloud_access_policy.alloy_policy.region
  access_policy_id = grafana_cloud_access_policy.alloy_policy.policy_id
}

output "alloy_token" {
  value     = grafana_cloud_access_policy_token.alloy_token.token
  sensitive = true
}