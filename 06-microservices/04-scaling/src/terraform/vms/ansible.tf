resource "local_file" "hosts_templatefile" {
  content = templatefile("${path.module}/hosts.tftpl", {
    vms = yandex_compute_instance.create_vms
  })

  filename = "${abspath(path.module)}/${var.path_inventory}"
  file_permission = "0644"
}

resource "null_resource" "run_playbooks" {
  count = var.starting_playbook == true ? 1 : 0 

  depends_on = [
    yandex_compute_instance.create_vms,
    local_file.hosts_templatefile
  ]

  provisioner "local-exec" {
    command     = "ANSIBLE_HOST_KEY_CHECKING=False ANSIBLE_PYTHON_INTERPRETER=auto_legacy_silent ansible-playbook -i ${abspath(path.module)}/${var.path_inventory} ${abspath(path.module)}/${var.path_playbook}"
    on_failure  = continue
  }

  triggers = {
    always_run        = "${timestamp()}"
    always_run_uuid   = "${uuid()}" 
  }
}
