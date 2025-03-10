# Домашнее задание к занятию «Как работает сеть в K8s»

<details>
<summary><b>Описание задания</b></summary>

### Цель задания

Настроить сетевую политику доступа к подам.

### Чеклист готовности к домашнему заданию

1. Кластер K8s с установленным сетевым плагином Calico.

### Инструменты и дополнительные материалы, которые пригодятся для выполнения задания

1. [Документация Calico](https://www.tigera.io/project-calico/).
2. [Network Policy](https://kubernetes.io/docs/concepts/services-networking/network-policies/).
3. [About Network Policy](https://docs.projectcalico.org/about/about-network-policy).

-----

### Задание 1. Создать сетевую политику или несколько политик для обеспечения доступа

1. Создать deployment'ы приложений frontend, backend и cache и соответсвующие сервисы.
2. В качестве образа использовать network-multitool.
3. Разместить поды в namespace App.
4. Создать политики, чтобы обеспечить доступ frontend -> backend -> cache. Другие виды подключений должны быть запрещены.
5. Продемонстрировать, что трафик разрешён и запрещён.

### Правила приёма работы

1. Домашняя работа оформляется в своём Git-репозитории в файле README.md. Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.
2. Файл README.md должен содержать скриншоты вывода необходимых команд, а также скриншоты результатов.
3. Репозиторий должен содержать тексты манифестов или ссылки на них в файле README.md.

</details>

<br>

## Задача 1

![Скриншот 1](https://github.com/cachmc/netology_devops_homework/raw/main/07-kubernetes/13-network-operation/pictures/task-01-00.png)

<br>

```bash
kubectl apply -f deployments.yaml
kubectl get pods -n app -o wide

kubectl apply -f services.yaml
kubectl get service -n app -o wide

curl --connect-timeout 3 http://<EXTERNAL_IP_CLUSTER_NODE>:30780
curl --connect-timeout 3 http://<EXTERNAL_IP_CLUSTER_NODE>:30880
curl --connect-timeout 3 http://<EXTERNAL_IP_CLUSTER_NODE>:30980

kubectl apply -f networkpolicies.yaml
kubectl get networkpolicy -n app -o wide

curl --connect-timeout 3 http://<EXTERNAL_IP_CLUSTER_NODE>:30780
curl --connect-timeout 3 http://<EXTERNAL_IP_CLUSTER_NODE>:30880
curl --connect-timeout 3 http://<EXTERNAL_IP_CLUSTER_NODE>:30980

echo "from pod Frontend to pod Backend" && kubectl exec deployment/app-frontend -n app -- curl -s --connect-timeout 3 http://<BACKEND_POD_IP>:80
echo "from pod Frontend to pod Cache" && kubectl exec deployment/app-frontend -n app -- curl -s --connect-timeout 3 http://<CACHE_POD_IP>:80

echo "from pod Backend to pod Frontend" && kubectl exec deployment/app-backend -n app -- curl -s --connect-timeout 3 http://<FRONTEND_POD_IP>:80
echo "from pod Backend to pod Cache" && kubectl exec deployment/app-backend -n app -- curl -s --connect-timeout 3 http://<CACHE_POD_IP>:80

echo "from pod Cache to pod Frontend" && kubectl exec deployment/app-cache -n app -- curl -s --connect-timeout 3 http://<FRONTEND_POD_IP>:80
echo "from pod Cache to pod Backend" && kubectl exec deployment/app-cache -n app -- curl -s --connect-timeout 3 http://<BACKEND_POD_IP>:80
```

<br>
<br>

## [Deployments manifest](https://github.com/cachmc/netology_devops_homework/tree/main/07-kubernetes/13-network-operation/src/deployments.yaml)

## [Services manifest](https://github.com/cachmc/netology_devops_homework/tree/main/07-kubernetes/13-network-operation/src/services.yaml)

## [Network Policies manifest](https://github.com/cachmc/netology_devops_homework/tree/main/07-kubernetes/13-network-operation/src/networkpolicies.yaml)
