terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = "~>1.8.4"
}



provider "yandex" {
  token                    = var.token
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.default_zone
}



variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  default     = "b1gckqal9th70votrnub"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  default     = "b1gfoipitiot0c1fe5ln"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.10.30.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "netology-network"
  description = "VPC network & subnet name"
}

variable "ssh_key" {
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL3oLskaY3H39j5ZSdodVRfmvBntSaVyiieWnKOyNnRh"
  description = "ssh-keygen -t ed25519"
}

variable "ssh_user" {
  type    = string
  default = "vmshishkov"
}



resource "yandex_vpc_network" "netology-network" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "netology-subnet" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.netology-network.id
  v4_cidr_blocks = var.default_cidr
}



data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2204-lts"
}
resource "yandex_compute_instance" "netology-docker" {
  name        = "netology-docker"
  platform_id = "standard-v3"
  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.netology-subnet.id
    nat       = true
  }
  metadata = {
    serial-port-enable = 0
    ssh-keys           = "${var.ssh_user}:${var.ssh_key}"
    user-data          = <<-EOT
                #cloud-config
                datasource:
                 Ec2:
                  strict_id: false

                ssh_pwauth: no

                groups:
                  - docker
                
                users:
                - name: ${var.ssh_user}
                  groups: docker
                  sudo: ALL=(ALL) NOPASSWD:ALL
                  shell: /bin/bash
                  ssh_authorized_keys:
                  - ${var.ssh_key}

                package_update: true
                package_upgrade: true
                
                packages:
                  - apt-transport-https
                  - ca-certificates
                  - curl
                  - gnupg
                  - lsb-release
                  - unattended-upgrades

                runcmd:
                  - mkdir -p /etc/apt/keyrings
                  - curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
                  - echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list /dev/null
                  - apt-get update
                  - apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
                  - systemctl enable docker
                  - systemctl start docker
                EOT
  }
}
