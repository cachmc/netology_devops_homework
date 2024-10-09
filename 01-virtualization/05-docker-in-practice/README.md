# Домашнее задание к занятию 5. «Практическое применение Docker»

## Задача 1

#### Пункт 2

![Скриншот 1](https://github.com/cachmc/netology_devops_homework/raw/main/01-virtualization/05-docker-in-practice/pictures/task-1-2.png)

#### Пункт 3

![Скриншот 2](https://github.com/cachmc/netology_devops_homework/raw/main/01-virtualization/05-docker-in-practice/pictures/task-1-3.png)

#### Пункт 4

![Скриншот 3](https://github.com/cachmc/netology_devops_homework/raw/main/01-virtualization/05-docker-in-practice/pictures/task-1-4.png)



## Задача 2

#### Пункт 5

[Отчет сканирования образа](https://github.com/cachmc/netology_devops_homework/raw/main/01-virtualization/05-docker-in-practice/vulnerabilities_image_web_app_py.csv)



## Задача 3

#### Пункт 4

![Скриншот 4](https://github.com/cachmc/netology_devops_homework/raw/main/01-virtualization/05-docker-in-practice/pictures/task-3.png)



## Задача 4

#### Пункт 5

![Скриншот 5](https://github.com/cachmc/netology_devops_homework/raw/main/01-virtualization/05-docker-in-practice/pictures/task-4-5.png)

#### Пункт 6

![Скриншот 6](https://github.com/cachmc/netology_devops_homework/raw/main/01-virtualization/05-docker-in-practice/pictures/task-4-6.png)

```bash
#!/bin/bash

#Устанавливаю Docker
sudo apt-get update
sudo apt-get install ca-certificates curl git -y
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

#Добавляю зеркала для Docker
echo \
"{
  \"registry-mirrors\": [
     \"https://mirror.gcr.io\",
     \"https://daocloud.io\",
     \"https://c.163.com/\",
     \"https://registry.docker-cn.com\"
   ]
}" | \
  sudo tee /etc/docker/docker.json > /dev/null

#Перезапускаю Docker
sudo systemctl restart docker

#sudo usermod -a -G docker $USER

#Создаю каталог для клонирования форка
sudo chmod 777 /opt

mkdir /opt/repo

#Клонирования форка
git clone git@github.com:cachmc/shvirtd-example-python.git /opt/repo

#Собираю образ WEB Application
sudo docker build /opt/repo/ -t cr.yandex/crpooo92jkf633et5esq/web_app_py:1.0.0 -f /opt/repo/Dockerfile.python

#Запускаем контейнеры
sudo docker compose -f /opt/repo/compose.yaml up -d
```

[Форк репозиторий](https://github.com/cachmc/shvirtd-example-python)



## Задача 5

#### Пункт 4

```bash
#!/bin/bash

#Собираю новый образ mysqldump так как мне не хватало пакета mariadb-connector-c для подключения
cat <<EOF >./Dockerfile
FROM schnitzler/mysqldump:latest

RUN apk --update add mysql-client mariadb-connector-c
EOF

docker build . -t vshishkov/mysqldump:1.0.0

rm -f Dockerfile

# При ручном запуске можно запрашивать у пользоватателя root пароль для БД
#read -sp 'Please, entry DB root password: ' DB_ROOT_PASSWORD
#echo

#Единоразово запускаю контейнер mysqldump чтобы сделать дамп БД
docker run \
    --rm --entrypoint "" \
    -v /opt/backup:/backup \
    --network=repo_backend \
    --ip=172.20.0.15 \
    vshishkov/mysqldump:1.0.0 \
    mysqldump --opt -h 172.20.0.10 -u root -p$DB_ROOT_PASSWORD "--result-file=/backup/"$(date +"%s_%Y-%m-%d")"-dumps.sql" example

```

```bash
*/1 * * * * for variable in $(cat /opt/repo/scripts/mysqldump.list.env); do export $(echo $variable); done; /opt/repo/scripts/run_mysqldump_docker.sh
```

![Скриншот 7](https://github.com/cachmc/netology_devops_homework/raw/main/01-virtualization/05-docker-in-practice/pictures/task-5.png)



## Задача 6

![Скриншот 8](https://github.com/cachmc/netology_devops_homework/raw/main/01-virtualization/05-docker-in-practice/pictures/task-6-1.png)

![Скриншот 9](https://github.com/cachmc/netology_devops_homework/raw/main/01-virtualization/05-docker-in-practice/pictures/task-6-2.png)



## Задача 6.1

![Скриншот 10](https://github.com/cachmc/netology_devops_homework/raw/main/01-virtualization/05-docker-in-practice/pictures/task-6-3.png)



## Задача 6.1

![Скриншот 11](https://github.com/cachmc/netology_devops_homework/raw/main/01-virtualization/05-docker-in-practice/pictures/task-6-4.png)



## Задача 7

![Скриншот 12](https://github.com/cachmc/netology_devops_homework/raw/main/01-virtualization/05-docker-in-practice/pictures/task-7.png)

#### config.json
```json
{
        "ociVersion": "1.0.2-dev",
        "process": {
                "terminal": true,
                "user": {
                        "uid": 0,
                        "gid": 0
                },
                "args": [
                        "/usr/local/bin/python3",
                        "/app/main.py"
                ],
                "env": [
                        "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
                        "TERM=xterm",
                        "DB_HOST=172.17.0.2",
                        "DB_USER=app",
                        "DB_NAME=example",
                        "DB_TABLE=requests_new",
                        "DB_PASSWORD=<ПАРОЛЬ>"
                ],
                "cwd": "/",
                "capabilities": {
                        "bounding": [
                                "CAP_AUDIT_WRITE",
                                "CAP_KILL",
                                "CAP_NET_BIND_SERVICE"
                        ],
                        "effective": [
                                "CAP_AUDIT_WRITE",
                                "CAP_KILL",
                                "CAP_NET_BIND_SERVICE"
                        ],
                        "permitted": [
                                "CAP_AUDIT_WRITE",
                                "CAP_KILL",
                                "CAP_NET_BIND_SERVICE"
                        ],
                        "ambient": [
                                "CAP_AUDIT_WRITE",
                                "CAP_KILL",
                                "CAP_NET_BIND_SERVICE"
                        ]
                },
                "rlimits": [
                        {
                                "type": "RLIMIT_NOFILE",
                                "hard": 1024,
                                "soft": 1024
                        }
                ],
                "noNewPrivileges": true
        },
        "root": {
                "path": "rootfs",
                "readonly": true
        },
        "hostname": "runc",
        "mounts": [
                {
                        "destination": "/proc",
                        "type": "proc",
                        "source": "proc"
                },
                {
                        "destination": "/dev",
                        "type": "tmpfs",
                        "source": "tmpfs",
                        "options": [
                                "nosuid",
                                "strictatime",
                                "mode=755",
                                "size=65536k"
                        ]
                },
                {
                        "destination": "/dev/pts",
                        "type": "devpts",
                        "source": "devpts",
                        "options": [
                                "nosuid",
                                "noexec",
                                "newinstance",
                                "ptmxmode=0666",
                                "mode=0620",
                                "gid=5"
                        ]
                },
                {
                        "destination": "/dev/shm",
                        "type": "tmpfs",
                        "source": "shm",
                        "options": [
                                "nosuid",
                                "noexec",
                                "nodev",
                                "mode=1777",
                                "size=65536k"
                        ]
                },
                {
                        "destination": "/dev/mqueue",
                        "type": "mqueue",
                        "source": "mqueue",
                        "options": [
                                "nosuid",
                                "noexec",
                                "nodev"
                        ]
                },
                {
                        "destination": "/sys",
                        "type": "sysfs",
                        "source": "sysfs",
                        "options": [
                                "nosuid",
                                "noexec",
                                "nodev",
                                "ro"
                        ]
                },
                {
                        "destination": "/sys/fs/cgroup",
                        "type": "cgroup",
                        "source": "cgroup",
                        "options": [
                                "nosuid",
                                "noexec",
                                "nodev",
                                "relatime",
                                "ro"
                        ]
                }
        ],
        "linux": {
                "resources": {
                        "devices": [
                                {
                                        "allow": false,
                                        "access": "rwm"
                                }
                        ]
                },
                "namespaces": [
                        {
                                "type": "pid"
                        },
                        {
                                "type": "network",
                                "path": "/var/run/netns/netns_web-app"
                        },
                        {
                                "type": "ipc"
                        },
                        {
                                "type": "uts"
                        },
                        {
                                "type": "mount"
                        }
                ],
                "maskedPaths": [
                        "/proc/acpi",
                        "/proc/asound",
                        "/proc/kcore",
                        "/proc/keys",
                        "/proc/latency_stats",
                        "/proc/timer_list",
                        "/proc/timer_stats",
                        "/proc/sched_debug",
                        "/sys/firmware",
                        "/proc/scsi"
                ],
                "readonlyPaths": [
                        "/proc/bus",
                        "/proc/fs",
                        "/proc/irq",
                        "/proc/sys",
                        "/proc/sysrq-trigger"
                ]
        }
}
```