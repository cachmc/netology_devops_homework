# Домашнее задание к занятию «Продвинутые методы работы с Terraform»

## Задача 1

![Скриншот 1](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/04-advanced-methods/pictures/task-1-1.png)

![Скриншот 2](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/04-advanced-methods/pictures/task-1-2.png)

![Скриншот 3](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/04-advanced-methods/pictures/task-1-3.png)

![Скриншот 4](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/04-advanced-methods/pictures/task-1-4.png)

<br>
<br>

## Задача 2

### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~>1.8.4 |

### Providers

| Name | Version |
|------|---------|
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | n/a |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [yandex_vpc_network.create_network](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_network) | resource |
| [yandex_vpc_subnet.create_subnet](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_subnet) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr"></a> [cidr](#input\_cidr) | Subnet address pool | `string` | n/a | yes |
| <a name="input_env_name"></a> [env\_name](#input\_env\_name) | Environment name | `string` | `null` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | Network zone name | `string` | n/a | yes |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_network_id"></a> [network\_id](#output\_network\_id) | ID of the created network |
| <a name="output_subnet_id"></a> [subnet\_id](#output\_subnet\_id) | ID of the created subnet |

<br>
<br>

## Задача 3

```bash
terraform state list

terraform state show module.vpc_dev.yandex_vpc_network.create_network
terraform state show module.vpc_dev.yandex_vpc_subnet.create_subnet
terraform state show module.marketing_vm.yandex_compute_instance.vm[0]

terraform state rm module.vpc_dev.yandex_vpc_network.create_network
terraform state rm module.vpc_dev.yandex_vpc_subnet.create_subnet
terraform state rm module.marketing_vm.data.yandex_compute_image.my_image
terraform state rm module.marketing_vm.yandex_compute_instance.vm[0]

terraform import module.vpc_dev.yandex_vpc_network.create_network enp7jutr8rempn0c6o37
terraform import module.vpc_dev.yandex_vpc_subnet.create_subnet e9bh7l4198err8lnch3m
terraform import module.marketing_vm.yandex_compute_instance.vm[0] fhmhq4g7iuc74kfd6rbc

terraform plan
```

![Скриншот 5](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/04-advanced-methods/pictures/task-3-1.png)

![Скриншот 6](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/04-advanced-methods/pictures/task-3-2.png)

![Скриншот 7](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/04-advanced-methods/pictures/task-3-3.png)

![Скриншот 8](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/04-advanced-methods/pictures/task-3-4.png)

<br>
<br>

## Задача 4

![Скриншот 9](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/04-advanced-methods/pictures/task-4-1.png)

![Скриншот 10](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/04-advanced-methods/pictures/task-4-2.png)

![Скриншот 11](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/04-advanced-methods/pictures/task-4-3.png)

![Скриншот 12](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/04-advanced-methods/pictures/task-4-4.png)

![Скриншот 13](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/04-advanced-methods/pictures/task-4-5.png)

<br>
<br>

## Задача 5

![Скриншот 14](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/04-advanced-methods/pictures/task-5-1.png)

![Скриншот 15](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/04-advanced-methods/pictures/task-5-2.png)

![Скриншот 16](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/04-advanced-methods/pictures/task-5-3.png)

![Скриншот 17](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/04-advanced-methods/pictures/task-5-4.png)

![Скриншот 18](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/04-advanced-methods/pictures/task-5-5.png)

![Скриншот 19](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/04-advanced-methods/pictures/task-5-6.png)

![Скриншот 20](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/04-advanced-methods/pictures/task-5-7.png)

![Скриншот 21](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/04-advanced-methods/pictures/task-5-8.png)

![Скриншот 22](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/04-advanced-methods/pictures/task-5-9.png)

![Скриншот 23](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/04-advanced-methods/pictures/task-5-10.png)

![Скриншот 24](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/04-advanced-methods/pictures/task-5-11.png)

<br>
<br>

## Задача 6

![Скриншот 25](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/04-advanced-methods/pictures/task-6-1.png)

![Скриншот 26](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/04-advanced-methods/pictures/task-6-2.png)

![Скриншот 27](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/04-advanced-methods/pictures/task-6-3.png)

![Скриншот 28](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/04-advanced-methods/pictures/task-6-4.png)

![Скриншот 29](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/04-advanced-methods/pictures/task-6-5.png)

![Скриншот 30](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/04-advanced-methods/pictures/task-6-6.png)

![Скриншот 31](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/04-advanced-methods/pictures/task-6-7.png)

<br>
<br>

## Задача 7

![Скриншот 32](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/04-advanced-methods/pictures/task-7-1.png)

![Скриншот 33](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/04-advanced-methods/pictures/task-7-2.png)

![Скриншот 34](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/04-advanced-methods/pictures/task-7-3.png)

![Скриншот 35](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/04-advanced-methods/pictures/task-7-4.png)

<br>
<br>

## Задача 8

![Скриншот 36](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/04-advanced-methods/pictures/task-8-1.png)

![Скриншот 37](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/04-advanced-methods/pictures/task-8-2.png)

![Скриншот 38](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/04-advanced-methods/pictures/task-8-3.png)

![Скриншот 39](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/04-advanced-methods/pictures/task-8-4.png)

<br>
<br>

# [Terraform Code](https://github.com/cachmc/netology_devops_homework/tree/main/02-terraform/04-advanced-methods/src)
