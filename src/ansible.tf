variable "check_provision" {
  type    = bool
  default = true
  description="ansible provision switch variable"
}

resource "local_file" "hosts_templatefile" {
  content = templatefile("${path.module}/hosts.tftpl", {
    vm_web = yandex_compute_instance.create_vm_web
    vm_db = yandex_compute_instance.create_vm_db
    vm_storage = [ yandex_compute_instance.create_vm_storage ]
  })

  filename = "${abspath(path.module)}/hosts.ini"
}

resource "null_resource" "hosts_provision" {
  count = var.check_provision == true ? 1 : 0 

  depends_on = [yandex_compute_instance.create_vm_web,yandex_compute_instance.create_vm_web,yandex_compute_instance.create_vm_storage]

  provisioner "local-exec" {
    command     = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ${abspath(path.module)}/hosts.ini ${abspath(path.module)}/test.yaml"    
    on_failure  = continue
  }
  triggers = {
    always_run        = "${timestamp()}"
    always_run_uuid   = "${uuid()}" 
  }
}
