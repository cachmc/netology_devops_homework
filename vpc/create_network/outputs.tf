output "network_id" {
  value = yandex_vpc_network.create_network.id
  description = "ID of the created network"
}

output "subnet_ids" {
  value = [ for subnet in yandex_vpc_subnet.create_subnet : subnet.id ]
  description = "IDs of the created subnets"
}
