resource "yandex_ydb_database_serverless" "create_db" {
  name                = var.yandex_db.name
  deletion_protection = var.yandex_db.deletion_protection

  serverless_database {
    enable_throttling_rcu_limit = var.yandex_db.enable_throttling_rcu_limit
    provisioned_rcu_limit       = var.yandex_db.provisioned_rcu_limit
    storage_size_limit          = var.yandex_db.storage_size_limit
    throttling_rcu_limit        = var.yandex_db.throttling_rcu_limit
  }
}
