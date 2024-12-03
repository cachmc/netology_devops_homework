terraform {
  required_version = "~>1.8.4"

  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.133.0"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "> 5.1"
    }
  }
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
}

provider "aws" {
  endpoints {
    dynamodb = var.document_api_endpoint
  }
  profile                     = "default"
  region                      = "ru-central1"
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
  skip_region_validation      = true
}
