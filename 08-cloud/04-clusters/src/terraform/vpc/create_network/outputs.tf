output "network_id" {
  value = yandex_vpc_network.create_network.id
  description = "ID of the created network"
}

output "subnets" {
  value = [ 
    for subnet in yandex_vpc_subnet.create_subnet : {
      "name": subnet.name,
      "id": subnet.id,
      "zone": subnet.zone
      "cidrs": [ for cidr in subnet.v4_cidr_blocks: cidr ]
    }
  ]
  description = "IDs of the created subnets"
}
