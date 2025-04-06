# Домашнее задание к занятию «Кластеры. Ресурсы под управлением облачных провайдеров»

<details>
<summary><b>Описание задания</b></summary>

### Цели задания 

1. Организация кластера Kubernetes и кластера баз данных MySQL в отказоустойчивой архитектуре.
2. Размещение в private подсетях кластера БД, а в public — кластера Kubernetes.

---
## Задание 1. Yandex Cloud

1. Настроить с помощью Terraform кластер баз данных MySQL.

 - Используя настройки VPC из предыдущих домашних заданий, добавить дополнительно подсеть private в разных зонах, чтобы обеспечить отказоустойчивость. 
 - Разместить ноды кластера MySQL в разных подсетях.
 - Необходимо предусмотреть репликацию с произвольным временем технического обслуживания.
 - Использовать окружение Prestable, платформу Intel Broadwell с производительностью 50% CPU и размером диска 20 Гб.
 - Задать время начала резервного копирования — 23:59.
 - Включить защиту кластера от непреднамеренного удаления.
 - Создать БД с именем `netology_db`, логином и паролем.

2. Настроить с помощью Terraform кластер Kubernetes.

 - Используя настройки VPC из предыдущих домашних заданий, добавить дополнительно две подсети public в разных зонах, чтобы обеспечить отказоустойчивость.
 - Создать отдельный сервис-аккаунт с необходимыми правами. 
 - Создать региональный мастер Kubernetes с размещением нод в трёх разных подсетях.
 - Добавить возможность шифрования ключом из KMS, созданным в предыдущем домашнем задании.
 - Создать группу узлов, состояющую из трёх машин с автомасштабированием до шести.
 - Подключиться к кластеру с помощью `kubectl`.
 - *Запустить микросервис phpmyadmin и подключиться к ранее созданной БД.
 - *Создать сервис-типы Load Balancer и подключиться к phpmyadmin. Предоставить скриншот с публичным адресом и подключением к БД.

Полезные документы:

- [MySQL cluster](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_mysql_cluster).
- [Создание кластера Kubernetes](https://cloud.yandex.ru/docs/managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create)
- [K8S Cluster](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/kubernetes_cluster).
- [K8S node group](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/kubernetes_node_group).

--- 
## Задание 2*. Вариант с AWS (задание со звёздочкой)

Это необязательное задание. Его выполнение не влияет на получение зачёта по домашней работе.

**Что нужно сделать**

1. Настроить с помощью Terraform кластер EKS в три AZ региона, а также RDS на базе MySQL с поддержкой MultiAZ для репликации и создать два readreplica для работы.
 
 - Создать кластер RDS на базе MySQL.
 - Разместить в Private subnet и обеспечить доступ из public сети c помощью security group.
 - Настроить backup в семь дней и MultiAZ для обеспечения отказоустойчивости.
 - Настроить Read prelica в количестве двух штук на два AZ.

2. Создать кластер EKS на базе EC2.

 - С помощью Terraform установить кластер EKS на трёх EC2-инстансах в VPC в public сети.
 - Обеспечить доступ до БД RDS в private сети.
 - С помощью kubectl установить и запустить контейнер с phpmyadmin (образ взять из docker hub) и проверить подключение к БД RDS.
 - Подключить ELB (на выбор) к приложению, предоставить скрин.

Полезные документы:

- [Модуль EKS](https://learn.hashicorp.com/tutorials/terraform/eks).

### Правила приёма работы

Домашняя работа оформляется в своём Git репозитории в файле README.md. Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.
Файл README.md должен содержать скриншоты вывода необходимых команд, а также скриншоты результатов.
Репозиторий должен содержать тексты манифестов или ссылки на них в файле README.md.

</details>

<br>

## Задача 1

![Скриншот 1](https://github.com/cachmc/netology_devops_homework/raw/main/08-cloud/04-clusters/pictures/task-01-00.png)

![Скриншот 2](https://github.com/cachmc/netology_devops_homework/raw/main/08-cloud/04-clusters/pictures/task-01-01.png)

![Скриншот 3](https://github.com/cachmc/netology_devops_homework/raw/main/08-cloud/04-clusters/pictures/task-01-02.png)

![Скриншот 4](https://github.com/cachmc/netology_devops_homework/raw/main/08-cloud/04-clusters/pictures/task-01-03.png)

![Скриншот 5](https://github.com/cachmc/netology_devops_homework/raw/main/08-cloud/04-clusters/pictures/task-01-04.png)

![Скриншот 6](https://github.com/cachmc/netology_devops_homework/raw/main/08-cloud/04-clusters/pictures/task-01-05.png)

![Скриншот 7](https://github.com/cachmc/netology_devops_homework/raw/main/08-cloud/04-clusters/pictures/task-01-06.png)

![Скриншот 8](https://github.com/cachmc/netology_devops_homework/raw/main/08-cloud/04-clusters/pictures/task-01-07.png)

![Скриншот 9](https://github.com/cachmc/netology_devops_homework/raw/main/08-cloud/04-clusters/pictures/task-01-08.png)

![Скриншот 10](https://github.com/cachmc/netology_devops_homework/raw/main/08-cloud/04-clusters/pictures/task-01-09.png)

![Скриншот 11](https://github.com/cachmc/netology_devops_homework/raw/main/08-cloud/04-clusters/pictures/task-01-10.png)

![Скриншот 12](https://github.com/cachmc/netology_devops_homework/raw/main/08-cloud/04-clusters/pictures/task-01-11.png)

![Скриншот 13](https://github.com/cachmc/netology_devops_homework/raw/main/08-cloud/04-clusters/pictures/task-01-12.png)

## Задача 2

![Скриншот 14](https://github.com/cachmc/netology_devops_homework/raw/main/08-cloud/04-clusters/pictures/task-02-00.png)

![Скриншот 15](https://github.com/cachmc/netology_devops_homework/raw/main/08-cloud/04-clusters/pictures/task-02-01.png)

![Скриншот 16](https://github.com/cachmc/netology_devops_homework/raw/main/08-cloud/04-clusters/pictures/task-02-02.png)

![Скриншот 17](https://github.com/cachmc/netology_devops_homework/raw/main/08-cloud/04-clusters/pictures/task-02-03.png)

![Скриншот 18](https://github.com/cachmc/netology_devops_homework/raw/main/08-cloud/04-clusters/pictures/task-02-04.png)

![Скриншот 19](https://github.com/cachmc/netology_devops_homework/raw/main/08-cloud/04-clusters/pictures/task-02-05.png)

![Скриншот 20](https://github.com/cachmc/netology_devops_homework/raw/main/08-cloud/04-clusters/pictures/task-02-06.png)

![Скриншот 21](https://github.com/cachmc/netology_devops_homework/raw/main/08-cloud/04-clusters/pictures/task-02-07.png)

![Скриншот 22](https://github.com/cachmc/netology_devops_homework/raw/main/08-cloud/04-clusters/pictures/task-02-08.png)

![Скриншот 23](https://github.com/cachmc/netology_devops_homework/raw/main/08-cloud/04-clusters/pictures/task-02-09.png)

![Скриншот 24](https://github.com/cachmc/netology_devops_homework/raw/main/08-cloud/04-clusters/pictures/task-02-10.png)

![Скриншот 25](https://github.com/cachmc/netology_devops_homework/raw/main/08-cloud/04-clusters/pictures/task-02-11.png)

![Скриншот 26](https://github.com/cachmc/netology_devops_homework/raw/main/08-cloud/04-clusters/pictures/task-02-12.png)

![Скриншот 27](https://github.com/cachmc/netology_devops_homework/raw/main/08-cloud/04-clusters/pictures/task-02-13.png)

![Скриншот 28](https://github.com/cachmc/netology_devops_homework/raw/main/08-cloud/04-clusters/pictures/task-02-14.png)

![Скриншот 29](https://github.com/cachmc/netology_devops_homework/raw/main/08-cloud/04-clusters/pictures/task-02-15.png)

![Скриншот 30](https://github.com/cachmc/netology_devops_homework/raw/main/08-cloud/04-clusters/pictures/task-02-16.png)

![Скриншот 31](https://github.com/cachmc/netology_devops_homework/raw/main/08-cloud/04-clusters/pictures/task-02-17.png)

![Скриншот 32](https://github.com/cachmc/netology_devops_homework/raw/main/08-cloud/04-clusters/pictures/task-02-18.png)

<br>
<br>

## [Terraform code](https://github.com/cachmc/netology_devops_homework/tree/main/08-cloud/04-clusters/src/terraform)

## [Helm chart](https://github.com/cachmc/netology_devops_homework/tree/main/08-cloud/04-clusters/src/helm)
