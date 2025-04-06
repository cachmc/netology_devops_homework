module "create_cluster" {
  source = "./cluster"
  
  name                = var.cluster_configuration.name
  environment         = var.cluster_configuration.environment
  mssql_version       = var.cluster_configuration.mssql_version
  deletion_protection = var.cluster_configuration.deletion_protection

  count_nodes = var.cluster_configuration.count_nodes

  network = {
    id     = data.terraform_remote_state.vpc.outputs.network.network_id
    subnet = {
      ids   = [ for subnet in data.terraform_remote_state.vpc.outputs.network.subnets : subnet.id if length(regexall(".*${var.cluster_configuration.subnet_name}.*", subnet.name)) > 0 ]
      zones = [ for subnet in data.terraform_remote_state.vpc.outputs.network.subnets : subnet.zone if length(regexall(".*${var.cluster_configuration.subnet_name}.*", subnet.name)) > 0 ]
    }
  }

  resources = {
    resource_preset_id = var.cluster_configuration.resources.resource_preset_id
    disk_type_id       = var.cluster_configuration.resources.disk_type_id
    disk_size          = var.cluster_configuration.resources.disk_size
  }

  maintenance_window = {
    type = var.cluster_configuration.maintenance_window.type
    day  = var.cluster_configuration.maintenance_window.day
    hour = var.cluster_configuration.maintenance_window.hour
  }

  backup_window_start = {
    hours   = var.cluster_configuration.backup_window_start.hours
    minutes = var.cluster_configuration.backup_window_start.minutes
  }

  providers = {
    yandex = yandex
  }
}

module "create_db" {
  source = "./database"

  depends_on = [ module.create_cluster ]

  cluster_id  = module.create_cluster.cluster.id
  name     = var.db_configuration.name
  username = var.db_configuration.username
  roles    = var.db_configuration.roles

  providers = {
    yandex = yandex
  }
}
