
# Домашнее задание к занятию "Введение в Terraform"

## Задача 1

#### Пункт 2

Чувствительную информацию в данном случае можно хранить в файле `personal.auto.tfvars`

#### Пункт 3

```json
"result": "gBb8jMSVTGVbT4b6"
```

#### Пункт 4

```
╷
│  Error: Missing name for resource  
│
│ on main.tf line 23, in resource "docker_image": 
│ 23: resource "docker_image" {  
│
│ All resource blocks must have 2 labels (type, name).
╵
```
Ошибка нам говорит, что во всех блоках типа `resource` должно быть два лейбла. В данном случае в коде в блоке ресурса "docker_image" отсутствует лейбл с именованием этого блока.

<br>

```
╷
│  Error: Invalid resource name  
│
│ on main.tf line 28, in resource "docker_container" "1nginx": 
│ 28: resource "docker_container" "1nginx" { 
│
│ A name must start with a letter or underscore and may contain only letters, digits, underscores, and dashes. 
╵
Ошибка в именовании блока. Имя блока должно начинаться с буквы или нижнего подчеркивания. В данном случае имя блока начинается с цифры.
```

<br>

```
╷  
│  Error: Reference to undeclared resource  
│  
│ on main.tf line 30, in resource "docker_container" "nginx": 
│ 30:   name  = "example_${random_password.random_string_FAKE.resulT}" 
│  
│ A managed resource "random_password" "random_string_FAKE" has not been declared in the root module. 
╵
```
Допущена ошибка в пути к результату выполнения блока ресурса `random_password`. А именно в название данного блока `random_string_FAKE -> random_string` и в имени ключа, где хранится сам пароль `resulT -> result`.

#### Пункт 5

```
resource "docker_image" "nginx_latest" {
 name         = "nginx:latest"
 keep_locally = true
}

resource "docker_container" "nginx" {
 image = docker_image.nginx_latest.image_id
 name  = "example_${random_password.random_string.result}"
 ports {
 internal = 80
 external = 9090
 }
}
```

![Скриншот 1](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/01-introduction/pictures/task-1-5.png)

#### Пункт 6

Не гугли, но предположу что опасность может быть в челфаке и неконтролируемом применении изменений. Перед применением изменений на инфраструктуре ни когда не будет лишним убедиться в их корректности. Просмотреть план действий *terraform*'а, убедиться что все правильно и уже затем заапрувить изменения.

Полезность же данного ключа, такое же как и например у ключа `-y` пакетного менеджера `apt-get` или `yum`. Возможность запускать terraform код в автоматизация и CI/CD процессах, без участия человека.

![Скриншот 2](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/01-introduction/pictures/task-1-6.png)

#### Пункт 7

```bash
cat terraform.tfstate
```
```json
{
  "version": 4,
  "terraform_version": "1.8.4",
  "serial": 11,
  "lineage": "7629fadc-9ae9-9930-e745-68ae122690d5",
  "outputs": {},
  "resources": [],
  "check_results": null
}
```

#### Пункт 8

Образ *nginx* для *docker* не был удален, так как в коде *terraform* в блоке `docker_image.nginx_latest` присутствует параметр `keep_locally = true`. Он сохраняет скаченный образ на локальном хосте при выполнении команды `terraform destroy`.

![Скриншот 3](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/01-introduction/pictures/task-1-8.png)



## Задача 2

Создание ВМ в Yandex Cloud
```json
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = "~>1.8.4"
}



provider "yandex" {
  token                    = var.token
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.default_zone
}



variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  default     = "b1gckqal9th70votrnub"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  default     = "b1gfoipitiot0c1fe5ln"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.10.30.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "netology-network"
  description = "VPC network & subnet name"
}

variable "ssh_key" {
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL3oLskaY3H39j5ZSdodVRfmvBntSaVyiieWnKOyNnRh"
  description = "ssh-keygen -t ed25519"
}

variable "ssh_user" {
  type    = string
  default = "vmshishkov"
}



resource "yandex_vpc_network" "netology-network" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "netology-subnet" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.netology-network.id
  v4_cidr_blocks = var.default_cidr
}



data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2204-lts"
}
resource "yandex_compute_instance" "netology-docker" {
  name        = "netology-docker"
  platform_id = "standard-v3"
  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.netology-subnet.id
    nat       = true
  }
  metadata = {
    serial-port-enable = 0
    ssh-keys           = "${var.ssh_user}:${var.ssh_key}"
    user-data          = <<-EOT
                #cloud-config
                datasource:
                 Ec2:
                  strict_id: false

                ssh_pwauth: no

                groups:
                  - docker
                
                users:
                - name: ${var.ssh_user}
                  groups: docker
                  sudo: ALL=(ALL) NOPASSWD:ALL
                  shell: /bin/bash
                  ssh_authorized_keys:
                  - ${var.ssh_key}

                package_update: true
                package_upgrade: true
                
                packages:
                  - apt-transport-https
                  - ca-certificates
                  - curl
                  - gnupg
                  - lsb-release
                  - unattended-upgrades

                runcmd:
                  - mkdir -p /etc/apt/keyrings
                  - curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
                  - echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list /dev/null
                  - apt-get update
                  - apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
                  - systemctl enable docker
                  - systemctl start docker
                EOT
  }
}
```

<br>

Запуск контейнера MySQL
```json
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
  required_version = "~>1.8.4"
}



provider "docker" {
  host     = "ssh://${var.ssh_user}@${var.ssh_host}:22"
  ssh_opts = ["-o", "StrictHostKeyChecking=no", "-o", "UserKnownHostsFile=/dev/null"]
}



variable "ssh_user" {
  type    = string
  default = "vmshishkov"
}

variable "ssh_host" {
  type    = string
  default = "158.160.4.30"
}



resource "random_password" "mysql_root_password" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}

resource "random_password" "mysql_password" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}



resource "docker_image" "mysql" {
  name         = "mysql:8"
  keep_locally = true
}

resource "docker_container" "mysql" {
  image   = docker_image.mysql.image_id
  name    = "mysql_db"
  restart = "on-failure"

  ports {
    internal = 3306
    external = 3306
  }

  env = [
    "MYSQL_ROOT_PASSWORD=${random_password.mysql_root_password.result}",
    "MYSQL_DATABASE=wordpress",
    "MYSQL_USER=wordpress",
    "MYSQL_PASSWORD=${random_password.mysql_password.result}",
    "MYSQL_ROOT_HOST='%'"
  ]
}
```

<br>

![Скриншот 4](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/01-introduction/pictures/task-2.png)



## Задача 3

![Скриншот 5](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/01-introduction/pictures/task-3-1.png)

![Скриншот 6](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/01-introduction/pictures/task-3-2.png)

![Скриншот 7](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/01-introduction/pictures/task-3-3.png)

![Скриншот 8](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/01-introduction/pictures/task-3-4.png)

![Скриншот 9](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/01-introduction/pictures/task-3-5.png)

![Скриншот 10](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/01-introduction/pictures/task-3-6.png)
