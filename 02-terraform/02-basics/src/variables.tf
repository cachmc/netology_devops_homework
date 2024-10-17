###cloud vars


variable "cloud_id" {
  type        = string
  default     = "b1gckqal9th70votrnub"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  default     = "b1gfoipitiot0c1fe5ln"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}


###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL3oLskaY3H39j5ZSdodVRfmvBntSaVyiieWnKOyNnRh"
  description = "ssh-keygen -t ed25519"
}
