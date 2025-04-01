data "yandex_client_config" "client" {}

locals {
  folder_id = data.yandex_client_config.client.folder_id
}
resource "yandex_iam_service_account" "create_service_account" {
  name = var.ig_configuration.service_account_name
}

resource "yandex_iam_service_account_static_access_key" "create_key" {
  service_account_id = yandex_iam_service_account.create_service_account.id
  description        = "Static access key for editing Instance Groups service account."
}

resource "yandex_resourcemanager_folder_iam_member" "admin" {
  role       = "admin"
  member     = "serviceAccount:${yandex_iam_service_account.create_service_account.id}"
  folder_id  = local.folder_id
  depends_on = [yandex_iam_service_account_static_access_key.create_key]
}
