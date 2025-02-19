# Домашнее задание к занятию «Управление доступом»

<details>
<summary><b>Описание задания</b></summary>

### Цель задания

В тестовой среде Kubernetes нужно предоставить ограниченный доступ пользователю.

------

### Чеклист готовности к домашнему заданию

1. Установлено k8s-решение, например MicroK8S.
2. Установленный локальный kubectl.
3. Редактор YAML-файлов с подключённым github-репозиторием.

------

### Инструменты / дополнительные материалы, которые пригодятся для выполнения задания

1. [Описание](https://kubernetes.io/docs/reference/access-authn-authz/rbac/) RBAC.
2. [Пользователи и авторизация RBAC в Kubernetes](https://habr.com/ru/company/flant/blog/470503/).
3. [RBAC with Kubernetes in Minikube](https://medium.com/@HoussemDellai/rbac-with-kubernetes-in-minikube-4deed658ea7b).

------

### Задание 1. Создайте конфигурацию для подключения пользователя

1. Создайте и подпишите SSL-сертификат для подключения к кластеру.
2. Настройте конфигурационный файл kubectl для подключения.
3. Создайте роли и все необходимые настройки для пользователя.
4. Предусмотрите права пользователя. Пользователь может просматривать логи подов и их конфигурацию (`kubectl logs pod <pod_id>`, `kubectl describe pod <pod_id>`).
5. Предоставьте манифесты и скриншоты и/или вывод необходимых команд.

------

### Правила приёма работы

1. Домашняя работа оформляется в своём Git-репозитории в файле README.md. Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.
2. Файл README.md должен содержать скриншоты вывода необходимых команд `kubectl`, скриншоты результатов.
3. Репозиторий должен содержать тексты манифестов или ссылки на них в файле README.md.

------

</details>

<br>

## Задача 1

![Скриншот 1](https://github.com/cachmc/netology_devops_homework/raw/main/07-kubernetes/09-access-control/pictures/task-01-00.png)

![Скриншот 2](https://github.com/cachmc/netology_devops_homework/raw/main/07-kubernetes/09-access-control/pictures/task-01-01.png)

![Скриншот 3](https://github.com/cachmc/netology_devops_homework/raw/main/07-kubernetes/09-access-control/pictures/task-01-02.png)

<br>

```bash
kubectl apply -f deployment.yaml
kubectl apply -f role.yaml
kubectl apply -f rolebinding.yaml

kubectl get pod -o wide
kubectl get role -o wide
kubectl get rolebinding -o wide

openssl genrsa -out user-nginx.key 2048
openssl req -new -key user-nginx.key -out user-nginx.csr -subj "/CN=user-nginx"
openssl x509 -req -in user-nginx.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out user-nginx.crt -days 365

kubectl config view
kubectl config set-credentials user-nginx --client-certificate=user-nginx.crt --client-key=user-nginx.key --embed-certs=true
kubectl config set-context nginx --user=user-nginx --cluster=microk8s-cluster
kubectl config view
kubectl config use-context nginx
kubectl config current-context

kubectl get pod
kubectl logs pod/http-application-66cb486fdf-vm6hc
kubectl describe pod/http-application-66cb486fdf-vm6hc

kubectl get node
```

<br>
<br>

## [Deployment manifest](https://github.com/cachmc/netology_devops_homework/tree/main/07-kubernetes/09-access-control/src/deployment.yaml)

## [Role manifest](https://github.com/cachmc/netology_devops_homework/tree/main/07-kubernetes/09-access-control/src/role.yaml)

## [Role Binding manifest](https://github.com/cachmc/netology_devops_homework/tree/main/07-kubernetes/09-access-control/src/rolebinding.yaml)
