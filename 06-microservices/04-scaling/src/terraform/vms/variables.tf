### General

variable "ssh_key" {
  type        = string
  description = "SSH public key"
}

variable "image_family_id" {
  type        = string
  default     = "ubuntu-2204-lts-oslogin"
  description = "Image OS"
}

### cloud vars

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

### VMS

variable "vm" {
  type = object({
    name                 = string
    platform_id          = string
    zones                = list(string)
    cores                = number
    memory               = number
    core_fraction        = number
    disk_type            = string
    disk_volume          = number
    preemptible          = bool
    network_subnet_name  = string
    network_nat          = bool
    serial_port_enable   = number
  })
  default = {
    name                 = "redis-node"
    platform_id          = "standard-v2"
    zones                = ["ru-central1-a","ru-central1-b","ru-central1-d"]
    cores                = 2
    memory               = 1
    core_fraction        = 5
    disk_type            = "network-hdd"
    disk_volume          = 10
    preemptible          = true
    network_subnet_name  = "public"
    network_nat          = true
    serial_port_enable   = 0
  }
  description = "Configuration VM"
}

### Ansible ###

variable "starting_playbook" {
  type    = bool
  description="Starting playbook?"
}

variable "path_inventory" {
  type    = string
  default = "../../ansible/inventory/hosts.yaml"
  description="Path inventory"
}

variable "path_playbook" {
  type    = string
  default = "../../ansible/create_redis_cluster.yaml"
  description="Path playbook"
}
