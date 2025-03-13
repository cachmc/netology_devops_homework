# Домашнее задание к занятию «Обновление приложений»

<details>
<summary><b>Описание задания</b></summary>

### Цель задания

Выбрать и настроить стратегию обновления приложения.

### Чеклист готовности к домашнему заданию

1. Кластер K8s.

### Инструменты и дополнительные материалы, которые пригодятся для выполнения задания

1. [Документация Updating a Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#updating-a-deployment).
2. [Статья про стратегии обновлений](https://habr.com/ru/companies/flant/articles/471620/).

-----

### Задание 1. Выбрать стратегию обновления приложения и описать ваш выбор

1. Имеется приложение, состоящее из нескольких реплик, которое требуется обновить.
2. Ресурсы, выделенные для приложения, ограничены, и нет возможности их увеличить.
3. Запас по ресурсам в менее загруженный момент времени составляет 20%.
4. Обновление мажорное, новые версии приложения не умеют работать со старыми.
5. Вам нужно объяснить свой выбор стратегии обновления приложения.

### Задание 2. Обновить приложение

1. Создать deployment приложения с контейнерами nginx и multitool. Версию nginx взять 1.19. Количество реплик — 5.
2. Обновить версию nginx в приложении до версии 1.20, сократив время обновления до минимума. Приложение должно быть доступно.
3. Попытаться обновить nginx до версии 1.28, приложение должно оставаться доступным.
4. Откатиться после неудачного обновления.

## Дополнительные задания — со звёздочкой*

Задания дополнительные, необязательные к выполнению, они не повлияют на получение зачёта по домашнему заданию. **Но мы настоятельно рекомендуем вам выполнять все задания со звёздочкой.** Это поможет лучше разобраться в материале.   

### Задание 3*. Создать Canary deployment

1. Создать два deployment'а приложения nginx.
2. При помощи разных ConfigMap сделать две версии приложения — веб-страницы.
3. С помощью ingress создать канареечный деплоймент, чтобы можно было часть трафика перебросить на разные версии приложения.

### Правила приёма работы

1. Домашняя работа оформляется в своем Git-репозитории в файле README.md. Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.
2. Файл README.md должен содержать скриншоты вывода необходимых команд, а также скриншоты результатов.
3. Репозиторий должен содержать тексты манифестов или ссылки на них в файле README.md.

</details>

<br>

## Задача 1

Предложу следующую стратегию обновления приложения:

```yaml
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 20%
      maxUnavailable: 100%
```

Первым этапом будут запушены `maxSurge: 20%` подов новой версии приложения. Вторым этапом будут удалены все поды со старой версией приложения, за это отвечает параметр `maxUnavailable: 100%`. И последним этапом, после удаления, будут подняты оставшиеся 80% подов с новой версией приложения. Таким образом мы избежим несовместимость между разными версиями, обеспечим непрерывную доступность приложения и в пике колличество экземпляров приложения не привысит запас по ресурсам в 20%.

<br>

## Задача 2

![Скриншот 1](https://github.com/cachmc/netology_devops_homework/raw/main/07-kubernetes/14-app-update/pictures/task-02-00.png)

![Скриншот 2](https://github.com/cachmc/netology_devops_homework/raw/main/07-kubernetes/14-app-update/pictures/task-02-01.png)

<br>

```bash
helm install http-application --set nginx_version=1.19 .
kubectl get pod -o wide
kubectl rollout history deployment/http-application

helm upgrade http-application --set nginx_version=1.20 .
kubectl get pod -o wide
kubectl rollout history deployment/http-application

helm upgrade http-application --set nginx_version=1.28 .
kubectl get pod -o wide
kubectl rollout history deployment/http-application

kubectl rollout undo deployment/http-application --to-revision=2
kubectl get pod -o wide
kubectl rollout history deployment/http-application
```

## Задача 3

![Скриншот 3](https://github.com/cachmc/netology_devops_homework/raw/main/07-kubernetes/14-app-update/pictures/task-03-00.png)

```bash
kubectl apply -f canary_deployment.yaml

for i in $(seq 1 20); do curl -s --resolve web.server.nginx:80:<IP_CLUSTER_NODE> web.server.nginx | grep "Nginx version"; done
```

<br>
<br>

## [Helm chart](https://github.com/cachmc/netology_devops_homework/tree/main/07-kubernetes/14-app-update/src/helm)

## [Canary Deployment manifest](https://github.com/cachmc/netology_devops_homework/tree/main/07-kubernetes/14-app-update/src/canary_deployment.yaml)
