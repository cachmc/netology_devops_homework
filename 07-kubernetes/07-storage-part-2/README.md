# Домашнее задание к занятию «Хранение в K8s. Часть 2»

## Задача 1

![Скриншот 1](https://github.com/cachmc/netology_devops_homework/raw/main/07-kubernetes/07-storage-part-2/pictures/task-01-00.png)

  - После удаления запроса том остался в кластере и имеет статус `Released` - запрос удален, но ресур не возвращен тому. Это произошло по причине того, что в манифесте по созданию **Persistent Voluem** я явным образом не указывал `persistentVolumeReclaimPolicy` и по дефолту **PV** создался с политикой `Retain`. Из [документации](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#reclaiming) следует, что данный режим позволяет сохранить том и данные на нем после удаления запроса. Хоть **PV** и считается освобожденным при этом том еще не доступен для нового запроса, но доступен для создание запроса с тем же определением что и раньше. Для создания нового запроса, отличного от предыдущего, администратуру нужно в ручную пересоздать **PV** и очистить сторедж от данных.
  - После удаления **PV** файл остался в директории на локальной ноде кластера. Произошло это потому, что выбранный мною тип стораджа `local` требует ручной очистки пространства, если не запущен и не используется внешний статический provisener для управления жизененым циклом **PV**. В моем случае он не использовался. Стоит отметить что даный тип стораджа не поддерживает динамическое создание **PV**.

<br>
<br>

## Задача 2

![Скриншот 2](https://github.com/cachmc/netology_devops_homework/raw/main/07-kubernetes/07-storage-part-2/pictures/task-02-00.png)

<br>
<br>

## [Deployment manifest](https://github.com/cachmc/netology_devops_homework/tree/main/07-kubernetes/07-storage-part-2/src/deployment.yaml)

## [Persistent Voluem manifest](https://github.com/cachmc/netology_devops_homework/tree/main/07-kubernetes/07-storage-part-2/src/pv.yaml)

## [Persistent Voluem Claim manifest](https://github.com/cachmc/netology_devops_homework/tree/main/07-kubernetes/07-storage-part-2/src/pvc.yaml)

## [Deployment 2 manifest](https://github.com/cachmc/netology_devops_homework/tree/main/07-kubernetes/07-storage-part-2/src/deployment-2.yaml)

## [Storage Class manifest](https://github.com/cachmc/netology_devops_homework/tree/main/07-kubernetes/07-storage-part-2/src/sc.yaml)

## [Persistent Voluem Claim 2 manifest](https://github.com/cachmc/netology_devops_homework/tree/main/07-kubernetes/07-storage-part-2/src/pvc-2.yaml)
