# Домашнее задание к занятию «Установка Kubernetes»

<details>
<summary><b>Описание задания</b></summary>

### Цель задания

Установить кластер K8s.

### Чеклист готовности к домашнему заданию

1. Развёрнутые ВМ с ОС Ubuntu 20.04-lts.


### Инструменты и дополнительные материалы, которые пригодятся для выполнения задания

1. [Инструкция по установке kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/).
2. [Документация kubespray](https://kubespray.io/).

-----

### Задание 1. Установить кластер k8s с 1 master node

1. Подготовка работы кластера из 5 нод: 1 мастер и 4 рабочие ноды.
2. В качестве CRI — containerd.
3. Запуск etcd производить на мастере.
4. Способ установки выбрать самостоятельно.

## Дополнительные задания (со звёздочкой)

**Настоятельно рекомендуем выполнять все задания под звёздочкой.** Их выполнение поможет глубже разобраться в материале.   
Задания под звёздочкой необязательные к выполнению и не повлияют на получение зачёта по этому домашнему заданию. 

------
### Задание 2*. Установить HA кластер

1. Установить кластер в режиме HA.
2. Использовать нечётное количество Master-node.
3. Для cluster ip использовать keepalived или другой способ.

### Правила приёма работы

1. Домашняя работа оформляется в своем Git-репозитории в файле README.md. Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.
2. Файл README.md должен содержать скриншоты вывода необходимых команд `kubectl get nodes`, а также скриншоты результатов.
3. Репозиторий должен содержать тексты манифестов или ссылки на них в файле README.md.

</details>

<br>

## Развертывание инфрастуктуры

Сервера подняты в *Yandex Cloud*. При помощи *Terraform* создается сеть, 3-и *master nodes*, 5-ть *worker nodes*, 1-н сервер для проксирования трафика c *External IP* на *VIP* и формируется *inventory* файл для последующего запуска *Kubespray*.

<details>
<summary><b>Скриншоты</b></summary>

![Скриншот 1](https://github.com/cachmc/netology_devops_homework/raw/main/07-kubernetes/12-installation/pictures/task-01-00.png)

![Скриншот 2](https://github.com/cachmc/netology_devops_homework/raw/main/07-kubernetes/12-installation/pictures/task-01-01.png)

![Скриншот 3](https://github.com/cachmc/netology_devops_homework/raw/main/07-kubernetes/12-installation/pictures/task-01-02.png)

![Скриншот 4](https://github.com/cachmc/netology_devops_homework/raw/main/07-kubernetes/12-installation/pictures/task-01-03.png)

![Скриншот 5](https://github.com/cachmc/netology_devops_homework/raw/main/07-kubernetes/12-installation/pictures/task-01-04.png)

![Скриншот 6](https://github.com/cachmc/netology_devops_homework/raw/main/07-kubernetes/12-installation/pictures/task-01-05.png)

![Скриншот 7](https://github.com/cachmc/netology_devops_homework/raw/main/07-kubernetes/12-installation/pictures/task-01-06.png)

![Скриншот 8](https://github.com/cachmc/netology_devops_homework/raw/main/07-kubernetes/12-installation/pictures/task-01-07.png)

![Скриншот 9](https://github.com/cachmc/netology_devops_homework/raw/main/07-kubernetes/12-installation/pictures/task-01-08.png)

![Скриншот 10](https://github.com/cachmc/netology_devops_homework/raw/main/07-kubernetes/12-installation/pictures/task-01-09.png)

![Скриншот 11](https://github.com/cachmc/netology_devops_homework/raw/main/07-kubernetes/12-installation/pictures/task-01-10.png)

![Скриншот 12](https://github.com/cachmc/netology_devops_homework/raw/main/07-kubernetes/12-installation/pictures/task-01-11.png)

![Скриншот 13](https://github.com/cachmc/netology_devops_homework/raw/main/07-kubernetes/12-installation/pictures/task-01-12.png)

![Скриншот 14](https://github.com/cachmc/netology_devops_homework/raw/main/07-kubernetes/12-installation/pictures/task-01-13.png)

![Скриншот 15](https://github.com/cachmc/netology_devops_homework/raw/main/07-kubernetes/12-installation/pictures/task-01-14.png)

![Скриншот 16](https://github.com/cachmc/netology_devops_homework/raw/main/07-kubernetes/12-installation/pictures/task-01-15.png)

![Скриншот 17](https://github.com/cachmc/netology_devops_homework/raw/main/07-kubernetes/12-installation/pictures/task-01-16.png)

</details>

<br>

## Настройка кластера K8s

*K8s* кластер настраивается при помощи *Kubespray*. Предварительно изменены значения несколько переменных *playbook'а* в файле `./inventory/netology/group_vars/k8s_cluster/addons.yml`

```bash
helm_enabled: true
...
ingress_nginx_enabled: true
ingress_nginx_host_network: true
```

<details>
<summary><b>Скриншоты</b></summary>

![Скриншот 18](https://github.com/cachmc/netology_devops_homework/raw/main/07-kubernetes/12-installation/pictures/task-02-00.png)

![Скриншот 19](https://github.com/cachmc/netology_devops_homework/raw/main/07-kubernetes/12-installation/pictures/task-02-01.png)

![Скриншот 20](https://github.com/cachmc/netology_devops_homework/raw/main/07-kubernetes/12-installation/pictures/task-02-02.png)

</details>

<br>

## Настройка Keepalived и Nginx Proxy

Для создания кластера высокой доступности на трех master nodes настроены *keepalived* и на отдельном сервере настроен *nginx* для проксирование внешнего трафика на *VIP*.

Для того чтобы добавить внешний *IP* *nginx proxy* сервера и пересобрать корневой сертификат K8s необходимо выполнить следующте действия

```bash
# Выгружаем когфигурацию kubeadm
kubectl -n kube-system get configmap kubeadm-config -o jsonpath='{.data.ClusterConfiguration}' > kubeadm.yaml

# В раздел 'apiServer' добавляем новый IP адрес

# Перещаем старый сертификат, чтобы k8s сгенерировал новый
mv /etc/kubernetes/pki/apiserver.{crt,key} ~

# Генерируем новые сертификат
kubeadm init phase certs apiserver --config kubeadm.yaml

# Перезапускаем kube-apiserver, я просто делал kill процессa

# Сохраняем новую когфигурацию kubeadm 
kubeadm init phase upload-config kubeadm --config kubeadm.yaml
```

<details>
<summary><b>Скриншоты</b></summary>

![Скриншот 21](https://github.com/cachmc/netology_devops_homework/raw/main/07-kubernetes/12-installation/pictures/task-03-00.png)

![Скриншот 22](https://github.com/cachmc/netology_devops_homework/raw/main/07-kubernetes/12-installation/pictures/task-03-01.png)

</details>

<br>

## P.S.

В идеале, чтобы уменьшить расходы на содержание кластера, нужно было поднять инфрастуктуры с одним внешним *IP* на *Nginx Proxy* (*develop-k8s-keepalived-1*).
Настройку кластера из внешней сети нужно было делать через *develop-k8s-keepalived-1* используя его как *bastion* сервер или запускать *playbooks* непосредственно с этого серевера.

## Последовательность выполнения комманд
```bash
cd ~/k8s-create-cluster/
git clone https://github.com/kubernetes-incubator/kubespray.git
cd ~/k8s-create-cluster/kubespray
cp -r ./inventory/sample/ ./inventory/netology
nano ./inventory/netology/group_vars/k8s_cluster/addons.yml
nano ansible.cfg

cd ~/k8s-create-cluster/terraform/vps
terraform init
terraform apply

cd ~/k8s-create-cluster/terraform/vms
terraform init
terraform apply

cd ~/k8s-create-cluster/kubespray
nano ./inventory/netology/group_vars/k8s_cluster/addons.yml
ansible-playbook -i inventory/netology/inventory.ini cluster.yml

cd ~/k8s-create-cluster/keepalived
ansible-playbook -i ../kubespray/inventory/netology/inventory.ini keepalived.yaml

kubectl -n kube-system get configmap kubeadm-config -o jsonpath='{.data.ClusterConfiguration}' > kubeadm.yaml
nano kubeadm.yaml
mv /etc/kubernetes/pki/apiserver.{crt,key} ~
kubeadm init phase certs apiserver --config kubeadm.yaml
kill -9 <kube-apiserver>
kubeadm init phase upload-config kubeadm --config kubeadm.yaml
```

<br>
<br>

## [Terraform Code](https://github.com/cachmc/netology_devops_homework/tree/main/07-kubernetes/12-installation/src/terraform)

## [Keepalived](https://github.com/cachmc/netology_devops_homework/tree/main/07-kubernetes/12-installation/src/keepalived)
