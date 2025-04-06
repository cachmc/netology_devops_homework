locals {
  labels = length(keys(var.labels)) >0 ? var.labels: {
    "product"="mysql"
  }

  mysql_config = length(keys(var.mysql_config)) >0 ? var.mysql_config: {
    "binlog_transaction_dependency_tracking" = "0"
    "log_slow_rate_type"                     = "0"
    "sql_mode"                               = "ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION"
  }
}