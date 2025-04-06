###cloud vars

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

variable "subnet_zones" {
  type        = list(string)
  default     = ["ru-central1-a", "ru-central1-b"]
  description = "List of subnet zones"
}

### MySQL ###

variable "cluster_configuration" {
  type = object({
    name                = string
    environment         = string
    mssql_version       = string
    deletion_protection = bool
    count_nodes         = list(number)
    subnet_name         = string
    resources           = object({
      resource_preset_id = string
      disk_type_id       = string
      disk_size          = number
    })
    maintenance_window  = object({
      type = string
      day  = string
      hour = number
    })
    backup_window_start = object({
      hours   = number
      minutes = number
    })
  })
  default = {
    name                = "netology-mysql-cluster"
    environment         = "PRESTABLE"
    mssql_version       = "8.0"
    deletion_protection = true
    count_nodes         = [1,2]
    subnet_name         = "private"
    resources           = {
      resource_preset_id = "b1.medium"
      disk_type_id       = "network-hdd"
      disk_size          = 20
    }
    maintenance_window  = {
      type = "ANYTIME"
      day  = ""
      hour = 0
    }
    backup_window_start = {
      hours   = 23
      minutes = 59
    }
  }
  description = "Configuration cluster"
}

variable "db_configuration" {
  type = object({
    name     = string
    username = string
    roles    = list(string)
  })
  default = {
    name     = "netology_db"
    username = "netology"
    roles    = ["ALL"]
  }
  description = "Configuration DB"
}

