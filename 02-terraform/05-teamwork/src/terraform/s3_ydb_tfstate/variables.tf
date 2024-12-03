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

variable "s3_bucket_service_account" {
  type        = string
  default     = "svm-tfstate-test"
  description = "S3 bucket service account"
}

variable "s3_bucket_name" {
  type        = string
  default     = "svm-tfstate-test"
  description = "S3 bucket name"
}

variable "yandex_db" {
  type = object({
    name                        = string
    deletion_protection         = bool
    enable_throttling_rcu_limit = bool
    provisioned_rcu_limit       = number
    storage_size_limit          = number
    throttling_rcu_limit        = number
  })
  default = {
    name                        = "svm-tfstate-test"
    deletion_protection         = false
    enable_throttling_rcu_limit = false 
    provisioned_rcu_limit       = 0
    storage_size_limit          = 50
    throttling_rcu_limit        = 10
  }
  description = "Configuration for Yandex DB"
}
