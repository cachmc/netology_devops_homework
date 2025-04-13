# ansible-vector

Производит установку и настройку кластера [Redis](https://redis.io/)

<br>
<br>

<a  name="vars"></a>

## Переменные

 - Вы можете указать номера портов для Master и Slave нод
```yaml
redis_master_port: 7000
redis_slave_port: 7001
```

<br>
<br>

## Теги

|  Название  |  Описание  |
|  :--:  |  :---  |
| *redis*  |  Позволяет запустить целиком роль в playbook  |
| *cluster*  |  Запускает проверку и инициализацию кластера  |
