output "platform_web" {
  value       = {
			instance_name = yandex_compute_instance.vm_web.name,
			external_ip   = yandex_compute_instance.vm_web.network_interface.0.nat_ip_address,
			fqdn          = yandex_compute_instance.vm_web.fqdn
		}

  description = "Information about WEB server"
}

output "platform_db" {
  value       = {
                        instance_name = yandex_compute_instance.vm_db.name,
                        external_ip   = yandex_compute_instance.vm_db.network_interface.0.nat_ip_address,
                        fqdn          = yandex_compute_instance.vm_db.fqdn
                }

  description = "Information about DB server"
}
