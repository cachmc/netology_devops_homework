# Домашнее задание к занятию «Компоненты Kubernetes»

<details>
<summary><b>Описание задания</b></summary>

### Цель задания

Рассчитать требования к кластеру под проект

------

### Инструменты и дополнительные материалы, которые пригодятся для выполнения задания:

- [Considerations for large clusters](https://kubernetes.io/docs/setup/best-practices/cluster-large/),
- [Architecting Kubernetes clusters — choosing a worker node size](https://learnk8s.io/kubernetes-node-size).

------

### Задание. Необходимо определить требуемые ресурсы
Известно, что проекту нужны база данных, система кеширования, а само приложение состоит из бекенда и фронтенда. Опишите, какие ресурсы нужны, если известно:

1. Необходимо упаковать приложение в чарт для деплоя в разные окружения. 
2. База данных должна быть отказоустойчивой. Потребляет 4 ГБ ОЗУ в работе, 1 ядро. 3 копии. 
3. Кеш должен быть отказоустойчивый. Потребляет 4 ГБ ОЗУ в работе, 1 ядро. 3 копии. 
4. Фронтенд обрабатывает внешние запросы быстро, отдавая статику. Потребляет не более 50 МБ ОЗУ на каждый экземпляр, 0.2 ядра. 5 копий. 
5. Бекенд потребляет 600 МБ ОЗУ и по 1 ядру на копию. 10 копий.

----

### Правила приёма работы

1. Домашняя работа оформляется в своем Git-репозитории в файле README.md. Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.
2. Сначала сделайте расчёт всех необходимых ресурсов.
3. Затем прикиньте количество рабочих нод, которые справятся с такой нагрузкой.
4. Добавьте к полученным цифрам запас, который учитывает выход из строя как минимум одной ноды. 
5. Добавьте служебные ресурсы к нодам. Помните, что для разных типов нод требовния к ресурсам разные. 
6. В результате должно быть указано количество нод и их параметры.

</details>

<br>

## Требования

Суммарные требования нашего сервиса выглядят следующим образом:

- БД - (_1CPU_ + _4Gb_) x 3 = _3CPU_ + _12Gb_
- Система кеширования - (_1CPU_ + _4Gb_) x 3 = _3CPU_ + _12Gb_
- Frontend - (_0,2CPU_ + _0,05Gb_) x 5 = _1CPU_ + _0,25Gb_
- Backend - (_1CPU_ + _0,6Gb_) x 10 = _10CPU_ + _6Gb_

Суммарное потребление ресурсов - _17CPU_ + _30.25Gb_

<br>

## Расчеты для Master Nodes

Так как в нашем случае в ТЗ ничего не сказано про отказоустойчивость самого класетра K8s, то для работы я предложу одну Master Node (Control Plane + etcd) с минимальными требования согласно документации K8s в _2CPU_ + _2Gb_.

Если же рассмотреть вариант с отказоустойчивостью самого кластера, то необходимо 3-и ноды по _2CPU_ + _2Gb_ при условии, что etcd будет располагаться на Master Nodes.

Третий, и самый идеальный, вариант минимальных требований для максимально отказоустойчивого кластера K8s - 2-е Master Nodes по _2CPU_ + _2Gb_ и 3-и отдельные ноды для кластера etcd + haproxy по _2CPU_ + _2Gb_.

<br>

## Расчеты для Worker Nodes
Так как мы имеем требования в отказоустойчивости БД и Системы кеширования и эти компоненты должны быть представлены в трех экземплярах каждая, то я бы выбрал вариант кластера из 3-х Worker Nodes. Это оптимальное количество для соблюдения отказоустойчивости и при этом позволит избежать избыточного потребления ресурсов системными нуждами, когда кластер состоит из большого количества "малоресурсных" нод.

Распределим наши службы по нодам и подсчитаем максимально вероятную нагрузку если у нас в кластере будет 3-и Worker Nodes. Одна нода максимально может содержать в себе: 1-ин экземпляр БД + 1-ин экземпляр Системы кеширования + 2-а экземпляра Frontend'а + 4-е экземпляра Backend'а.

Исходя из этих данных подсчитаем максимальную нагрузку на одну ноду:

- Компоненты сервиса - (_1CPU_ + _4Gb_) + (_1CPU_ + _4Gb_) + (_0,4CPU_ + _0,1Gb_) + (_4CPU_ + _2,4Gb_) = _6,4CPU_ + _10,5Gb_
- Системные нужды - ОС + kubetel + eviction = _0,09CPU_ + _2,9Gb_ (при условии если наша нода будет иметь _8CPU_ + _16Gb_)
- Служебные нужды - разместить на каждой ноде pod для служебных сервисов (мониторинг, DNS кэш и т.п.) = _1CPU_ + _2GB_

В итоге получаем максимальные требования к ноде равные _7,49CPU_ + _15,4Gb_

Округляем и получаем системные требования в _8CPU_ + _16Gb_ для каждой ноды и не забываем про еще одну ноду для резерва на случай выхода из строя любой Worker Node.

<br>

## Итоги

Следуя расчетам сделанным выше, то для соблюдения всех условий я предложу:

- 1-а Master Node на _2CPU_ + _2Gb_
- 4-ре Worker Nodes по _8CPU_ + _16Gb_
