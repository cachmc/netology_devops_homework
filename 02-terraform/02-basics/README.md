# Домашнее задание к занятию «Основы Terraform. Yandex Cloud»

## Задача 1

#### Пункт 4

![Скриншот 1](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/02-basics/pictures/task-1-4.png)

Первая ошибка была в id платформы (CPU), а именно в самом слове `standard` и в версии этого самого стандарта. В [документации](https://yandex.cloud/ru/docs/compute/concepts/vm-platforms) описаны id которые поддерживает облачный провайдер. Из тех что представлены, *v1* и *v2* поддерживают гарантированную выделенную долю утилизации CPU в 5%. Поэтому я заменил `standart-v4` на `standard-v1`.

Вторая ошибка была в количестве ядер они должны быть кратны 2-ум. Поэтому минимально допустимое значение = 2.

#### Пункт 5

![Скриншот 2](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/02-basics/pictures/task-1-5.png)

#### Пункт 6

`preemptible = true` - параметр включает прерываемость ВМ. Это снижает стоимость самой ВМ и позволяет не тратить средства на баланса если забыл ее выключить.

`core_fraction=5` - это как раз и есть гарантированная выделенная доля утилизации CPU. 5% отлично подходит для малонагруженных ознакомительных ВМ и сильно снижает ее стоимость.



## Задача 2

![Скриншот 3](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/02-basics/pictures/task-2.png)



## Задача 3

![Скриншот 4](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/02-basics/pictures/task-3.png)



## Задача 4

Не понял как нужно сделать, сделал два варианта :)

![Скриншот 5](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/02-basics/pictures/task-4.png)



## Задача 5

![Скриншот 6](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/02-basics/pictures/task-5.png)



## Задача 6

![Скриншот 7](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/02-basics/pictures/task-6.png)



## Задача 7

#### Пункт 1

```
> local.test_list.1

"staging"
```

или

```
> local.test_list[1]

"staging"
```

#### Пункт 2

```
> length(local.test_list)

3
```

#### Пункт 3

```
> local.test_map.admin

"John"
```

#### Пункт 4

```
> "${local.test_map.admin} is ${[for k,v in local.test_map : k if k == "admin"][0]} for ${[for k,v in local.servers : k if k == "production"][0]} server based on OS ${local.servers.production.image} with ${local.servers.production.cpu} vspu, ${local.servers.production.ram} ram and ${length(local.servers.production.disks)} virtual disks" 

"John is admin for production server based on OS ubuntu-20-04 with 10 vspu, 40 ram and 4 virtual disks"
```



## Задача 8

#### Пункт 1

![Скриншот 8](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/02-basics/pictures/task-8-1.png)

#### Пункт 2

```
> var.test.0.dev1.0

"ssh -o 'StrictHostKeyChecking=no' ubuntu@62.84.124.117"
```

или

```
> var.test[0].dev1[0]

"ssh -o 'StrictHostKeyChecking=no' ubuntu@62.84.124.117"
```



## Задача 9

![Скриншот 9](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/02-basics/pictures/task-9-1.png)

![Скриншот 10](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/02-basics/pictures/task-9-2.png)



# [Terraform Code](https://github.com/cachmc/netology_devops_homework/tree/main/02-terraform/02-basics/src)
