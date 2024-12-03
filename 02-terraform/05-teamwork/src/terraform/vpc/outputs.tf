output "vpc_dev" {
 value = module.vpc_dev
}

output "default_sg" {
 value = yandex_vpc_security_group.default_sg
}
