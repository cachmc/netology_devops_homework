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

### KMS ###

variable "kms_keys_configuration" {
  type = list(object({
    name              = string
    description       = string
    default_algorithm = string
    rotation_period   = string
  }))
  default = [
    {
      name              = "netology-kms-key"
      description       = "key for study"
      default_algorithm = "AES_128"
      rotation_period = "8760h"
    }
  ]
  description = "Configuration KMS key"
}
