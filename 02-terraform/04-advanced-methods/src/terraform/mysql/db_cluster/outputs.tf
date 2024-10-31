output "cluster_id" {
  value = yandex_mdb_mysql_cluster.create_cluster.id
  description = "ID of the cluster MySQL"
}
