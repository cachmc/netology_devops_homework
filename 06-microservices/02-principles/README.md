# Домашнее задание к занятию «Микросервисы: принципы»

<details>
<summary><b>Описание задания</b></summary>

Вы работаете в крупной компании, которая строит систему на основе микросервисной архитектуры.
Вам как DevOps-специалисту необходимо выдвинуть предложение по организации инфраструктуры для разработки и эксплуатации.

## Задача 1: API Gateway 

Предложите решение для обеспечения реализации API Gateway. Составьте сравнительную таблицу возможностей различных программных решений. На основе таблицы сделайте выбор решения.

Решение должно соответствовать следующим требованиям:
- маршрутизация запросов к нужному сервису на основе конфигурации,
- возможность проверки аутентификационной информации в запросах,
- обеспечение терминации HTTPS.

Обоснуйте свой выбор.

## Задача 2: Брокер сообщений

Составьте таблицу возможностей различных брокеров сообщений. На основе таблицы сделайте обоснованный выбор решения.

Решение должно соответствовать следующим требованиям:
- поддержка кластеризации для обеспечения надёжности,
- хранение сообщений на диске в процессе доставки,
- высокая скорость работы,
- поддержка различных форматов сообщений,
- разделение прав доступа к различным потокам сообщений,
- простота эксплуатации.

Обоснуйте свой выбор.

## Задача 3: API Gateway * (необязательная)

### Есть три сервиса:

**minio**
- хранит загруженные файлы в бакете images,
- S3 протокол,

**uploader**
- принимает файл, если картинка сжимает и загружает его в minio,
- POST /v1/upload,

**security**
- регистрация пользователя POST /v1/user,
- получение информации о пользователе GET /v1/user,
- логин пользователя POST /v1/token,
- проверка токена GET /v1/token/validation.

### Необходимо воспользоваться любым балансировщиком и сделать API Gateway:

**POST /v1/register**
1. Анонимный доступ.
2. Запрос направляется в сервис security POST /v1/user.

**POST /v1/token**
1. Анонимный доступ.
2. Запрос направляется в сервис security POST /v1/token.

**GET /v1/user**
1. Проверка токена. Токен ожидается в заголовке Authorization. Токен проверяется через вызов сервиса security GET /v1/token/validation/.
2. Запрос направляется в сервис security GET /v1/user.

**POST /v1/upload**
1. Проверка токена. Токен ожидается в заголовке Authorization. Токен проверяется через вызов сервиса security GET /v1/token/validation/.
2. Запрос направляется в сервис uploader POST /v1/upload.

**GET /v1/user/{image}**
1. Проверка токена. Токен ожидается в заголовке Authorization. Токен проверяется через вызов сервиса security GET /v1/token/validation/.
2. Запрос направляется в сервис minio GET /images/{image}.

### Ожидаемый результат

Результатом выполнения задачи должен быть docker compose файл, запустив который можно локально выполнить следующие команды с успешным результатом.
Предполагается, что для реализации API Gateway будет написан конфиг для NGinx или другого балансировщика нагрузки, который будет запущен как сервис через docker-compose и будет обеспечивать балансировку и проверку аутентификации входящих запросов.
Авторизация
curl -X POST -H 'Content-Type: application/json' -d '{"login":"bob", "password":"qwe123"}' http://localhost/token

**Загрузка файла**

curl -X POST -H 'Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJib2IifQ.hiMVLmssoTsy1MqbmIoviDeFPvo-nCd92d4UFiN2O2I' -H 'Content-Type: octet/stream' --data-binary @yourfilename.jpg http://localhost/upload

**Получение файла**
curl -X GET http://localhost/images/4e6df220-295e-4231-82bc-45e4b1484430.jpg

---

#### [Дополнительные материалы: как запускать, как тестировать, как проверить](https://github.com/netology-code/devkub-homeworks/tree/main/11-microservices-02-principles)

---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---

</details>

<br>

## Задача 1

|  Продукт  |  Маршрутизация запросов  |  Проверка аутентификации |  Терминация HTTPS  |
|  :----  |  :----:  |  :----:  |  :----:  |
|  **Amazon API Gateway**  |  :ballot_box_with_check:  |  :ballot_box_with_check:  |  :ballot_box_with_check:  |
|  **Apache APISIX**  |  :ballot_box_with_check:  |  :ballot_box_with_check:  |  :ballot_box_with_check:  |
|  **Kong Gateway**  |  :ballot_box_with_check:  |  :ballot_box_with_check:  |  :ballot_box_with_check:  |
|  **Nginx**  |  :ballot_box_with_check:  |  :ballot_box_with_check:  |  :ballot_box_with_check:  |
|  **Tyk**  |  :ballot_box_with_check:  |  :ballot_box_with_check:  |  :ballot_box_with_check:  |

Из приведенных выше вариантов заданным критериям отвечают все продукты. Поэтому я бы предоставил бизнесу информацию о различиях данных продуктов и попросил бы их конкретизиовать потребности, а так же уточнил бы архитектуру будущего проекта и на основании полученной информации предложил бы наиболее подходящий вариант.

Например:
1. В каком облачном провайдере планируется разворачивать проект или это будут дедикейтед сервера?
2. Это должно быть вендорное решение или open source проект?
3. Есть ли в планах в будущем использовать GraphQL?
4. Если это open source будет не лишним проанализировать развитость комюнити проекта и оценить его вклад в развитие (плагины).
5. Не маловажный фактором при принятии решения это поддерживаемый функционал и удобство мониторинга данного продукта.
6. Простота в настройке и последующем сопровождении, а также масштабируемость того или иного решения.

## Задача 2

|  Продукт  |  Кластеризация  |  Хранение на диске |  Скорость работы  |  Различные форматы сообщений  |  Ролевая модель  |  Сложность экплуатации  |
|  :----  |  :----:  |  :----:  |  :----:  |  :----:  |  :----:  |  :----:  |
|  **Artemis**  |  :ballot_box_with_check:  |  :ballot_box_with_check:  |  <span style="color:orange">Высокая</span> |  :ballot_box_with_check:  |  :ballot_box_with_check:  |  <span style="color:yellow">Средняя</span>  |
|  **Kafka**  |  :ballot_box_with_check:  |  :ballot_box_with_check:  |  <span style="color:red">Очень высокая</span>  |  :ballot_box_with_check:  |  :ballot_box_with_check:  |  <span style="color:orange">Высокая</span>  |
|  **RabbitMQ**  |  :ballot_box_with_check:  |  :ballot_box_with_check:  |  <span style="color:orange">Высокая</span>  |  :ballot_box_with_check:  |  :ballot_box_with_check:  |  <span style="color:yellow">Средняя</span>  |

Исходя из результатов анализа несокльких популярных брокеров сообщений я бы рекомендомал использовать Artemis так как он максимально отвечает всем требованиям бизнеса и обеспечивает высокую производительность и масштабируемость благодаря полностью асинхронной архитектуре.

В случае, если бизнесу нужен брокер, который сможет быстро обрабатывать ОЧЕНЬ большой поток сообщений, выбор падет в сторону Kafka. Но бизнесу нужно будет учитывать, что расходы на такой брокер будут существенно выше, т.к. понадобятся более кфалифицированные специалисты для его сопровождения и, из личного опыта, для поднятия действительно быстрого и надежного кластера нужно довольно много серверных ресурсов.

## Задача 3

> Для решения задачи я брал за источник правды комаанды из раздел `Ожидаемый результат` в тех случаех где они имели разногласия с описаниям API методов из раздела `Необходимо воспользоваться любым балансировщиком и сделать API Gateway`

<br>

Перед тем как написать конфиг для "API Gateway Nginx", внес слшедующие изменения в проект:

1. Добавил в файл `requirements.txt` несколько бибилиотек, чтобы запустился контейнер `security`

```
jinja2==3.0.3
itsdangerous==2.0.1
werkzeug==2.0.3
```

2. В файле `server.py` проекта `security` внес изменения, а именно добавил код возврпата 401 в случае если передан не действительный или просроченный токен. Это нужно для корректной работы процесса проверки доступа "API Gateway" при загрузке файлов в бакет.

```py
    except jwt.ExpiredSignatureError:
        return 'Signature expired. Please log in again.', 401
    except jwt.InvalidTokenError:
        return 'Invalid token. Please log in again.', 401
```

3. Изменил команду в `docker-compose.yaml` для контейнера `createbuckets`. Заменил `mc policy` на `mc anonymous`, что бы "починить" процесс настройки доступа для скачивания файлов из бакета без авторизации.

```yaml
    entrypoint: > 
      /bin/sh -c "      
      /usr/bin/mc config host add storage http://storage:9000 ${Storage_AccessKey-STORAGE_ACCESS_KEY} ${Storage_Secret-STORAGE_SECRET_KEY} &&
      /usr/bin/mc mb --ignore-existing storage/${Storage_Bucket:-data} &&
      /usr/bin/mc anonymous set download storage/${Storage_Bucket:-data} &&
      exit 0;
```

<br>

Конфигурация Nginx

```nginx
worker_processes 1;

events {
    worker_connections  1024;
}

http {
    include           mime.types;
    default_type      application/octet-stream;
    sendfile          on;
    keepalive_timeout 65;
    

    upstream register_POST {
        server security:3000;
    }

    upstream security {
        server security:3000;
    }
    
    upstream user_GET {
        server security:3000;
    }

    upstream uploader {
        server uploader:3000;
    }

    upstream storage {
        server storage:9000;
    }

    server {
        listen       8080;
        server_name  localhost;

        location = /auth {
            internal;
            proxy_pass http://security/v1/token/validation;
        }

        location = /status/security {
            proxy_pass http://security/status;
        }

        location = /status/uploader {
            proxy_pass http://uploader/status;
        }

        location /register {
            proxy_pass http://register_$request_method/v1/user;
        }

        location /token {
            proxy_pass http://security/v1/token;
        }

        location /user {
            auth_request /auth;
            proxy_pass http://user_$request_method/v1/user;
        }

        location /upload {
            auth_request /auth;
            proxy_pass http://uploader/v1/upload;
        }

        location ~ ^/images/(?<image_name>.+)$ {
            proxy_pass http://storage/data/$image_name;
        }
    }
}
```

<br>

В результате первой командой я передаю не корректный токен при загрузке файла в бакет, дабы показать что "API Gateway" отклоняет такие запросы.

![Скриншот 1](https://github.com/cachmc/netology_devops_homework/raw/main/06-microservices/02-principles/pictures/task-03-00.png)

<br>
<br>

## [Code](https://github.com/cachmc/netology_devops_homework/tree/main/06-microservices/02-principles/src)
