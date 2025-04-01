resource "yandex_alb_target_group" "create_target_group" {
  name = var.alb_configuration.target_group.name

  dynamic "target" {
    for_each = data.terraform_remote_state.instance_group.outputs.instance_group

    content {
      subnet_id  = target.value["interfaces"].0.subnet_id
      ip_address = target.value["interfaces"].0.ip_address
    }
  }
}

resource "yandex_alb_backend_group" "create_backend_group" {
  name = var.alb_configuration.backend_group.name

  http_backend {
    name                   = var.alb_configuration.backend_group.http_backend.name
    weight                 = var.alb_configuration.backend_group.http_backend.weight
    port                   = var.alb_configuration.backend_group.http_backend.port
    target_group_ids       = [ yandex_alb_target_group.create_target_group.id ]
    
    healthcheck {
      timeout              = var.alb_configuration.backend_group.http_backend.healthcheck.timeout
      interval             = var.alb_configuration.backend_group.http_backend.healthcheck.interval
      healthy_threshold    = var.alb_configuration.backend_group.http_backend.healthcheck.healthy_threshold
      unhealthy_threshold  = var.alb_configuration.backend_group.http_backend.healthcheck.unhealthy_threshold
      healthcheck_port     = var.alb_configuration.backend_group.http_backend.healthcheck.healthcheck_port
      http_healthcheck {
        path              = var.alb_configuration.backend_group.http_backend.healthcheck.http_healthcheck.path
        expected_statuses = var.alb_configuration.backend_group.http_backend.healthcheck.http_healthcheck.expected_statuses
      }
    }

    load_balancing_config {
      mode = var.alb_configuration.backend_group.http_backend.load_balancing_config.mode
    }
  }
}

resource "yandex_alb_http_router" "create_http_router" {
  name = var.alb_configuration.http_router.name
}

resource "yandex_alb_virtual_host" "create_virtual_host" {
  name           = var.alb_configuration.virtual_host.name
  http_router_id = yandex_alb_http_router.create_http_router.id

  route {
    name = var.alb_configuration.virtual_host.route.name
    http_route {
      http_route_action {
        backend_group_id = yandex_alb_backend_group.create_backend_group.id
      }
    }
  }
}

resource "yandex_alb_load_balancer" "create_alb" {
  name = var.alb_configuration.alb.name

  network_id = data.terraform_remote_state.vpc.outputs.network.network_id

  allocation_policy {
    location {
      zone_id   = var.default_zone
      subnet_id = { for subnet in data.terraform_remote_state.vpc.outputs.network.subnets : "result" => subnet.id if length(regexall(".*${var.alb_configuration.alb.allocation_policy.location.subnet}.*", subnet.name)) > 0 }.result
    }
  }

  listener {
    name = var.alb_configuration.alb.listener.name
    endpoint {
      address {
        external_ipv4_address {
        }
      }
      ports = var.alb_configuration.alb.listener.endpoint.ports
    }
    http {
      handler {
        http_router_id = yandex_alb_http_router.create_http_router.id
      }
    }
  }
}
