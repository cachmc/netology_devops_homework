data "yandex_compute_image" "nat_get_image" {
  family = var.nat_instance.disk_image_family_id
}

resource "yandex_compute_instance" "create_nat_instance" {
  name                      = var.nat_instance.name
  platform_id               = var.nat_instance.platform_id
  hostname                  = var.nat_instance.name
  zone                      = var.nat_instance.zone
  allow_stopping_for_update = true

  scheduling_policy {
    preemptible = var.nat_instance.preemptible
  }
  
  resources {
    cores         = var.nat_instance.cores
    memory        = var.nat_instance.memory
    core_fraction = var.nat_instance.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.nat_get_image.image_id
      type     = var.nat_instance.disk_type
      size     = var.nat_instance.disk_volume
    }
  }

  network_interface {
    subnet_id  = { for subnet in module.create_network.subnets : "result" => subnet.id if length(regexall(".*public.*", subnet.name)) > 0 }.result
    ip_address = var.nat_instance.network_private_ip
    nat        = var.nat_instance.network_nat
  }

  metadata = {
    serial-port-enable = var.nat_instance.serial_port_enable
    ssh-keys           = "ubuntu:${var.ssh_key}"
  }
}
