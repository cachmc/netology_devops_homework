locals {
  labels = length(keys(var.labels)) >0 ? var.labels: {
    "project"="undefined"
  }
}

resource "yandex_mdb_mysql_cluster" "create_cluster" {
  name        = var.cluster_name
  environment = "PRESTABLE"
  network_id  = var.network_id
  version     = "8.0"

  resources {
    resource_preset_id = "s2.micro"
    disk_type_id       = "network-ssd"
    disk_size          = 16
  }

  maintenance_window {
    type = "WEEKLY"
    day  = "SAT"
    hour = 12
  }

  dynamic "host" {
    for_each = var.ha_cluster == true ? [0,1] : [0]
    content {
      zone      = element(var.subnet_zones, host.key)
      subnet_id = element(var.subnet_ids, host.key)
    }
  }

  labels = {
    for k, v in local.labels : k => v
  }
}
