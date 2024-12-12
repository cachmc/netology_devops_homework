data "template_file" "cloudinit" {
  template = file("${path.module}/cloud-init.yaml")

  vars = {
    ssh_user = var.ssh_user
    ssh_key  = file(var.ssh_key_path)
  }
}


data "yandex_compute_image" "image_ubuntu" {
  family = "ubuntu-${var.ubuntu_version}-lts"
}


resource "yandex_compute_instance" "docker_swarm_managers" {
  count = 1

  name        = "${var.configuration_vm.name}-manager-${count.index+1}"
  hostname    = "${var.configuration_vm.name}-manager-${count.index+1}"
  platform_id = var.configuration_vm.platform_id
  zone        = var.configuration_vm.zone
  resources {
    cores         = var.configuration_vm.cores
    memory        = var.configuration_vm.memory
    core_fraction = var.configuration_vm.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.image_ubuntu.image_id
      size     = var.configuration_vm.disk_volume
    }
  }
  scheduling_policy {
    preemptible = var.configuration_vm.preemptible
  }
  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = var.configuration_vm.nat
  }
  metadata = {
    serial-port-enable = var.configuration_vm.serial_port_enable
    user-data          = data.template_file.cloudinit.rendered
  }
}

resource "yandex_compute_instance" "docker_swarm_workers" {
  count = 2

  name        = "${var.configuration_vm.name}-worker-${count.index+1}"
  hostname    = "${var.configuration_vm.name}-worker-${count.index+1}"
  platform_id = var.configuration_vm.platform_id
  zone        = var.configuration_vm.zone
  resources {
    cores         = var.configuration_vm.cores
    memory        = var.configuration_vm.memory
    core_fraction = var.configuration_vm.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.image_ubuntu.image_id
      size     = var.configuration_vm.disk_volume
    }
  }
  scheduling_policy {
    preemptible = var.configuration_vm.preemptible
  }
  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = var.configuration_vm.nat
  }
  metadata = {
    serial-port-enable = var.configuration_vm.serial_port_enable
    user-data          = data.template_file.cloudinit.rendered
  }
}
