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

variable "document_api_endpoint" {
  type        = string
  description = "https://ydb.tech/docs/en/concepts/connect"
}

variable "yandex_db_table" {
  type = object({
    name      = string
    hash_key  = string
    attribute = list(object({
      name = string
      type = string
    }))
  })
  default = {
    name      = "tfstate_lock_develope"
    hash_key  = "LockID"
    attribute = [
      {
        name = "LockID"
        type = "S"
      }
    ]
  }
  description = "Configuration table for Yandex DB"
}
