module "mysql_cluster" {
  source = "./db_cluster"
  
  ha_cluster   = true
  cluster_name = "example"

  network_id   = data.terraform_remote_state.network.outputs.vpc_dev.network_id
  subnet_zones = var.subnet_zones
  subnet_ids   = data.terraform_remote_state.network.outputs.vpc_dev.subnet_ids

  labels = {
    owner   = "v.shishkov"
    project = "db_cluster"
  }

  providers = {
    yandex = yandex
  }
}

module "mysql_database" {
  source = "./database"

  depends_on = [ module.mysql_cluster ]

  cluster_id  = module.mysql_cluster.cluster_id
  db_name     = "test"
  db_username = "app"

  providers = {
    yandex = yandex
  }
}
