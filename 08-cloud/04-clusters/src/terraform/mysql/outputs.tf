output "cluster" {
  value = {
    "id": module.create_cluster.cluster.id
    "nodes": [ for host in module.create_cluster.cluster.host: host.fqdn ]
  }
}

output "db" {
  value = {
    "name": module.create_db.mysql_db.name,
    "username": module.create_db.mysql_db_user.name
    "password": nonsensitive(module.create_db.mysql_db_password.result)
  }
}
