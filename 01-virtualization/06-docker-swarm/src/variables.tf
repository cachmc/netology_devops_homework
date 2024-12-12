### vars cloud

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



### vars ansible

variable "ansible_vault_pass" {
  type        = string
  description = "Password for Vault Ansible"
}


### vars network

variable "vpc_name" {
  type        = string
  default     = "netology-network"
  description = "VPC network & subnet name"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "default_cidr" {
  type        = list(string)
  default     = ["10.10.30.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}



### vars instance

variable "ssh_user" {
  type    = string
  default = "vmshishkov"
}

variable "ssh_key_path" {
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
}

variable "ubuntu_version" {
  type        = string
  default     = "2004"
  description = "Version OS Ubuntu"
}

variable "configuration_vm" {
  type = object({
    name               = string
    platform_id        = string
    zone               = string
    cores              = number
    memory             = number
    core_fraction      = number
    disk_volume        = number
    preemptible        = bool
    nat                = bool
    serial_port_enable = number
  })
  default = {
    name               = "docker-swarm"
    platform_id        = "standard-v3"
    zone               = "ru-central1-a"       
    cores              = 2
    memory             = 2
    core_fraction      = 20
    disk_volume        = 20
    preemptible        = true
    nat                = true
    serial_port_enable = 0
  }
  description = "Configuration VM"
}
