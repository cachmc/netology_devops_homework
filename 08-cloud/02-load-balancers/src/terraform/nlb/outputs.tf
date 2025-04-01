output "network_load_balancers" {
  value = [
    for l in yandex_lb_network_load_balancer.netology-nlb.listener: {
      "name": l.name,
      "ip_addresses": [ for a in l.external_address_spec: a.address ]
    }
  ]
}
