# Playbook по развертыванию [ClickHouse](https://clickhouse.com/) и [Vector](https://vector.dev/)

Данный playbook скачивает все необходимые дистрибутивы, производит установку и первоначальную настройку сервисов и их запуск.

<br>
<br>

<a  name="vars"></a>

## Переменные

 - *group_vars/all/vars.yml*
	 - *ansible_ssh_user* - пользователь для подключения по ssh
	 - *ansible_ssh_private_key_file* - ключ для подключения по ssh
	 - *clickhouse_db_name* - название БД, которая будет создана в ClickHouse
	 - *clickhouse_table_name* - название таблицы в БД
 - *group_vars/clickhouse/vars.yml*
	 - *clickhouse_version* - версия ClickHouse
	 - *clickhouse_packages* - список пакетов ClickHouse, которые необходимо установить
 - *group_vars/vector/vars.yml*
	 - *vector_version* - версия Vector

<br>
<br>

## Теги

 - *clickhouse* - запустит `play` по развертыванию CLickHouse
 - *vector* - запустит `play` по развертыванию Vector

<br>
<br>

## Шаблоны

Плейбук использует один шаблон для формирования конфигурационного файла `vector.yaml` В него передаются имя БД и таблицы в ClickHouse из ["переменных"](#vars) для записи рандомных логов как пример работы инсталяции.
