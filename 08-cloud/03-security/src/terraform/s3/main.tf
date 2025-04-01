module "s3" {
  source = "git::https://github.com/terraform-yc-modules/terraform-yc-s3.git?ref=791f53698dd13ee97bc1cbe51b765f2d10f1d273"

  bucket_name = var.s3_configuration.bucket.name

  existing_service_account = {
    id         = yandex_iam_service_account.storage_admin.id
    access_key = yandex_iam_service_account_static_access_key.storage_admin.access_key
    secret_key = yandex_iam_service_account_static_access_key.storage_admin.secret_key
  }

  max_size = var.s3_configuration.bucket.max_size

  anonymous_access_flags = {
    read = var.s3_configuration.bucket.anonymous_access_flags.read
  }

  versioning = {
    enabled = var.s3_configuration.bucket.versioning.enabled
  }

  server_side_encryption_configuration = {
    enabled = var.s3_configuration.bucket.server_side_encryption_configuration.enabled
    kms_master_key_id = var.s3_configuration.bucket.server_side_encryption_configuration.enabled == true ? { for key in data.terraform_remote_state.kms.outputs.keys : "result" => key.id if length(regexall(".*${var.s3_configuration.bucket.server_side_encryption_configuration.key.name}.*", key.name)) > 0 }.result : ""
  } 
}
