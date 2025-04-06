module "create_cluster" {
  source = "./cluster"

  cluster_name         = var.k8s_cluster_configuration.cluster_name
  service_account_name = var.k8s_cluster_configuration.service_account_name

  count_master_nodes = [1,2,3]

  kms_key_id = { for key in data.terraform_remote_state.kms.outputs.keys: "result" => key.id if length(regexall(".*${var.k8s_cluster_configuration.kms_key_name}.*", key.name)) > 0 }.result

  network = {
    id = data.terraform_remote_state.vpc.outputs.network.network_id
    subnets = [ for subnet in data.terraform_remote_state.vpc.outputs.network.subnets : subnet if length(regexall(".*${var.k8s_cluster_configuration.subnet_name}.*", subnet.name)) > 0 ]
  }

  node_group_name = var.k8s_cluster_configuration.node_group_name

  providers = {
    yandex = yandex
  }
}
