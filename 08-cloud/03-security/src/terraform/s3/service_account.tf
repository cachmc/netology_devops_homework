data "yandex_client_config" "client" {}

locals {
  folder_id = data.yandex_client_config.client.folder_id
}
resource "yandex_iam_service_account" "storage_admin" {
  name = var.s3_configuration.service_account.name
}

resource "yandex_iam_service_account_static_access_key" "storage_admin" {
  service_account_id = yandex_iam_service_account.storage_admin.id
  description        = "Static access key for Object storage admin service account."
}

resource "yandex_resourcemanager_folder_iam_member" "storage_admin" {
  role       = "storage.admin"
  member     = "serviceAccount:${yandex_iam_service_account.storage_admin.id}"
  folder_id  = local.folder_id
  depends_on = [yandex_iam_service_account_static_access_key.storage_admin]
}

resource "yandex_resourcemanager_folder_iam_member" "kms_keys_encrypterDecrypter" {
  count = var.s3_configuration.bucket.server_side_encryption_configuration.enabled == true ? 1 : 0
  
  role       = "kms.keys.encrypterDecrypter"
  member     = "serviceAccount:${yandex_iam_service_account.storage_admin.id}"
  folder_id  = local.folder_id
  depends_on = [yandex_iam_service_account_static_access_key.storage_admin]
}
