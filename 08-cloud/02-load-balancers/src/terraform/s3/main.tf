module "s3" {
  source = "git::https://github.com/terraform-yc-modules/terraform-yc-s3.git?ref=791f53698dd13ee97bc1cbe51b765f2d10f1d273"

  bucket_name = var.s3_bucket_name

  existing_service_account = {
    id         = yandex_iam_service_account.storage_admin.id
    access_key = yandex_iam_service_account_static_access_key.storage_admin.access_key
    secret_key = yandex_iam_service_account_static_access_key.storage_admin.secret_key
  }

  max_size = 1073741824

  anonymous_access_flags = {
    read = true
  }

  versioning = {
    enabled = true
  }
}
