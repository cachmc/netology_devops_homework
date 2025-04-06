output "cluster" {
  value = var.maintenance_window.type == "ANYTIME" ? yandex_mdb_mysql_cluster.create_cluster_maint_anytime.0 : yandex_mdb_mysql_cluster.create_cluster_maint_weekly.0
  description = "Information about of the cluster MySQL"
}
