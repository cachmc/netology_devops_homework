resource "random_password" "db_password" {
  length = 16
}

resource "yandex_mdb_mysql_database" "create_db" {
  cluster_id = var.cluster_id
  name       = var.db_name
}

resource "yandex_mdb_mysql_user" "create_db_user" {
  cluster_id = var.cluster_id
  name       = var.db_username
  password   = random_password.db_password.result

  permission {
    database_name = yandex_mdb_mysql_database.create_db.name
    roles         = ["ALL"]
  }

  connection_limits {
    max_questions_per_hour   = 10
    max_updates_per_hour     = 20
    max_connections_per_hour = 30
    max_user_connections     = 40
  }

  global_permissions = ["PROCESS"]

  authentication_plugin = "SHA256_PASSWORD"
}
