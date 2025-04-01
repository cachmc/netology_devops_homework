resource "yandex_storage_object" "upload_files" {
  depends_on = [
                 yandex_iam_service_account.storage_admin,
                 yandex_iam_service_account_static_access_key.storage_admin,
                 yandex_resourcemanager_folder_iam_member.storage_admin,
                 module.s3                                  
               ]

  for_each = { for i, file in var.s3_configuration.upload_files: i => file }

  access_key = yandex_iam_service_account_static_access_key.storage_admin.access_key
  secret_key = yandex_iam_service_account_static_access_key.storage_admin.secret_key
  bucket     = var.s3_configuration.bucket.name
  key        = each.value.name
  source     = each.value.file
}
