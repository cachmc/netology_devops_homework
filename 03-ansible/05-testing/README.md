# Домашнее задание к занятию 5 «Тестирование roles»

## Основная часть

### Molecule

![Скриншот 1](https://github.com/cachmc/netology_devops_homework/raw/main/03-ansible/05-testing/pictures/main/task-01-01.png)

![Скриншот 2](https://github.com/cachmc/netology_devops_homework/raw/main/03-ansible/05-testing/pictures/main/task-01-02.png)

![Скриншот 3](https://github.com/cachmc/netology_devops_homework/raw/main/03-ansible/05-testing/pictures/main/task-01-03.png)

![Скриншот 4](https://github.com/cachmc/netology_devops_homework/raw/main/03-ansible/05-testing/pictures/main/task-01-04.png)

![Скриншот 5](https://github.com/cachmc/netology_devops_homework/raw/main/03-ansible/05-testing/pictures/main/task-01-05.png)

![Скриншот 6](https://github.com/cachmc/netology_devops_homework/raw/main/03-ansible/05-testing/pictures/main/task-01-06.png)

![Скриншот 7](https://github.com/cachmc/netology_devops_homework/raw/main/03-ansible/05-testing/pictures/main/task-01-07.png)

![Скриншот 8](https://github.com/cachmc/netology_devops_homework/raw/main/03-ansible/05-testing/pictures/main/task-01-08.png)

![Скриншот 9](https://github.com/cachmc/netology_devops_homework/raw/main/03-ansible/05-testing/pictures/main/task-01-09.png)

![Скриншот 10](https://github.com/cachmc/netology_devops_homework/raw/main/03-ansible/05-testing/pictures/main/task-01-10.png)

![Скриншот 11](https://github.com/cachmc/netology_devops_homework/raw/main/03-ansible/05-testing/pictures/main/task-01-11.png)

![Скриншот 12](https://github.com/cachmc/netology_devops_homework/raw/main/03-ansible/05-testing/pictures/main/task-01-12.png)

<br>

### Tox

![Скриншот 13](https://github.com/cachmc/netology_devops_homework/raw/main/03-ansible/05-testing/pictures/main/task-02-00.png)

При настройках *tox* из репозитория задания получал ошибку как на скриншоте выше. Долгие попытки разобраться в проблеме и решить ее привели меня к выводу, что без заведения *issue* в проекте *ansible* не обойтись.
Думаю это за рамками домашнего задания. Перебпробовал разные версии и данная проблема встречалась только с *ansible-core2.10.17* + *python{3.8,3.9}*, в связке *ansible-core2.10.17* + *python3.7* проблема не воспроизводилась.
Хотя на сайте *ansible* заявлена поддержка *python{3.5-3.9}* для *ansible2.10* и *ansible3.x* (в которых как раз используется *ansible-core2.10.17*). Уже имеющегося *issue* с такой проблемой я не нашел, как и решения на просторах интернет.

Поэтому для тестирования я использовал *python3.8*, *python3.9*, *ansible4.0*, *ansible5.0* и *ansible6.0*

![Скриншот 14](https://github.com/cachmc/netology_devops_homework/raw/main/03-ansible/05-testing/pictures/main/task-02-01.png)

![Скриншот 15](https://github.com/cachmc/netology_devops_homework/raw/main/03-ansible/05-testing/pictures/main/task-02-02.png)

![Скриншот 16](https://github.com/cachmc/netology_devops_homework/raw/main/03-ansible/05-testing/pictures/main/task-02-03.png)

![Скриншот 17](https://github.com/cachmc/netology_devops_homework/raw/main/03-ansible/05-testing/pictures/main/task-02-04.png)

![Скриншот 18](https://github.com/cachmc/netology_devops_homework/raw/main/03-ansible/05-testing/pictures/main/task-02-05.png)

![Скриншот 19](https://github.com/cachmc/netology_devops_homework/raw/main/03-ansible/05-testing/pictures/main/task-02-06.png)

![Скриншот 20](https://github.com/cachmc/netology_devops_homework/raw/main/03-ansible/05-testing/pictures/main/task-02-07.png)

![Скриншот 21](https://github.com/cachmc/netology_devops_homework/raw/main/03-ansible/05-testing/pictures/main/task-02-08.png)

![Скриншот 22](https://github.com/cachmc/netology_devops_homework/raw/main/03-ansible/05-testing/pictures/main/task-02-09.png)

![Скриншот 23](https://github.com/cachmc/netology_devops_homework/raw/main/03-ansible/05-testing/pictures/main/task-02-10.png)

![Скриншот 24](https://github.com/cachmc/netology_devops_homework/raw/main/03-ansible/05-testing/pictures/main/task-02-11.png)

![Скриншот 25](https://github.com/cachmc/netology_devops_homework/raw/main/03-ansible/05-testing/pictures/main/task-02-12.png)

![Скриншот 26](https://github.com/cachmc/netology_devops_homework/raw/main/03-ansible/05-testing/pictures/main/task-02-13.png)

![Скриншот 27](https://github.com/cachmc/netology_devops_homework/raw/main/03-ansible/05-testing/pictures/main/task-02-14.png)

![Скриншот 28](https://github.com/cachmc/netology_devops_homework/raw/main/03-ansible/05-testing/pictures/main/task-02-15.png)

<br>
<br>

## Необязательная часть

### Сценарии для тестирования роли LightHouse

![Скриншот 29](https://github.com/cachmc/netology_devops_homework/raw/main/03-ansible/05-testing/pictures/optional/task-01-01.png)

![Скриншот 30](https://github.com/cachmc/netology_devops_homework/raw/main/03-ansible/05-testing/pictures/optional/task-01-02.png)

![Скриншот 31](https://github.com/cachmc/netology_devops_homework/raw/main/03-ansible/05-testing/pictures/optional/task-01-03.png)

![Скриншот 32](https://github.com/cachmc/netology_devops_homework/raw/main/03-ansible/05-testing/pictures/optional/task-01-04.png)

![Скриншот 33](https://github.com/cachmc/netology_devops_homework/raw/main/03-ansible/05-testing/pictures/optional/task-01-05.png)

![Скриншот 34](https://github.com/cachmc/netology_devops_homework/raw/main/03-ansible/05-testing/pictures/optional/task-01-06.png)

![Скриншот 35](https://github.com/cachmc/netology_devops_homework/raw/main/03-ansible/05-testing/pictures/optional/task-01-07.png)

![Скриншот 36](https://github.com/cachmc/netology_devops_homework/raw/main/03-ansible/05-testing/pictures/optional/task-01-08.png)

### Сценарий для тестирования всего стенда ClickHouse + Vector + LightHouse

![Скриншот 37](https://github.com/cachmc/netology_devops_homework/raw/main/03-ansible/05-testing/pictures/optional/task-02-01.png)

![Скриншот 38](https://github.com/cachmc/netology_devops_homework/raw/main/03-ansible/05-testing/pictures/optional/task-02-02.png)

![Скриншот 39](https://github.com/cachmc/netology_devops_homework/raw/main/03-ansible/05-testing/pictures/optional/task-02-03.png)

![Скриншот 40](https://github.com/cachmc/netology_devops_homework/raw/main/03-ansible/05-testing/pictures/optional/task-02-04.png)

![Скриншот 41](https://github.com/cachmc/netology_devops_homework/raw/main/03-ansible/05-testing/pictures/optional/task-02-05.png)

![Скриншот 42](https://github.com/cachmc/netology_devops_homework/raw/main/03-ansible/05-testing/pictures/optional/task-02-06.png)

![Скриншот 43](https://github.com/cachmc/netology_devops_homework/raw/main/03-ansible/05-testing/pictures/optional/task-02-07.png)

![Скриншот 44](https://github.com/cachmc/netology_devops_homework/raw/main/03-ansible/05-testing/pictures/optional/task-02-08.png)

![Скриншот 45](https://github.com/cachmc/netology_devops_homework/raw/main/03-ansible/05-testing/pictures/optional/task-02-09.png)

![Скриншот 46](https://github.com/cachmc/netology_devops_homework/raw/main/03-ansible/05-testing/pictures/optional/task-02-10.png)

![Скриншот 47](https://github.com/cachmc/netology_devops_homework/raw/main/03-ansible/05-testing/pictures/optional/task-02-11.png)

![Скриншот 48](https://github.com/cachmc/netology_devops_homework/raw/main/03-ansible/05-testing/pictures/optional/task-02-12.png)

<br>
<br>

# [Role Vector Code](https://github.com/cachmc/ansible-role-vector)

# [Role Vector 1.1.0](https://github.com/cachmc/ansible-role-vector/releases/tag/1.1.0)

# [Role Vector 1.1.1](https://github.com/cachmc/ansible-role-vector/releases/tag/1.1.1)

<br>

# [Role LightHouse Code](https://github.com/cachmc/ansible-role-lighthouse)

# [Role LightHouse 1.1.0](https://github.com/cachmc/ansible-role-lighthouse/releases/tag/1.1.0)
