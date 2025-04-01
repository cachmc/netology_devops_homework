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

variable "s3_bucket_service_account" {
  type        = string
  default     = "vmshishkov-01042025"
  description = "S3 bucket service account"
}

variable "s3_bucket_name" {
  type        = string
  default     = "vmshishkov-01042025"
  description = "S3 bucket name"
}

variable "upload_files" {
  type = list(object({
    name = string
    file = string
  }))
  default = [
    {
      name = "picture_1.jpg"
      file = "./files/picture_1.jpg"
    },
    {
      name = "picture_2.jpg"
      file = "./files/picture_2.jpg"
    }
  ]
  description = "List file for uploading"
}
