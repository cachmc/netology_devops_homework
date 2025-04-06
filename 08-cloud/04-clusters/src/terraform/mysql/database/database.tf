resource "yandex_mdb_mysql_database" "create_db" {
  cluster_id = var.cluster_id
  name       = var.name
}
