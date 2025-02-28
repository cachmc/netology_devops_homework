resource "local_file" "hosts_templatefile" {
  content = templatefile("${path.module}/inventory.tftpl", {
    masters = module.k8s_master_nodes.full_data
    workers = module.k8s_worker_nodes.full_data
    keepalived   = module.k8s_keepalived .full_data
  })

  filename = "${abspath(path.module)}/../../kubespray/inventory/netology/inventory.ini"
}
