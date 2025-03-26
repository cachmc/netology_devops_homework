output "vms" {
  value = [ for vm in yandex_compute_instance.create_vm: {
    name = vm.name
    ip_interanel = vm.network_interface.0.ip_address 
    ip_external = vm.network_interface.0.nat_ip_address != "" ? vm.network_interface.0.nat_ip_address : "NONE"
  }]
  description = "Information about all compute instances"
}
