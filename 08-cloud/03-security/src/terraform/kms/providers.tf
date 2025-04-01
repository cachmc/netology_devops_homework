terraform {
  required_version = "~>1.8.4"

  backend "s3" {
    shared_credentials_files = ["~/.aws/credentials"]
    region                   = "ru-central1"

    bucket = "svm-tfstate"
    key    = "clopro/kms/terraform.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true

    endpoints = {
      dynamodb = "https://docapi.serverless.yandexcloud.net/ru-central1/b1gckqal9th70votrnub/etnqbr8fk7pv2uo65cos"
      s3       = "https://storage.yandexcloud.net"
    }

    dynamodb_table = "tfstate_lock_develope"
  }

  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.139.0"
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
  region                      = "us-east-1"
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
  access_key                  = "mock_access_key"
  secret_key                  = "mock_secret_key"
}
