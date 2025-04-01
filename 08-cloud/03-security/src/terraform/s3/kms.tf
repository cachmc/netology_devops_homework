data "terraform_remote_state" "kms" {
  backend = "s3"
  config = {
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
}
