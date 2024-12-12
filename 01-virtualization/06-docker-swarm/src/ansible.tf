resource "local_file" "hosts_templatefile" {
  content = templatefile("${path.module}/hosts.tftpl", {
    docker_swarm_managers = yandex_compute_instance.docker_swarm_managers
    docker_swarm_workers = yandex_compute_instance.docker_swarm_workers
  })

  filename = "${abspath(path.module)}/hosts.ini"
  file_permission = "0644"
}

resource "local_file" "file_ansible_vault_pass" {
  content = var.ansible_vault_pass

  filename = "${abspath(path.module)}/ansible_vault_pass"
  file_permission = "0644"
}

resource "null_resource" "run_playbooks" {
  depends_on = [yandex_compute_instance.docker_swarm_managers, yandex_compute_instance.docker_swarm_workers]

  provisioner "local-exec" {
    command     = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ${abspath(path.module)}/hosts.ini ${abspath(path.module)}/playbooks/create_docker_swarm_cluster.yaml"
    on_failure  = continue
  }

   provisioner "local-exec" {
    command     = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ${abspath(path.module)}/hosts.ini ${abspath(path.module)}/playbooks/run_web_application.yaml --vault-password-file ansible_vault_pass"
    on_failure  = continue
  }

  triggers = {
    always_run        = "${timestamp()}"
    always_run_uuid   = "${uuid()}" 
  }
}
