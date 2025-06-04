locals {
  metrics_id  = data.grafana_cloud_stack.stack.prometheus_user_id
  metrics_url = data.grafana_cloud_stack.stack.prometheus_remote_write_endpoint

  profiles_id  = data.grafana_cloud_stack.stack.profiles_user_id
  profiles_url = data.grafana_cloud_stack.stack.profiles_url

  logs_id  = data.grafana_cloud_stack.stack.logs_user_id
  logs_url = data.grafana_cloud_stack.stack.logs_url
}

resource "grafana_fleet_management_pipeline" "pipeline" {
  provider = grafana.fm

  name = "profiling"
  contents = templatefile(
    "profiling.alloy.tftpl",
    {
      profiles_id  = local.profiles_id,
      profiles_url = local.profiles_url,
    },
  )
  matchers = [
    "env=\"PROD\""
  ]
  enabled = true
}

resource "grafana_fleet_management_pipeline" "windows_metrics_pipeline" {
  provider = grafana.fm

  name = "windows_metrics"
  contents = templatefile(
    "windows-metrics.alloy.tftpl",
    {
      metrics_id  = local.metrics_id,
      metrics_url = local.metrics_url,
    },
  )
  matchers = [
    "collector.os=\"windows\"",
    "env=\"PROD\"",
    "platform!=\"kubernetes\""
  ]
  enabled = true
}

resource "grafana_fleet_management_pipeline" "windows_logs_pipeline" {
  provider = grafana.fm

  name = "windows_logs"
  contents = templatefile(
    "windows-logs.tftpl",
    {
      logs_id  = local.logs_id,
      logs_url = local.logs_url,
    },
  )
  matchers = [
    "collector.os=\"windows\"",
    "env=\"PROD\"",
    "platform!=\"kubernetes\""
  ]
  enabled = true
}

resource "grafana_fleet_management_pipeline" "linux_metrics_pipeline" {
  provider = grafana.fm

  name = "linux_metrics"
  contents = templatefile(
    "linux-metrics.tftpl",
    {
      metrics_id  = local.metrics_id,
      metrics_url = local.metrics_url,
    },
  )
  matchers = [
    "collector.os=\"linux\"",
    "env=\"PROD\"",
    "platform!=\"kubernetes\""
  ]
  enabled = true
}
