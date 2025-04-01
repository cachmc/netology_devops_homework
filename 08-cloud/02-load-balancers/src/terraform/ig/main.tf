data "yandex_compute_image" "get_image" {
  family = var.image_family_id
}

resource "yandex_compute_instance_group" "create_ig" {
  depends_on = [
    yandex_iam_service_account.create_service_account,
    yandex_iam_service_account_static_access_key.create_key,
    yandex_resourcemanager_folder_iam_member.admin
  ]

  name               = var.ig_configuration.name
  service_account_id = yandex_iam_service_account.create_service_account.id

  instance_template {
    platform_id = var.instance_template.platform_id
    resources {
      cores         = var.instance_template.cores
      memory        = var.instance_template.memory
      core_fraction = var.instance_template.core_fraction
    }

    boot_disk {
      initialize_params {
        image_id = data.yandex_compute_image.get_image.id
        type     = var.instance_template.disk_type
        size     = var.instance_template.disk_size
      }
    }

    scheduling_policy {
      preemptible = var.instance_template.preemptible
    }

    network_interface {
      network_id = data.terraform_remote_state.vpc.outputs.network.network_id
      subnet_ids = [ for subnet in data.terraform_remote_state.vpc.outputs.network.subnets : subnet.id if length(regexall(".*${var.instance_template.network_subnet_name}.*", subnet.name)) > 0 ]
      nat        = var.instance_template.network_nat
    }

    metadata = {
      serial-port-enable = var.instance_template.serial_port_enable
      user-data          = local_file.cloud_init.content
    }
  }

  scale_policy {
    fixed_scale {
      size = var.ig_configuration.scale_policy.fixed_scale.size
    }
  }

  allocation_policy {
    zones = [var.default_zone]
  }

  deploy_policy {
    max_unavailable = var.ig_configuration.deploy_policy.max_unavailable
    max_creating    = var.ig_configuration.deploy_policy.max_creating
    max_expansion   = var.ig_configuration.deploy_policy.max_expansion
    max_deleting    = var.ig_configuration.deploy_policy.max_deleting
  }

  health_check {
    interval = var.ig_configuration.health_check.interval
    timeout  = var.ig_configuration.health_check.timeout
    http_options {
      port = var.ig_configuration.health_check.http_options.port
      path = var.ig_configuration.health_check.http_options.path
    }
  }

  load_balancer {
    target_group_name = var.ig_configuration.load_balancer.target_group_name
  }
}
