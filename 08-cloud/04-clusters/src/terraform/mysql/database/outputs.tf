output "mysql_db" {
  value = yandex_mdb_mysql_database.create_db
  description = "Information about created MySQL DB"
}

output "mysql_db_user" {
  value = yandex_mdb_mysql_user.create_db_user
  description = "Information about created MySQL DB User"
}

output "mysql_db_password" {
  value = random_password.create_db_password
  description = "Information about created MySQL DB Password"
}
