#Create VMs Web

resource "yandex_compute_instance" "create_vm_web" {
  depends_on = [yandex_compute_instance.create_vm_db]

  count = 2

  name        = "${var.configuration_vm_web.name}-${count.index+1}"
  hostname    = "${var.configuration_vm_web.name}-${count.index+1}"
  platform_id = var.configuration_vm_web.platform_id
  zone        = var.configuration_vm_web.zone
  resources {
    cores         = var.configuration_vm_web.cores
    memory        = var.configuration_vm_web.memory
    core_fraction = var.configuration_vm_web.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.image_ubuntu.image_id
      size     = var.configuration_vm_web.disk_volume
    }
  }
  scheduling_policy {
    preemptible = var.configuration_vm_web.preemptible
  }
  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = var.configuration_vm_web.nat
    security_group_ids = [yandex_vpc_security_group.example.id]
  }
  metadata = {
    serial-port-enable = var.configuration_vm_web.serial_port_enable
    ssh-keys           = "ubuntu:${local.ssh-keys}"
  }
}
