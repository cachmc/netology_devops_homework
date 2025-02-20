# Домашнее задание к занятию «Helm»

<details>
<summary><b>Описание задания</b></summary>

### Цель задания

В тестовой среде Kubernetes необходимо установить и обновить приложения с помощью Helm.

------

### Чеклист готовности к домашнему заданию

1. Установленное k8s-решение, например, MicroK8S.
2. Установленный локальный kubectl.
3. Установленный локальный Helm.
4. Редактор YAML-файлов с подключенным репозиторием GitHub.

------

### Инструменты и дополнительные материалы, которые пригодятся для выполнения задания

1. [Инструкция](https://helm.sh/docs/intro/install/) по установке Helm. [Helm completion](https://helm.sh/docs/helm/helm_completion/).

------

### Задание 1. Подготовить Helm-чарт для приложения

1. Необходимо упаковать приложение в чарт для деплоя в разные окружения. 
2. Каждый компонент приложения деплоится отдельным deployment’ом или statefulset’ом.
3. В переменных чарта измените образ приложения для изменения версии.

------
### Задание 2. Запустить две версии в разных неймспейсах

1. Подготовив чарт, необходимо его проверить. Запуститe несколько копий приложения.
2. Одну версию в namespace=app1, вторую версию в том же неймспейсе, третью версию в namespace=app2.
3. Продемонстрируйте результат.

### Правила приёма работы

1. Домашняя работа оформляется в своём Git репозитории в файле README.md. Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.
2. Файл README.md должен содержать скриншоты вывода необходимых команд `kubectl`, `helm`, а также скриншоты результатов.
3. Репозиторий должен содержать тексты манифестов или ссылки на них в файле README.md.

</details>

<br>

## Задача 2

![Скриншот 1](https://github.com/cachmc/netology_devops_homework/raw/main/07-kubernetes/10-helm/pictures/task-02-00.png)

![Скриншот 2](https://github.com/cachmc/netology_devops_homework/raw/main/07-kubernetes/10-helm/pictures/task-02-01.png)

![Скриншот 3](https://github.com/cachmc/netology_devops_homework/raw/main/07-kubernetes/10-helm/pictures/task-02-02.png)

![Скриншот 3](https://github.com/cachmc/netology_devops_homework/raw/main/07-kubernetes/10-helm/pictures/task-02-03.png)

<br>

```bash
kubectl create ns http-application-prod
kubectl create ns http-application-dev
kubectl get ns

helm install http-application-1 . -f app1.yaml
helm install http-application-2 . -f app2.yaml
helm install http-application-3 . -f app3.yaml
helm list
```

<br>
<br>

## [Helm Chart "HTTP Application"](https://github.com/cachmc/netology_devops_homework/tree/main/07-kubernetes/10-helm/src/http-application)
