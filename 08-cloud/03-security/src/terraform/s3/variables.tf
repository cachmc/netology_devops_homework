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

### S3 ###

variable "s3_configuration" {
  type = object({
    bucket          = object({
        name                                 = string
        max_size                             = number
        anonymous_access_flags               = object({
          read = bool
        })
        versioning                           = object({
          enabled = bool
        })
        server_side_encryption_configuration = object({
          enabled = bool
          key     = object({
            name = string
          })
        })
    })
    service_account = object({
      name = string
    })
    upload_files    = list(object({
      name = string
      file = string
    }))
  })
  default = {
    bucket          = {
        name                                 = "vmshishkov-01042025"
        max_size                             = 1073741824
        anonymous_access_flags               = {
          read = true
        }
        versioning                           = {
          enabled = true
        }
        server_side_encryption_configuration = {
          enabled = true
          key     = {
            name = "netology-kms-key"
          }
        }
    }
    service_account = {
      name = "vmshishkov-01042025"
    }
    upload_files    = [
      {
        name = "picture_1.jpg"
        file = "./files/picture_1.jpg"
      },
      {
        name = "picture_2.jpg"
        file = "./files/picture_2.jpg"
      }
    ]
  }
  description = "S3 bucket configuration"
}
