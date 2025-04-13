data "yandex_compute_image" "get_image" {
  family = var.image_family_id
}

resource "yandex_compute_instance" "create_vms" {
  count = 3
  
  name                      = "${var.vm.name}-${count.index+1}"
  hostname                  = "${var.vm.name}-${count.index+1}"
  platform_id               = var.vm.platform_id
  zone                      = element(var.vm.zones, count.index)
  allow_stopping_for_update = true

  scheduling_policy {
    preemptible = var.vm.preemptible
  }

  resources {
    cores         = var.vm.cores
    memory        = var.vm.memory
    core_fraction = var.vm.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.get_image.image_id
      type     = var.vm.disk_type
      size     = var.vm.disk_volume
    }
  }

  network_interface {
    subnet_id  = element([ for subnet in data.terraform_remote_state.vpc.outputs.network.subnets : subnet.id if length(regexall(".*${var.vm.network_subnet_name}.*", subnet.name)) > 0 ], count.index)
    nat        = var.vm.network_nat
  }

  metadata = {
    serial-port-enable = var.vm.serial_port_enable
    ssh-keys           = "ubuntu:${var.ssh_key}"
  }
}
