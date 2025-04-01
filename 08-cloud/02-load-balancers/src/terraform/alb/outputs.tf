output "application_load_balancers" {
  value = [
    for l in yandex_alb_load_balancer.create_alb.listener: {
      "name": l.name,
      "ip_addresses": {
        for e in l.endpoint: "result" => {
          for ip in e.address: "result" => [
            for a in ip.external_ipv4_address: a.address
          ]
        }.result
      }.result
    }
  ]
}
