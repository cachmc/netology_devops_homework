# Домашнее задание к занятию «Управляющие конструкции в коде Terraform»

## Задача 1

![Скриншот 1](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/03-control-structures/pictures/task-1.png)



## Задача 4

![Скриншот 2](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/03-control-structures/pictures/task-4.png)



## Задача 5

Мне показалось, что выводить в *output* списки по отдельности (для *count* один, для *for_each* другой) противоречит заданию, так как речь там идет об одном списке.

> который отобразит ВМ из ваших ресурсов count и for_each в виде **списка словарей**

![Скриншот 3](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/03-control-structures/pictures/task-5.png)



## Задача 6

После проверки результатов я обнаружил, что если создать инстансы с нуля, то все прекрасно, в *.tfstate* файле нет про них информации, *terraform* формирует из шаблона `hosts.tftpl` файл который отличается от того что на хосте и обновляет `hosts.ini`. 
Но если в *.tfstate* уже есть информация об инстансах и мы только меняем их характеристики (например удаляем внешний IP адрес или меняем размер оперативной памяти), то *terraform*, при обработке блока *local_file*, не  анализирует предстоящие изменения в *.tfstate*, а работает с тем что там уже есть, а информация о хостах там такая же как и была раньше. На основании этих данных он формирует файл из шаблона, проверяет результат с файлом на локальном хосте и не видит отличий.  Тем самым после применения изменений мы **не** получаем новые данные в `hosts.ini` Но если сделать *apply* второй раз подряд, то *terraform* видит новые данные виртуалок в *.tfstate* и формирует новый файл `hosts.ini` на локальном хосте.

Сказать однозначно почему так происходит я не могу, вероятно такое поведение заложено в логике самого *terraform*'а и это не баг а фича.

Просмотрев документацию по ресурсу *local_file* я не увидел ни каких параметров, которые могли бы изменить это поведение.

На просторах интернета, комьюнити предлагает использовать ресурс *template_file* вместо *local_file*, но насколько я понял в нашей ситуации он нам не подходит, так как данные сформированные из шаблона остаются в переменной ресурса, а нам нужен файл на локальном хосте.

Немного поэксперемнтировав я нашел "костыльное" решение , но вполне рабочее. Добавил в шаблон инвентарного файла закомментированную строку с функцией `${timestamp()}`, тем самым при каждом запуске кода файл на локальном хосте всегда отличается от того, что получилось у *terraform* при обработке шаблона и `hosts.ini` всегда обновляется. При этом, так как эта строка в инвентори закомментированна на сам инвентори она ни как не влияет.

Очень хотел бы **получить от Вас обратную связь**, вероятно есть способ более правильный и я просто не нашел его. Заранее спасибо!

Ниже скриншоты как это работает.

P.S. *depends_on* в *local_file* не дал ни какого результата.

![Скриншот 4](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/03-control-structures/pictures/task-6-1.png)

![Скриншот 5](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/03-control-structures/pictures/task-6-2.png)

![Скриншот 6](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/03-control-structures/pictures/task-6-3.png)

![Скриншот 7](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/03-control-structures/pictures/task-6-4.png)



## Задача 7

```
{ network_id = local.vpc.network_id, subnet_ids = [ for i in local.vpc.subnet_ids : i if i != local.vpc.subnet_ids[2] ], subnet_zones = [ for i in local.vpc.subnet_zones : i if i != local.vpc.subnet_zones[2] ]}
```



## Задача 8

Было допущены две синтаксические ошибки:
1. Фигурная скобка `}`, которая должна была "закрывать" выражение в значение параметра `ansible_host`, "убежала" в конец интерполированной строки. 
2. В ключе `"platform_id"` присутствовал лишний символ, пробел в конце названия ключа, что приводило к ошибке. Terraform не мог найти такой ключ в карте.
 
Изначальный вариант
```
[webservers]
%{~ for i in webservers ~}
${i["name"]} ansible_host=${i["network_interface"][0]["nat_ip_address"] platform_id=${i["platform_id "]}}
%{~ endfor ~}
```

Исправленный вариант
```
[webservers]
%{~ for i in webservers ~}
${i["name"]} ansible_host=${i["network_interface"][0]["nat_ip_address"]} platform_id=${i["platform_id"]}
%{~ endfor ~}
```

# [Terraform Code](https://github.com/cachmc/netology_devops_homework/tree/main/02-terraform/03-control-structures/src)
