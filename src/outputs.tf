output "dynamic_vms" {
  value = [ for vm in local.list_vm_for_output: {
    name = vm.name
    id   = vm.id
    fqdn = vm.fqdn 
  }]

  description = "Information about all dynamic servers"
}
