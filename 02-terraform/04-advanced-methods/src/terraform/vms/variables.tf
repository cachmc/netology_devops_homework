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
  default     = ["ru-central1-a", "ru-central1-b", "ru-central1-d"]
  description = "List of subnet zones"
}



###instance vars

variable "ssh_user" {
  type    = string
  default = "vmshishkov"
}

variable "ssh_key_path" {
  type    = string
  default = "~/.ssh/id_ed25519.pub"
}
