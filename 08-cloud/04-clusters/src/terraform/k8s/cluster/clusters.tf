resource "yandex_kubernetes_cluster" "create_cluster" {
  depends_on = [
    yandex_resourcemanager_folder_iam_member.k8s_clusters_agent,
    yandex_resourcemanager_folder_iam_member.vpc_public_admin,
    yandex_resourcemanager_folder_iam_member.container-registry_images_puller,
    yandex_resourcemanager_folder_iam_member.kms_keys_encrypter_decrypter,
    yandex_resourcemanager_folder_iam_member.editor
  ]

  name = var.cluster_name
  network_id = var.network.id
  
  master {
    version = var.k8s_version

    dynamic "master_location" {
        for_each = var.count_master_nodes

        content {
            subnet_id = element([ for subnet in var.network.subnets : subnet.id ], master_location.key)
            zone      = element([ for subnet in var.network.subnets : subnet.zone ], master_location.key)
        }
    }

    public_ip = var.cluster_public_ip
    security_group_ids = [yandex_vpc_security_group.create_security_group.id]
  }

  service_account_id      = yandex_iam_service_account.k8s_account.id
  node_service_account_id = yandex_iam_service_account.k8s_account.id


  kms_provider {
    key_id = var.kms_key_id
  }
}
