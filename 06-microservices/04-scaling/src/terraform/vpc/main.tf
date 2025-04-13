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
  subnets = var.subnets

  providers = {
    yandex = yandex
  }
}
