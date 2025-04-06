### General

variable "ssh_user" {
  type        = string
  default     = "ubuntu"
  description = "SSH user"
}

variable "ssh_key" {
  type        = string
  description = "SSH public key"
}

### Cloud vars

variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
} 

### VPC

variable "network_name" {
  type        = string
  default     = "netology"
  description = "Network name"
}

variable "subnets" {
  type        = list(object({
    name             = string
    zone             = string
    cidr             = string
    link_route_table = bool
  }))
  default     = [
    {
      name = "public",
      zone = "ru-central1-a",
      cidr = "192.168.10.0/24"
      link_route_table = false
    },
    {
      name = "public",
      zone = "ru-central1-b",
      cidr = "192.168.20.0/24"
      link_route_table = false
    },
    {
      name = "public",
      zone = "ru-central1-d",
      cidr = "192.168.30.0/24"
      link_route_table = false
    },
    {
      name = "private",
      zone = "ru-central1-a",
      cidr = "192.168.40.0/24"
      link_route_table = true
    },
    {
      name = "private",
      zone = "ru-central1-b",
      cidr = "192.168.50.0/24"
      link_route_table = true
    },
    {
      name = "private",
      zone = "ru-central1-d",
      cidr = "192.168.60.0/24"
      link_route_table = true
    }  
  ]
  description = "List subnets"
}

### NAT instance

variable "nat_instance" {
  type = object({
    check_create_nat_instance = bool
    name                      = string
    platform_id               = string
    zone                      = string
    cores                     = number
    memory                    = number
    core_fraction             = number
    disk_type                 = string
    disk_volume               = number
    disk_image_family_id      = string
    preemptible               = bool
    network_private_ip        = string
    network_nat               = bool
    serial_port_enable        = number
  })
  default = {
    check_create_nat_instance = false
    name                      = "nat-instance-01"
    platform_id               = "standard-v1"
    zone                      = "ru-central1-a"       
    cores                     = 2
    memory                    = 1
    core_fraction             = 5
    disk_type                 = "network-hdd"
    disk_volume               = 10
    disk_image_family_id      = "nat-instance-ubuntu"
    preemptible               = true
    network_private_ip        = "192.168.10.254"
    network_nat               = true
    serial_port_enable        = 0
  }
  description = "Configuration VM Web"
}
