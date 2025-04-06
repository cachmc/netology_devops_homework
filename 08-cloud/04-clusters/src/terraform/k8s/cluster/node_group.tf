resource "yandex_kubernetes_node_group" "create_node_groups" {
  depends_on = [
    yandex_kubernetes_cluster.create_cluster
  ]
  
  for_each = { for i, subnet in var.network.subnets : i => { "index": i, "subnet": subnet } }

  name        = "${var.node_group_name}-${each.value.index+1}"
  description = var.node_group_description
  cluster_id  = yandex_kubernetes_cluster.create_cluster.id
  version     = yandex_kubernetes_cluster.create_cluster.master.0.version

  instance_template {
    name = "${var.instance_template.name}-{instance.short_id}-{instance_group.id}"
    platform_id = var.instance_template.platform_id
    
    resources {
      cores         = var.instance_template.resources.cores
      core_fraction = var.instance_template.resources.core_fraction
      memory        = var.instance_template.resources.memory
    }
    
    boot_disk {
      size = var.instance_template.boot_disk.size
      type = var.instance_template.boot_disk.type
    }

    network_acceleration_type = var.instance_template.network_acceleration_type
    network_interface {
      security_group_ids = [yandex_vpc_security_group.create_security_group.id]
      subnet_ids         = [each.value.subnet.id]
      nat                = var.instance_template.network_nat
    }
    
    scheduling_policy {
      preemptible = var.instance_template.preemptible
    }
  }

  scale_policy {
    auto_scale {
      min     = var.auto_scale_policy.min
      max     = var.auto_scale_policy.max
      initial = var.auto_scale_policy.initial
    }
  }

  allocation_policy {
    location {
        zone = each.value.subnet.zone
    }
  }
 
  deploy_policy {
    max_expansion   = var.deploy_policy.max_expansion
    max_unavailable = var.deploy_policy.max_unavailable
  }

  maintenance_policy {
    auto_upgrade = var.maintenance_policy.auto_upgrade
    auto_repair  = var.maintenance_policy.auto_repair
    maintenance_window {
      start_time = var.maintenance_policy.maintenance_window.start_time
      duration   = var.maintenance_policy.maintenance_window.duration
    }
  }

  node_labels = {
    for k, v in local.node_labels : k => v
  }

  node_taints = var.node_taints

  labels = {
    for k, v in local.labels : k => v
  }

  allowed_unsafe_sysctls = var.allowed_unsafe_sysctls
}
