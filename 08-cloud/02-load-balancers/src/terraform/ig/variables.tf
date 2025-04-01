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

variable "image_family_id" {
  type        = string
  default     = "lamp"
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

### IG

variable "ig_configuration" {
  type = object({
    name                 = string
    service_account_name = string
    scale_policy         = object({
      fixed_scale = object({
        size = number
      })
    })
    deploy_policy        = object({
      max_unavailable = number
      max_creating    = number
      max_expansion   = number
      max_deleting    = number
    })
    health_check         = object({
      interval            = number
      timeout             = number
      healthy_threshold   = number
      unhealthy_threshold = number
      tcp_options         = object({
        port = number
      })
      http_options        = object({
        port = number
        path = string
      })
    })
    load_balancer        = object({
      target_group_name = string
    })
  })
  default = {
    name                 = "netology-ig"
    service_account_name = "netology-ig"
    scale_policy         = {
      fixed_scale = {
        size = 3
      }
    }
    deploy_policy        = {
      max_unavailable = 2
      max_creating    = 2
      max_expansion   = 2
      max_deleting    = 2
    }
    health_check         = {
      interval            = 2
      timeout             = 1
      healthy_threshold   = 2
      unhealthy_threshold = 2
      tcp_options         = {
        port = 80
      }
      http_options        = {
        port = 80
        path = "/"
      }
    }
    load_balancer        = {
      target_group_name = "netology-target-group"
    }
  }
  description = "Configuration IGs"
}

### VMS

variable "instance_template" {
  type = object({
    platform_id          = string
    cores                = number
    memory               = number
    core_fraction        = number
    disk_type            = string
    disk_size            = number
    preemptible          = bool
    network_subnet_name  = string
    network_nat          = bool
    serial_port_enable   = number
  })
  default = {
    platform_id          = "standard-v1"
    cores                = 2
    memory               = 1
    core_fraction        = 5
    disk_type            = "network-hdd"
    disk_size            = 10
    preemptible          = true
    network_subnet_name  = "public"
    network_nat          = false
    serial_port_enable   = 0
  }
  description = "Configuration VMs"
}
