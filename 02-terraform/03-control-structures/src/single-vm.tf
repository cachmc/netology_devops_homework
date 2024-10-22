#Create VM Storage

resource "yandex_compute_instance" "create_vm_storage" {
  name        = var.configuration_vm_storage.name
  hostname    = var.configuration_vm_storage.name
  platform_id = var.configuration_vm_storage.platform_id
  zone        = var.configuration_vm_storage.zone

  resources {
    cores         = var.configuration_vm_storage.cores
    memory        = var.configuration_vm_storage.memory
    core_fraction = var.configuration_vm_storage.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.image_ubuntu.image_id
      size     = var.configuration_vm_storage.disk_volume
    }
  }

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.create_storage_disk
    content {
      disk_id = secondary_disk.value.id
    }
  }

  scheduling_policy {
    preemptible = var.configuration_vm_storage.preemptible
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = var.configuration_vm_storage.nat
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = {
    serial-port-enable = var.configuration_vm_storage.serial_port_enable
    ssh-keys           = "ubuntu:${local.ssh-keys}"
  }
}
