resource "random_password" "create_db_password" {
  length = 16
}

resource "yandex_mdb_mysql_user" "create_db_user" {
  cluster_id = var.cluster_id
  name       = var.username
  password   = random_password.create_db_password.result

  permission {
    database_name = yandex_mdb_mysql_database.create_db.name
    roles         = var.roles
  }

  connection_limits {
    max_questions_per_hour   = var.connection_limits.max_questions_per_hour
    max_updates_per_hour     = var.connection_limits.max_updates_per_hour
    max_connections_per_hour = var.connection_limits.max_connections_per_hour
    max_user_connections     = var.connection_limits.max_user_connections
  }

  global_permissions = var.global_permissions

  authentication_plugin = var.authentication_plugin
}