resource "yandex_lb_network_load_balancer" "netology-nlb" {
  name = var.nlb_configuration.name

  listener {
    name = var.nlb_configuration.listener.name
    port = var.nlb_configuration.listener.port
    external_address_spec {
      ip_version = var.nlb_configuration.listener.external_address_spec.ip_version
    }
  }

  attached_target_group {
    target_group_id = data.terraform_remote_state.instance_group.outputs.target_group.group_ids.0

    healthcheck {
      name = var.nlb_configuration.attached_target_group.healthcheck.name
      http_options {
        port = var.nlb_configuration.attached_target_group.healthcheck.http_options.port
        path = var.nlb_configuration.attached_target_group.healthcheck.http_options.path
      }
    }
  }
}
