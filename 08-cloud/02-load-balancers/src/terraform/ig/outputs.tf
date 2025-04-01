#output "instance_group" {
#  value = { instance_ids: [ for instance in yandex_compute_instance_group.create_ig.instances: instance.instance_id ] }
#}

output "instance_group" {
  value = [
    for instance in yandex_compute_instance_group.create_ig.instances: {
      "instance_id": instance.instance_id,
      "interfaces": [ 
        for interface in instance.network_interface: {
          "ip_address": interface.ip_address,
          "subnet_id": interface.subnet_id
        }
      ]
    }
  ]
}

output "target_group" {
  value = { group_ids: [ for lb in yandex_compute_instance_group.create_ig.load_balancer: lb.target_group_id ] }
}
