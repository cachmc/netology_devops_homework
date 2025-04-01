output "network" {
  value = module.create_network
}

output "nat_instance" {
  value = yandex_compute_instance.create_nat_instance
}
