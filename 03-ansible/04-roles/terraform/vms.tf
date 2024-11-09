data "yandex_compute_image" "image_ubuntu" {
  family = "ubuntu-${var.ubuntu_version}-lts"
}

data "yandex_compute_image" "image_centos" {
  family = "centos-stream-${var.centos_version}-oslogin"
}


data "template_file" "cloudinit" {
  template = file("${path.module}/cloud-init.yaml")

  vars = {
    ssh_user = var.ssh_user
    ssh_key  = file(var.ssh_key_path)
  }
}


resource "yandex_compute_instance" "create_vms" {
  for_each = { for vm_db in var.configuration_vms: vm_db.name => vm_db }

  name        = each.value.name
  hostname    = each.value.name
  platform_id = each.value.platform_id
  zone        = each.value.zone
  resources {
    cores         = each.value.cores
    memory        = each.value.memory
    core_fraction = each.value.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.image_centos.image_id
      size     = each.value.disk_volume
    }
  }
  scheduling_policy {
    preemptible = each.value.preemptible
  }
  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = each.value.nat
  }
  metadata = {
    serial-port-enable = each.value.serial_port_enable
    user-data          = data.template_file.cloudinit.rendered
  }
}
