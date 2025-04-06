data "yandex_client_config" "client" {}

locals {
  folder_id = data.yandex_client_config.client.folder_id
}
resource "yandex_iam_service_account" "k8s_account" {
  name = var.service_account_name
}

resource "yandex_iam_service_account_static_access_key" "k8s_account" {
  service_account_id = yandex_iam_service_account.k8s_account.id
  description        = "Static access key for K8s service account."
}

resource "yandex_resourcemanager_folder_iam_member" "editor" {
  role       = "editor"
  member     = "serviceAccount:${yandex_iam_service_account.k8s_account.id}"
  folder_id  = local.folder_id
  depends_on = [yandex_iam_service_account_static_access_key.k8s_account]
}

resource "yandex_resourcemanager_folder_iam_member" "k8s_clusters_agent" {
  role       = "k8s.clusters.agent"
  member     = "serviceAccount:${yandex_iam_service_account.k8s_account.id}"
  folder_id  = local.folder_id
  depends_on = [yandex_iam_service_account_static_access_key.k8s_account]
}

resource "yandex_resourcemanager_folder_iam_member" "vpc_public_admin" {
  role       = "vpc.publicAdmin"
  member     = "serviceAccount:${yandex_iam_service_account.k8s_account.id}"
  folder_id  = local.folder_id
  depends_on = [yandex_iam_service_account_static_access_key.k8s_account]
}

resource "yandex_resourcemanager_folder_iam_member" "container-registry_images_puller" {
  role       = "container-registry.images.puller"
  member     = "serviceAccount:${yandex_iam_service_account.k8s_account.id}"
  folder_id  = local.folder_id
  depends_on = [yandex_iam_service_account_static_access_key.k8s_account]
}

resource "yandex_resourcemanager_folder_iam_member" "kms_keys_encrypter_decrypter" {
  role       = "kms.keys.encrypterDecrypter"
  member     = "serviceAccount:${yandex_iam_service_account.k8s_account.id}"
  folder_id  = local.folder_id
  depends_on = [yandex_iam_service_account_static_access_key.k8s_account]
}
