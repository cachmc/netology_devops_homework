resource "yandex_vpc_network" "create_network" {
  name = var.network_name
}

resource "yandex_vpc_route_table" "create_route_table" {
  count = var.route_table_name == "" ? 0 : 1 

  name       = var.route_table_name
  network_id = yandex_vpc_network.create_network.id

  dynamic "static_route" {
    for_each = var.static_routes

    content {
      destination_prefix = lookup(static_route.value, "destination_prefix", null)
      next_hop_address   = lookup(static_route.value, "next_hop_address", null)
    }
  }
}

resource "yandex_vpc_subnet" "create_subnet" {
  for_each = { for i, subnet in var.subnets: i => subnet }

  name           = "${var.network_name}-${each.value.name}-${each.value.zone}"
  zone           = each.value.zone
  network_id     = yandex_vpc_network.create_network.id
  v4_cidr_blocks = [each.value.cidr]
  route_table_id = each.value.link_route_table ? (length(yandex_vpc_route_table.create_route_table) > 0 ? yandex_vpc_route_table.create_route_table.0.id : "") : ""
}
