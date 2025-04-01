# Домашнее задание к занятию «Безопасность в облачных провайдерах»

<details>
<summary><b>Описание задания</b></summary>

Используя конфигурации, выполненные в рамках предыдущих домашних заданий, нужно добавить возможность шифрования бакета.

---
## Задание 1. Yandex Cloud   

1. С помощью ключа в KMS необходимо зашифровать содержимое бакета:

 - создать ключ в KMS;
 - с помощью ключа зашифровать содержимое бакета, созданного ранее.
2. (Выполняется не в Terraform)* Создать статический сайт в Object Storage c собственным публичным адресом и сделать доступным по HTTPS:

 - создать сертификат;
 - создать статическую страницу в Object Storage и применить сертификат HTTPS;
 - в качестве результата предоставить скриншот на страницу с сертификатом в заголовке (замочек).

Полезные документы:

- [Настройка HTTPS статичного сайта](https://cloud.yandex.ru/docs/storage/operations/hosting/certificate).
- [Object Storage bucket](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/storage_bucket).
- [KMS key](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/kms_symmetric_key).

--- 
## Задание 2*. AWS (задание со звёздочкой)

Это необязательное задание. Его выполнение не влияет на получение зачёта по домашней работе.

**Что нужно сделать**

1. С помощью роли IAM записать файлы ЕС2 в S3-бакет:
 - создать роль в IAM для возможности записи в S3 бакет;
 - применить роль к ЕС2-инстансу;
 - с помощью bootstrap-скрипта записать в бакет файл веб-страницы.
2. Организация шифрования содержимого S3-бакета:

 - используя конфигурации, выполненные в домашнем задании из предыдущего занятия, добавить к созданному ранее бакету S3 возможность шифрования Server-Side, используя общий ключ;
 - включить шифрование SSE-S3 бакету S3 для шифрования всех вновь добавляемых объектов в этот бакет.

3. *Создание сертификата SSL и применение его к ALB:

 - создать сертификат с подтверждением по email;
 - сделать запись в Route53 на собственный поддомен, указав адрес LB;
 - применить к HTTPS-запросам на LB созданный ранее сертификат.

Resource Terraform:

- [IAM Role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role).
- [AWS KMS](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key).
- [S3 encrypt with KMS key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_object#encrypting-with-kms-key).

Пример bootstrap-скрипта:

```
#!/bin/bash
yum install httpd -y
service httpd start
chkconfig httpd on
cd /var/www/html
echo "<html><h1>My cool web-server</h1></html>" > index.html
aws s3 mb s3://mysuperbacketname2021
aws s3 cp index.html s3://mysuperbacketname2021
```

### Правила приёма работы

Домашняя работа оформляется в своём Git репозитории в файле README.md. Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.
Файл README.md должен содержать скриншоты вывода необходимых команд, а также скриншоты результатов.
Репозиторий должен содержать тексты манифестов или ссылки на них в файле README.md.

</details>

<br>

## Задача 1

![Скриншот 1](https://github.com/cachmc/netology_devops_homework/raw/main/08-cloud/03-security/pictures/task-01-00.png)

![Скриншот 2](https://github.com/cachmc/netology_devops_homework/raw/main/08-cloud/03-security/pictures/task-01-01.png)

![Скриншот 3](https://github.com/cachmc/netology_devops_homework/raw/main/08-cloud/03-security/pictures/task-01-02.png)

![Скриншот 4](https://github.com/cachmc/netology_devops_homework/raw/main/08-cloud/03-security/pictures/task-01-03.png)

## Задача 2

![Скриншот 5](https://github.com/cachmc/netology_devops_homework/raw/main/08-cloud/03-security/pictures/task-02-00.png)

![Скриншот 6](https://github.com/cachmc/netology_devops_homework/raw/main/08-cloud/03-security/pictures/task-02-01.png)

![Скриншот 7](https://github.com/cachmc/netology_devops_homework/raw/main/08-cloud/03-security/pictures/task-02-02.png)

![Скриншот 8](https://github.com/cachmc/netology_devops_homework/raw/main/08-cloud/03-security/pictures/task-02-03.png)

![Скриншот 9](https://github.com/cachmc/netology_devops_homework/raw/main/08-cloud/03-security/pictures/task-02-04.png)

![Скриншот 10](https://github.com/cachmc/netology_devops_homework/raw/main/08-cloud/03-security/pictures/task-02-05.png)

![Скриншот 11](https://github.com/cachmc/netology_devops_homework/raw/main/08-cloud/03-security/pictures/task-02-06.png)

![Скриншот 12](https://github.com/cachmc/netology_devops_homework/raw/main/08-cloud/03-security/pictures/task-02-07.png)

![Скриншот 13](https://github.com/cachmc/netology_devops_homework/raw/main/08-cloud/03-security/pictures/task-02-08.png)

![Скриншот 14](https://github.com/cachmc/netology_devops_homework/raw/main/08-cloud/03-security/pictures/task-02-09.png)

![Скриншот 15](https://github.com/cachmc/netology_devops_homework/raw/main/08-cloud/03-security/pictures/task-02-10.png)

<br>
<br>

## [Terraform code](https://github.com/cachmc/netology_devops_homework/tree/main/08-cloud/03-security/src/terraform)
