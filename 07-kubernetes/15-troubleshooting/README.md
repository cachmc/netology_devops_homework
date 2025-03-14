# Домашнее задание к занятию «Troubleshooting»

<details>
<summary><b>Описание задания</b></summary>

### Цель задания

Устранить неисправности при деплое приложения.

### Чеклист готовности к домашнему заданию

1. Кластер K8s.

### Задание. При деплое приложение web-consumer не может подключиться к auth-db. Необходимо это исправить

1. Установить приложение по команде:
```shell
kubectl apply -f https://raw.githubusercontent.com/netology-code/kuber-homeworks/main/3.5/files/task.yaml
```
2. Выявить проблему и описать.
3. Исправить проблему, описать, что сделано.
4. Продемонстрировать, что проблема решена.


### Правила приёма работы

1. Домашняя работа оформляется в своём Git-репозитории в файле README.md. Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.
2. Файл README.md должен содержать скриншоты вывода необходимых команд, а также скриншоты результатов.
3. Репозиторий должен содержать тексты манифестов или ссылки на них в файле README.md.
</details>

<br>

## Задача 1

![Скриншот 1](https://github.com/cachmc/netology_devops_homework/raw/main/07-kubernetes/15-troubleshooting/pictures/task-01-00.png)

![Скриншот 2](https://github.com/cachmc/netology_devops_homework/raw/main/07-kubernetes/15-troubleshooting/pictures/task-01-01.png)

При первом деплое мы видим ошибку при загрузке образа для pod'а `web-consumer`. В событиях pod'а можно увидеть подробное описание проблемы, а именно: в *containerd* начиная с *v2.0* по умолчанию отключена возможность выгрузки образов собраных по схеме версии 1, и начиная с версии *containerd* *v2.1* поддержка полностью удалена. Так как образ `radial/busyboxplus` не обновлялся 9 лет, то на просторах *Docker Hub* я нашел похожий *busybox* образ с установленным curl - `yauritux/busybox-curl`. Изменив имя образа в манифесте и пременив его заново под `web-consumer` успешно поднялся.

<br>

![Скриншот 3](https://github.com/cachmc/netology_devops_homework/raw/main/07-kubernetes/15-troubleshooting/pictures/task-01-02.png)

После успешного запуска всех pod'ов смотрим в лог deployment'а `web-consumer` и видим, что pod `web-consumer` не может разрезолвить DNS имя pod'а `auth-db`, причина заключается в том что в комманде `web-consumer` уаказано короткое имя pod'а `auth-db`. Так как pod'ы `web-consumer` и `auth-db` находятся в разных namespace'ах (*web* и *data* соответственно), то у них разные DNS зоны и в зоне *web* нет записи с именем *auth-db*. Добавляем к имени pod'а `auth-db` зону *data* и проверяем, что теперь оно резолвится корректно.

<br>

![Скриншот 4](https://github.com/cachmc/netology_devops_homework/raw/main/07-kubernetes/15-troubleshooting/pictures/task-01-03.png)

Меняю имя pod'а в манифесте в команде запуска контейнера `web-consumer` с *auth-db* на *auth-db.data* и пременяю новый манивест. После пересоздания pod'ов снова смотрим в лог deployment'а `web-consumer` и видимо, что ошибки болше нет и *curl* комманда отрабатывает успешно.

<br>

```bash
kubectl create namespace web
kubectl create namespace data

kubectl apply -f https://raw.githubusercontent.com/netology-code/kuber-homeworks/main/3.5/files/task.yaml

kubectl get pod -n web -o wide
kubectl get pod -n data -o wide

kubectl logs deployments/web-consumer -n web
kubectl describe pod/web-consumer-<id> -n web
```

```bash
wget https://raw.githubusercontent.com/netology-code/kuber-homeworks/main/3.5/files/task.yaml
nano task.yaml

kubectl apply -f task.yaml 
kubectl get pod -n web -o wide
kubectl logs deployments/web-consumer -n web

kubectl exec -ti pods/web-consumer-<id> -n web -- curl auth-db
kubectl exec -ti pods/web-consumer-<id> -n web -- curl auth-db.data
```

```bash
nano task.yaml

kubectl apply -f task.yaml 
kubectl logs deployments/web-consumer -n web
```

<br>
<br>

## [Deployment manifest](https://github.com/cachmc/netology_devops_homework/tree/main/07-kubernetes/15-troubleshooting/src/task.yaml)
