# Домашнее задание к занятию 4 «Работа с roles»

## Предистория

При использовании роли [clickhouse](https://github.com/AlexeySetevoi/ansible-clickhouse) обнаружил на своей инсталяции проблему:

**Версия OS**: Ubuntu-20.04
**Версия Ansible**: 2.13.13

В процессе работы плейбука получил вот такую ошибку:

![Скриншот 1](https://github.com/cachmc/netology_devops_homework/raw/main/03-ansible/04-roles/pictures/task-1-1.png)

Нашел в коде роли нужную таску, увидел что там стоит параметр `disable_gpg_check: true`, но он почему-то не отрабатывает.

![Скриншот 2](https://github.com/cachmc/netology_devops_homework/raw/main/03-ansible/04-roles/pictures/task-1-2.png)

Пошел гуглить и выяснил что это бага в модуле `dnf` и по ней есть [issue](https://github.com/ansible/ansible/issues/80110) в *github* в проекте *ansible*. Проблема по этому *issue* была исправлена, но похоже патч в версии новее, чем установлен у меня *ansible*.

**Дата создания issue**: Feb 28, 2023
**Релиз версии *ansible* 2.13**: May 23, 2022

![Скриншот 3](https://github.com/cachmc/netology_devops_homework/raw/main/03-ansible/04-roles/pictures/task-1-3.png)

Решил проблему передав в --extra-vars `ansible_pkg_mgr=yum`. У *yum* модуля нет этого бага в данной версии *ansible*.

<br>
<br>

## Работа плейбука

![Скриншот 4](https://github.com/cachmc/netology_devops_homework/raw/main/03-ansible/04-roles/pictures/task-2-1.png)

![Скриншот 5](https://github.com/cachmc/netology_devops_homework/raw/main/03-ansible/04-roles/pictures/task-2-2.png)

![Скриншот 6](https://github.com/cachmc/netology_devops_homework/raw/main/03-ansible/04-roles/pictures/task-2-3.png)

![Скриншот 7](https://github.com/cachmc/netology_devops_homework/raw/main/03-ansible/04-roles/pictures/task-2-4.png)

<br>
<br>

# [Playbook](https://github.com/cachmc/netology_devops_homework/tree/main/03-ansible/04-roles/playbook)

# [Role LightHouse](https://github.com/cachmc/ansible-role-lighthouse)

# [Role Vector](https://github.com/cachmc/ansible-role-vector)

<br>

# [Terraform](https://github.com/cachmc/netology_devops_homework/tree/main/03-ansible/04-roles/terraform)

Для развертывания серверов в Yandex Cloud.
