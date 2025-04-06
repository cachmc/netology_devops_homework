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

### K8s Cluster ###

variable "k8s_cluster_configuration" {
  type = object({
    cluster_name         = string
    service_account_name = string
    subnet_name          = string
    node_group_name      = string
    kms_key_name         = string
  })
  default = {
    cluster_name         = "netology-k8s-cluster"
    service_account_name = "netology-k8s-sa"
    subnet_name          = "public"
    node_group_name      = "netology-ng"
    kms_key_name         = "netology-kms-key"
  }
  description = "Configuration K8s cluster"
}
