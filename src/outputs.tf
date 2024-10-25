output "dynamic_vms" {
  value = [ for vm in setunion(yandex_compute_instance.create_vm_web, [ for vm_db in yandex_compute_instance.create_vm_db: vm_db ]): {
    name = vm.name
    id   = vm.id
    fqdn = vm.fqdn 
  }]

  description = "Information about all dynamic servers"
}
