locals {
  vm_name = "${var.vm_project}-${var.vm_env}-${var.vm_type}"

  metadata = {
    serial-port-enable = 1
    ssh-keys = "ubuntu:${var.vms_ssh_root_key}"
  }
}
