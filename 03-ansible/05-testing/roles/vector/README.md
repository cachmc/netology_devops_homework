# ansible-vector

Производит установку и настройку утилиты [Vector](https://vector.dev/)

<br>
<br>

<a  name="vars"></a>

## Переменные

 - Вы можете указать версию пакета *Vector*
```yaml
vector_version: "0.42.0"
```

<br>

 - Вы можете создать любое количество конфигурационных файлов *Vector*
```yaml
vector_configs_add:
  default: "{{ lookup('template', ./templates/default.yaml.j2') }}"
  clickhouse: "{{ lookup('template', ./templates/clickhouse.yaml.j2') }}"
  zabbix: "{{ lookup('template', ./templates/zabbix.yaml.j2') }}"
```
Ключ это название будущего конфигурационного файла, а значение - функция которая формирует содержимое конфигурационного файла из *Jinja* шаблона по указанному пути.

<br>

 - Вы можете удалить уже созданные ранее конфигурационные файлы *Vector*
```yaml
vector_configs_del:
  - default
  - clickhouse
  - zabbix
  ...
```

<br>
<br>

## Теги

|  Название  |  Описание  |
|  :--:  |  :---  |
| *vector*  |  Позволяет запустить целиком роль в playbook  |
