module "k8s_master_nodes" {
  source         = "./yandex_compute_instance"
  env_name       = "develop" 
  network_id     = data.terraform_remote_state.network.outputs.vpc_dev.network_id
  subnet_zones   = var.subnet_zones
  subnet_ids     = data.terraform_remote_state.network.outputs.vpc_dev.subnet_ids
  security_group_ids = [data.terraform_remote_state.network.outputs.default_sg.id ]
  instance_name  = "k8s-master-node"
  instance_count = 3
  image_family   = "ubuntu-2204-lts"
  public_ip      = true

  platform               = "standard-v3"
  instance_cores         = 2
  instance_memory        = 2
  instance_core_fraction = 20

  labels = {
    owner   = "v.shishkov"
    project = "k8s-cluster"
  }

  metadata = {
    serial-port-enable = 1
    user-data          = data.template_file.cloudinit.rendered
  }

  providers = {
    yandex = yandex
  }
}

module "k8s_worker_nodes" {
  source         = "./yandex_compute_instance"
  env_name       = "develop"
  network_id     = data.terraform_remote_state.network.outputs.vpc_dev.network_id
  subnet_zones   = var.subnet_zones
  subnet_ids     = data.terraform_remote_state.network.outputs.vpc_dev.subnet_ids
  security_group_ids = [data.terraform_remote_state.network.outputs.default_sg.id ]
  instance_name  = "k8s-worker-node"
  instance_count = 5
  image_family   = "ubuntu-2204-lts"
  public_ip      = true

  platform               = "standard-v3"
  instance_cores         = 2
  instance_memory        = 2
  instance_core_fraction = 20

  labels = {
    owner   = "v.shishkov"
    project = "k8s-cluster"
  }

  metadata = {
    serial-port-enable = 1
    user-data          = data.template_file.cloudinit.rendered
  }

  providers = {
    yandex = yandex
  }
}

module "k8s_keepalived" {
  source         = "./yandex_compute_instance"
  env_name       = "develop"
  network_id     = data.terraform_remote_state.network.outputs.vpc_dev.network_id
  subnet_zones   = var.subnet_zones
  subnet_ids     = data.terraform_remote_state.network.outputs.vpc_dev.subnet_ids
  security_group_ids = [data.terraform_remote_state.network.outputs.default_sg.id ]
  instance_name  = "k8s-keepalived"
  instance_count = 1
  image_family   = "ubuntu-2204-lts"
  public_ip      = true

  platform               = "standard-v3"
  instance_cores         = 2
  instance_memory        = 2
  instance_core_fraction = 20

  labels = {
    owner   = "v.shishkov"
    project = "k8s-cluster"
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
    ssh_key  = var.ssh_key
  }
}
