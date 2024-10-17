#Create Network
resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}


#Create Subnets
resource "yandex_vpc_subnet" "subnet_web" {
  name           = var.vm_web_subnet_name
  zone           = var.vm_web_network_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.vm_web_subnet_cidr
  route_table_id = yandex_vpc_route_table.nat_rt.id
}
resource "yandex_vpc_subnet" "subnet_db" {
  name           = var.vm_db_subnet_name
  zone           = var.vm_db_network_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.vm_db_subnet_cidr
  route_table_id = yandex_vpc_route_table.nat_rt.id
}
resource "yandex_vpc_subnet" "subnet_nat" {
  name           = var.nat_subnet_name
  v4_cidr_blocks = var.nat_subnet_cidr
  zone           = var.nat_network_zone
  network_id     = yandex_vpc_network.develop.id
  route_table_id = yandex_vpc_route_table.nat_rt.id
}


#Create NAT Gateway
resource "yandex_vpc_gateway" "nat_gateway" {
  name = "develope-gateway"
  shared_egress_gateway {}
}

resource "yandex_vpc_route_table" "nat_rt" {
  name       = "develope-route-table"
  network_id = yandex_vpc_network.develop.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat_gateway.id
  }
}


#Create VM Web
data "yandex_compute_image" "ubuntu_web" {
  family = "ubuntu-${var.vm_web_os_version}-lts"
}
resource "yandex_compute_instance" "vm_web" {
  name        = "${local.vm_name}-web"
  platform_id = var.vm_web_platform_id
  zone        = var.vm_web_network_zone
  resources {
    cores         = var.configuration.vms_resources.web.cores
    memory        = var.configuration.vms_resources.web.memory
    core_fraction = var.configuration.vms_resources.web.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_web.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vm_web_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.subnet_web.id
    nat       = var.vm_web_nat
  }
  metadata = {
    serial-port-enable = local.metadata.serial-port-enable
    ssh-keys           = local.metadata.ssh-keys
  }
}


#Create VM DB
data "yandex_compute_image" "ubuntu_db" {
  family = "ubuntu-${var.vm_db_os_version}-lts"
}
resource "yandex_compute_instance" "vm_db" {
  name        = "${local.vm_name}-db"
  platform_id = "${var.vm_db_platform_id}"
  zone        = var.vm_db_network_zone
  resources {
    cores         = var.configuration.vms_resources.db.cores
    memory        = var.configuration.vms_resources.db.memory
    core_fraction = var.configuration.vms_resources.db.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_db.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vm_db_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.subnet_db.id
    nat       = var.vm_db_nat
  }
  metadata = {
    serial-port-enable = local.metadata.serial-port-enable
    ssh-keys           = local.metadata.ssh-keys
  }
}
