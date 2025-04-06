resource "yandex_mdb_mysql_cluster" "create_cluster_maint_weekly" {
  count = var.maintenance_window.type == "WEEKLY" ? 1 : 0

  name                = var.name
  environment         = var.environment
  version             = var.mssql_version
  security_group_ids  = []
  deletion_protection = var.deletion_protection

  mysql_config = {
    for k, v in local.mysql_config : k => v
  }

  access {
    data_lens     = var.access.data_lens
    data_transfer = var.access.data_transfer
    web_sql       = var.access.web_sql
  }

  network_id  = var.network.id

  dynamic "host" {
    for_each = var.count_nodes

    content {
      zone             = element(var.network.subnet.zones, host.key)
      subnet_id        = element(var.network.subnet.ids, host.key)
      priority         = var.host.priority
      backup_priority  = var.host.backup_priority
    }
  }

  resources {
    resource_preset_id = var.resources.resource_preset_id
    disk_type_id       = var.resources.disk_type_id
    disk_size          = var.resources.disk_size
  }

  maintenance_window {
    type = var.maintenance_window.type
    day  = var.maintenance_window.day
    hour = var.maintenance_window.hour
  }

  backup_window_start {
    hours   = var.backup_window_start.hours
    minutes = var.backup_window_start.minutes
  }

  performance_diagnostics {
    enabled                      = var.performance_diagnostics.enabled
    sessions_sampling_interval   = var.performance_diagnostics.sessions_sampling_interval
    statements_sampling_interval = var.performance_diagnostics.statements_sampling_interval
  }

  labels = {
    for k, v in local.labels : k => v
  }
}
