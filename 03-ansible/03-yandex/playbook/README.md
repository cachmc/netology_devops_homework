# Playbook по развертыванию [ClickHouse](https://clickhouse.com/), [LightHouse](https://github.com/VKCOM/lighthouse) и [Vector](https://vector.dev/)

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
	 - *lighthouse_path* - путь расположения файлов LightHouse
 - *group_vars/clickhouse/vars.yml*
	 - *clickhouse_version* - версия ClickHouse
	 - *clickhouse_packages* - список пакетов ClickHouse, которые необходимо установить
 - *group_vars/vector/vars.yml*
	 - *vector_version* - версия Vector

<br>
<br>

## Теги

 - *clickhouse* - запустит `play` по развертыванию CLickHouse
 - *lighthouse* - запустит `play` по развертыванию LightHouse
 - *nginx* - запустит `play` по установки и настройки Nginx на хосте с LightHouse
 - *vector* - запустит `play` по развертыванию Vector

<br>
<br>

## Шаблоны

 - *clickhouse*
	 - `clickhouse.xml.j2` - Модефицированный конфиг, открыает на прослушивание все адреса.
 - *nginx*
     - `nginx.conf.j2` - Модифицированный основной конфиг, без секции `server`.
	 - `nginx_lighthouse.conf.j2` - Секция `server` с 80 портом и директорией LightHouse. В него передается путь расположения файлов LightHouse из ["переменных"](#vars).
 - *vector*
	 - `vector.yaml.j2` - В него передаются внешний IP адрес хоста (из инвентори), имя БД и таблицы ClickHouse из ["переменных"](#vars) для записи рандомных логов как пример работы инсталяции.
