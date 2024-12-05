# Домашнее задание к занятию 10 «Jenkins»

## Основная часть

### Задание 1

![Скриншот 1](https://github.com/cachmc/netology_devops_homework/raw/main/04-ci/04-jenkins/pictures/main/task-1-0.png)

![Скриншот 2](https://github.com/cachmc/netology_devops_homework/raw/main/04-ci/04-jenkins/pictures/main/task-1-1.png)

![Скриншот 3](https://github.com/cachmc/netology_devops_homework/raw/main/04-ci/04-jenkins/pictures/main/task-1-2.png)

![Скриншот 4](https://github.com/cachmc/netology_devops_homework/raw/main/04-ci/04-jenkins/pictures/main/task-1-3.png)

![Скриншот 5](https://github.com/cachmc/netology_devops_homework/raw/main/04-ci/04-jenkins/pictures/main/task-1-4.png)

![Скриншот 6](https://github.com/cachmc/netology_devops_homework/raw/main/04-ci/04-jenkins/pictures/main/task-1-5.png)

![Скриншот 7](https://github.com/cachmc/netology_devops_homework/raw/main/04-ci/04-jenkins/pictures/main/task-1-6.png)

![Скриншот 8](https://github.com/cachmc/netology_devops_homework/raw/main/04-ci/04-jenkins/pictures/main/task-1-7.png)

![Скриншот 9](https://github.com/cachmc/netology_devops_homework/raw/main/04-ci/04-jenkins/pictures/main/task-1-8.png)

![Скриншот 10](https://github.com/cachmc/netology_devops_homework/raw/main/04-ci/04-jenkins/pictures/main/task-1-9.png)

<br>

### Задание 2

![Скриншот 11](https://github.com/cachmc/netology_devops_homework/raw/main/04-ci/04-jenkins/pictures/main/task-2-0.png)

![Скриншот 12](https://github.com/cachmc/netology_devops_homework/raw/main/04-ci/04-jenkins/pictures/main/task-2-1.png)

![Скриншот 13](https://github.com/cachmc/netology_devops_homework/raw/main/04-ci/04-jenkins/pictures/main/task-2-2.png)

![Скриншот 14](https://github.com/cachmc/netology_devops_homework/raw/main/04-ci/04-jenkins/pictures/main/task-2-3.png)

![Скриншот 15](https://github.com/cachmc/netology_devops_homework/raw/main/04-ci/04-jenkins/pictures/main/task-2-4.png)

![Скриншот 16](https://github.com/cachmc/netology_devops_homework/raw/main/04-ci/04-jenkins/pictures/main/task-2-5.png)

![Скриншот 17](https://github.com/cachmc/netology_devops_homework/raw/main/04-ci/04-jenkins/pictures/main/task-2-6.png)

![Скриншот 18](https://github.com/cachmc/netology_devops_homework/raw/main/04-ci/04-jenkins/pictures/main/task-2-7.png)

![Скриншот 19](https://github.com/cachmc/netology_devops_homework/raw/main/04-ci/04-jenkins/pictures/main/task-2-8.png)

<br>

### Задание 3

[Jenkinsfile](https://github.com/cachmc/netology_devops_homework/tree/main/04-ci/04-jenkins/src/Jenkinsfile)

<br>

### Задание 4

![Скриншот 20](https://github.com/cachmc/netology_devops_homework/raw/main/04-ci/04-jenkins/pictures/main/task-4-00.png)

![Скриншот 21](https://github.com/cachmc/netology_devops_homework/raw/main/04-ci/04-jenkins/pictures/main/task-4-01.png)

![Скриншот 22](https://github.com/cachmc/netology_devops_homework/raw/main/04-ci/04-jenkins/pictures/main/task-4-02.png)

![Скриншот 23](https://github.com/cachmc/netology_devops_homework/raw/main/04-ci/04-jenkins/pictures/main/task-4-03.png)

![Скриншот 24](https://github.com/cachmc/netology_devops_homework/raw/main/04-ci/04-jenkins/pictures/main/task-4-04.png)

![Скриншот 25](https://github.com/cachmc/netology_devops_homework/raw/main/04-ci/04-jenkins/pictures/main/task-4-05.png)

![Скриншот 26](https://github.com/cachmc/netology_devops_homework/raw/main/04-ci/04-jenkins/pictures/main/task-4-06.png)

![Скриншот 27](https://github.com/cachmc/netology_devops_homework/raw/main/04-ci/04-jenkins/pictures/main/task-4-07.png)

![Скриншот 28](https://github.com/cachmc/netology_devops_homework/raw/main/04-ci/04-jenkins/pictures/main/task-4-08.png)

![Скриншот 29](https://github.com/cachmc/netology_devops_homework/raw/main/04-ci/04-jenkins/pictures/main/task-4-09.png)

![Скриншот 30](https://github.com/cachmc/netology_devops_homework/raw/main/04-ci/04-jenkins/pictures/main/task-4-10.png)

<br>

### Задание 5

![Скриншот 31](https://github.com/cachmc/netology_devops_homework/raw/main/04-ci/04-jenkins/pictures/main/task-5-0.png)

![Скриншот 32](https://github.com/cachmc/netology_devops_homework/raw/main/04-ci/04-jenkins/pictures/main/task-5-1.png)

<br>

### Задание 6

Я понял данное задание так:
- если параметр **не указан** (это **дефолтное значение**), он равен **False**, так как он имеет булевый тип, и джоба запускается с флагами `--check` и `--diff` (прорверяем работу плейбука если **это не PROD**)
- если параметр **указан** , он равен **True**, так как он имеет булевый тип, и джоба запускается без флагов `--check` и `--diff` (применяем плейбук если **это PROD**)

![Скриншот 33](https://github.com/cachmc/netology_devops_homework/raw/main/04-ci/04-jenkins/pictures/main/task-6-0.png)

![Скриншот 34](https://github.com/cachmc/netology_devops_homework/raw/main/04-ci/04-jenkins/pictures/main/task-6-1.png)

![Скриншот 35](https://github.com/cachmc/netology_devops_homework/raw/main/04-ci/04-jenkins/pictures/main/task-6-2.png)

![Скриншот 36](https://github.com/cachmc/netology_devops_homework/raw/main/04-ci/04-jenkins/pictures/main/task-6-3.png)

![Скриншот 37](https://github.com/cachmc/netology_devops_homework/raw/main/04-ci/04-jenkins/pictures/main/task-6-4.png)

![Скриншот 38](https://github.com/cachmc/netology_devops_homework/raw/main/04-ci/04-jenkins/pictures/main/task-6-5.png)

<br>

### Задание 7

[ScriptedJenkinsfile](https://github.com/cachmc/netology_devops_homework/tree/main/04-ci/04-jenkins/src/ScriptedJenkinsfile)

<br>

### Задание 8

[Role Vector Code](https://github.com/cachmc/ansible-role-vector)

<br>
<br>


## Необязательная часть

### Задание 1

![Скриншот 39](https://github.com/cachmc/netology_devops_homework/raw/main/04-ci/04-jenkins/pictures/optional/task-1-0.png)

[AllJobFailure](https://github.com/cachmc/netology_devops_homework/tree/main/04-ci/04-jenkins/src/AllJobFailure.groovy)

<br>

### Задание 2

![Скриншот 40](https://github.com/cachmc/netology_devops_homework/raw/main/04-ci/04-jenkins/pictures/optional/task-2-0.png)

![Скриншот 41](https://github.com/cachmc/netology_devops_homework/raw/main/04-ci/04-jenkins/pictures/optional/task-2-1.png)


#### Groovy скрипт
[CreateInfrastructureJava](https://github.com/cachmc/netology_devops_homework/tree/main/04-ci/04-jenkins/src/CreateInfrastructureJava.groovy)


#### Репозиторий с terraform кодом и ansible плейбуками
[netology-jenkins-terraform-ansible](https://github.com/cachmc/netology-jenkins-terraform-ansible)


#### Отчет работы pipeline
[jenkins_job_log](https://github.com/cachmc/netology_devops_homework/tree/main/04-ci/04-jenkins/src/jenkins_job_log.txt)

<br>
<br>

# [Terraform](https://github.com/cachmc/netology_devops_homework/tree/main/04-ci/04-jenkins/src/terraform)

# [Playbook](https://github.com/cachmc/netology_devops_homework/tree/main/04-ci/04-jenkins/src/playbook)
