module "marketing_vm" {
  source         = "./yandex_compute_instance"
  env_name       = "develop" 
  network_id     = data.terraform_remote_state.network.outputs.vpc_dev.network_id
  subnet_zones   = var.subnet_zones
  subnet_ids     = data.terraform_remote_state.network.outputs.vpc_dev.subnet_ids
  instance_name  = "marketing-vm"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = true

  labels = {
    owner   = "v.shishkov"
    project = "marketing"
  }

  metadata = {
    serial-port-enable = 1
    user-data          = data.template_file.cloudinit.rendered
  }

  providers = {
    yandex = yandex
  }
}

module "analytics_vm" {
  source         = "./yandex_compute_instance"
  env_name       = "develop"
  network_id     = data.terraform_remote_state.network.outputs.vpc_dev.network_id
  subnet_zones   = var.subnet_zones
  subnet_ids     = data.terraform_remote_state.network.outputs.vpc_dev.subnet_ids
  instance_name  = "analytics-vm"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = true

  labels = {
    owner   = "v.shishkov"
    project = "analytics"
  }

  metadata = {
    serial-port-enable = 1
    user-data          = data.template_file.cloudinit.rendered
  }

  providers = {
    yandex = yandex
  }
}

data "template_file" "cloudinit" {
  template = file("${path.module}/cloud-init.yaml")

  vars = {
    ssh_user = var.ssh_user
    ssh_key  = file(var.ssh_key_path)
  }
}
