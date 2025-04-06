output "cluster" {
  value = yandex_kubernetes_cluster.create_cluster
  description = "Information about cluster"
}

output "node_groups" {
  value = yandex_kubernetes_node_group.create_node_groups
  description = "Information about node groups"
}
