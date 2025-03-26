data "yandex_compute_image" "get_image" {
  family = var.image_family_id
}

resource "yandex_compute_instance" "create_vm" {
  for_each = { for i, vm in var.vms: i => vm }
  
  name                      = each.value.name
  platform_id               = each.value.platform_id
  hostname                  = each.value.name
  zone                      = each.value.zone
  allow_stopping_for_update = true

  scheduling_policy {
    preemptible = each.value.preemptible
  }

  resources {
    cores         = each.value.cores
    memory        = each.value.memory
    core_fraction = each.value.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.get_image.image_id
      type     = each.value.disk_type
      size     = each.value.disk_volume
    }
  }

  network_interface {
    subnet_id  = { for subnet in data.terraform_remote_state.network.outputs.network.subnets : "result" => subnet.id if length(regexall(".*${each.value.network_subnet_name}.*", subnet.name)) > 0 }.result
    nat        = each.value.network_nat
  }

  metadata = {
    serial-port-enable = each.value.serial_port_enable
    ssh-keys           = "ubuntu:${var.ssh_key}"
  }
}
