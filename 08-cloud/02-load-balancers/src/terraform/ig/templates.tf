resource "local_file" "cloud_init" {
  content = templatefile("${path.module}/cloud-init.tftpl", {
    ssh_user       = var.ssh_user
    ssh_key        = var.ssh_key
    urls_pub_files = data.terraform_remote_state.bucket.outputs.urls_pub_files
  })

  filename = "${abspath(path.module)}/cloud-init.yml"
}
