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

### NLB

variable "nlb_configuration" {
  type = object({
    name                  = string
    service_account_name  = string
    listener              = object({
      name                  = string
      port                  = number
      external_address_spec = object({
        ip_version = string
      })
    })
    attached_target_group = object({
      healthcheck = object({
        name         = string
        http_options = object({
          port = number
          path = string
        })
      })
    })
  })
  default = {
    name                  = "netology-nlb"
    service_account_name  = "netology-nlb"
    listener              = {
      name                  = "netology-nlb-listner-01"
      port                  = 80
      external_address_spec = {
        ip_version = "ipv4"
      }
    }
    attached_target_group = {
      healthcheck = {
        name         = "http"
        http_options = {
          port = 80
          path = "/"
        }
      }
    }
  }
  description = "Configuration Network Load Balancer"
}
