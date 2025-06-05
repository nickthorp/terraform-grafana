terraform {
  required_providers {
    grafana = {
      source  = "grafana/grafana"
      version = ">= 3.25.1"
    }
  }
}

variable "cloud_access_policy_token" {
  description = "Cloud Access Policy token for Grafana Cloud"
  type        = string
  sensitive   = true
}

provider "grafana" {
  alias = "cloud"

  cloud_access_policy_token = var.cloud_access_policy_token
}

data "grafana_cloud_stack" "stack" {
  provider = grafana.cloud

  slug = "nuggle"
}