#Create VMs DB

resource "yandex_compute_instance" "create_vm_db" {
  for_each = { for vm_db in var.configuration_vm_db: vm_db.name => vm_db }

  name        = each.value.name
  hostname    = "db-${each.value.name}"
  platform_id = each.value.platform_id
  zone        = each.value.zone
  resources {
    cores         = each.value.cores
    memory        = each.value.memory
    core_fraction = each.value.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.image_ubuntu.image_id
      size     = each.value.disk_volume
    }
  }
  scheduling_policy {
    preemptible = each.value.preemptible
  }
  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = each.value.nat
    security_group_ids = [yandex_vpc_security_group.example.id]
  }
  metadata = {
    serial-port-enable = each.value.serial_port_enable
    ssh-keys           = "ubuntu:${local.ssh-keys}"
  }
}
