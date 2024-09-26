# Домашнее задание к занятию 4 «Оркестрация группой Docker контейнеров на примере Docker Compose»

## Задача 1

https://hub.docker.com/layers/vshishkov/custom-nginx/1.0.0/images/sha256-9137ab19ceb89f900d6804a445f4d2aba38fa0dca576f84a3859ca7d1dbd92fe?tab=layers


## Задача 2

![Скриншот 1](https://github.com/cachmc/netology_devops_homework/raw/main/01-virtualization/04-docker-intro/pictures/task-2.png)


## Задача 3

![Скриншот 1](https://github.com/cachmc/netology_devops_homework/raw/main/01-virtualization/04-docker-intro/pictures/task-3-1.png)
3. Предположу что в данном образе родительским процессом был `nginx` поэтому отправив ему STDIN сигнал прерывания процесса (SIGINT), он отреагировал на него  т процесс был завершен. Тем самым работа контейнера остановилась.

![Скриншот 2](https://github.com/cachmc/netology_devops_homework/raw/main/01-virtualization/04-docker-intro/pictures/task-3-2.png)

![Скриншот 3](https://github.com/cachmc/netology_devops_homework/raw/main/01-virtualization/04-docker-intro/pictures/task-3-3.png)
10. Предположу что после смены порта в контейнере, docker (шина?) перестал слушать порт 8080 на хосте, так как не смог достучаться до порта 80 (указанного в маппинге) в сети контейнера. 

![Скриншот 4](https://github.com/cachmc/netology_devops_homework/raw/main/01-virtualization/04-docker-intro/pictures/task-3-4.png)


## Задача 4

![Скриншот 1](https://github.com/cachmc/netology_devops_homework/raw/main/01-virtualization/04-docker-intro/pictures/task-4.png)

## Задача 5

1. Был запущен файл `compose.yaml` так как он предпочтительней если в директории, где запускается `docker compose` имеются оба файла: `compose.yaml` и `docker-compose.yaml`. Последний поддерживается по обратной совместимости и был актуален для утилиты `docker-compose`.
2. ![Скриншот 1](https://github.com/cachmc/netology_devops_homework/raw/main/01-virtualization/04-docker-intro/pictures/task-5-1.png)
3. ![Скриншот 2](https://github.com/cachmc/netology_devops_homework/raw/main/01-virtualization/04-docker-intro/pictures/task-5-2.png)
4. ![Скриншот 3](https://github.com/cachmc/netology_devops_homework/raw/main/01-virtualization/04-docker-intro/pictures/task-5-3.png)
![Скриншот 4](https://github.com/cachmc/netology_devops_homework/raw/main/01-virtualization/04-docker-intro/pictures/task-5-4.png)
5. ![Скриншот 5](https://github.com/cachmc/netology_devops_homework/raw/main/01-virtualization/04-docker-intro/pictures/task-5-5.png)
![Скриншот 6](https://github.com/cachmc/netology_devops_homework/raw/main/01-virtualization/04-docker-intro/pictures/task-5-6.png)
6. ![Скриншот 7](https://github.com/cachmc/netology_devops_homework/raw/main/01-virtualization/04-docker-intro/pictures/task-5-7.png)
7. Так как мы удалили манифест из которого был создан один из контейнеров, docker предупредил нас что есть контейнеры "сироты" (не описанные в манифесте(-ах)), и предложил при поднятии контейнеров `docker compose up -d` добавить ключ `--remove-orphans`.  Данные ключ можно применить как при создании так и при удалении контейнеров, он удалит "осиротевшие" контейнеры.
![Скриншот 8](https://github.com/cachmc/netology_devops_homework/raw/main/01-virtualization/04-docker-intro/pictures/task-5-8.png)
