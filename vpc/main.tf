module "vpc_dev" {
  source       = "./create_network"
  env_name     = "develop-${var.prefix_name}"
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
    { zone = "ru-central1-b", cidr = "10.0.2.0/24" },
    { zone = "ru-central1-d", cidr = "10.0.3.0/24" },
  ]

  providers = {
    yandex = yandex
  }
}

resource yandex_vpc_security_group default_sg {
  name        = "default-sg-${var.prefix_name}"
  network_id  = module.vpc_dev.network_id

  ingress {
      protocol          = "ANY"
      description       = "Allow incoming traffic from members of the same security group"
      from_port         = 0
      to_port           = 65535
      v4_cidr_blocks    = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
      predefined_target = "self_security_group"
  }

  egress {
      protocol          = "ANY"
      description       = "Allow outgoing traffic to members of the same security group"
      from_port         = 0
      to_port           = 65535
      v4_cidr_blocks    = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
      predefined_target = "self_security_group"
    }
}
