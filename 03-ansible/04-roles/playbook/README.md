
# Playbook по развертыванию [ClickHouse](https://clickhouse.com/), [LightHouse](https://github.com/VKCOM/lighthouse) и [Vector](https://vector.dev/)

Данный playbook на основе ролей производит установку и настройку всех компонентов. А так же на хосте с LightHouse устанавливает и настраивает *nginx*.

|  Роль  |  Ссылка  |
|  :--  |  :--  |
|  *clickhouse*  |  https://github.com/AlexeySetevoi/ansible-clickhouse  |
|  *lighthouse*  |  https://github.com/cachmc/ansible-role-lighthouse  |
|  *vector*  |  https://github.com/cachmc/ansible-role-vector  |

<br>
<br>

## Шаблоны

- `nginx.conf.j2` - Модифицированный основной конфиг, без секции `server`.
- `nginx_lighthouse.conf.j2` - Секция `server` с 80 портом и директорией LightHouse, которая передается через переменную *lighthouse_install_path* роли *lighthouse*
