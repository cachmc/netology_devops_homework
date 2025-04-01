module "create_network" {
  source   = "./create_network"
  network_name = var.network_name
  route_table_name = "egress_gateway"
  static_routes = [
    {
      destination_prefix = "0.0.0.0/0"
      next_hop_address   = var.nat_instance.network_private_ip
    }
  ]  
  subnets = [
    {
      name = "public",
      zone = var.default_zone,
      cidr = "192.168.10.0/24"
      link_route_table = false
    },
    {
      name = "private",
      zone = var.default_zone,
      cidr = "192.168.20.0/24"
      link_route_table = true
    }
  ]

  providers = {
    yandex = yandex
  }
}
