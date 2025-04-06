output "cluster" {
  value = {
    "id": module.create_cluster.cluster.id
    "name": module.create_cluster.cluster.name
    "ip_address_external": module.create_cluster.cluster.master.0.external_v4_address
  }
}

output "node_groups" {
  value = [ for node_group in module.create_cluster.node_groups: {
      "id": node_group.id,
      "name": node_group.name
    } 
  ]
}
