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

variable "alb_configuration" {
  type = object({
    target_group  = object({
      name = string
    })
    backend_group = object({
      name         = string
      http_backend = object({
        name                  = string
        weight                = number
        port                  = number
        healthcheck           = object({
          timeout             = string
          interval            = string
          healthy_threshold   = number
          unhealthy_threshold = number
          healthcheck_port    = number
          http_healthcheck    = object({
            path              = string
            expected_statuses = list(string)
          })
        })
        load_balancing_config = object({
          mode = string
        })
      })
    })
    http_router   = object({
      name = string
    })
    virtual_host  = object({
      name = string
      route = object({
        name = string
      })
    })
    alb           = object({
      name              = string
      allocation_policy = object({
        location = object({
          subnet = string
        })
      })
      listener          = object({
        name     = string
        endpoint = object({
          ports = list(number)
        })
      })
    })
  })
  default = {
    target_group  = {
      name = "netology-alb-target-group"
    }
    backend_group = {
      name         = "netology-alb-backend-group"
      http_backend = {
        name                  = "netology-alb-backend-01"
        weight                = 1
        port                  = 80
        healthcheck           = {
          timeout             = "1s"
          interval            = "1s"
          healthy_threshold   = 1
          unhealthy_threshold = 1
          healthcheck_port    = 80
          http_healthcheck    = {
            path              = "/"
            expected_statuses = [
              "200"
            ]
          }
        }
        load_balancing_config = {
          mode = "ROUND_ROBIN"
        }
      }
    }
    http_router   = {
      name = "netology-alb-http-router"
    }
    virtual_host  = {
      name = "netology-alb-virtual-host-01"
      route = {
        name = "netology-alb-virtual-host-01-route-01"
      }
    }
    alb           = {
      name              = "netology-alb"
      allocation_policy = {
        location = {
          subnet = "public"
        }
      }
      listener          = {
        name     = "netology-alb-listner-01"
        endpoint = {
          ports = [
            80
          ]
        }
      }
    }
  }
  description = "Configuration Application Load Balancer"
}
