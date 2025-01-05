# Домашнее задание к занятию 14 «Средство визуализации Grafana»

## Задание 1

![Скриншот 1](https://github.com/cachmc/netology_devops_homework/raw/main/05-monitoring/02-grafana/pictures/task-01-00.png)

![Скриншот 2](https://github.com/cachmc/netology_devops_homework/raw/main/05-monitoring/02-grafana/pictures/task-01-01.png)

<br>
<br>

## Задание 2

![Скриншот 3](https://github.com/cachmc/netology_devops_homework/raw/main/05-monitoring/02-grafana/pictures/task-02-00.png)

<br>

```promql
node_memory_MemFree_bytes{instance="${instance}"}

```

![Скриншот 4](https://github.com/cachmc/netology_devops_homework/raw/main/05-monitoring/02-grafana/pictures/task-02-01.png)

<br>

```promql
node_filesystem_size_bytes{instance="${instance}"}

```

![Скриншот 5](https://github.com/cachmc/netology_devops_homework/raw/main/05-monitoring/02-grafana/pictures/task-02-02.png)

<br>

```promql
100 - avg(rate(node_cpu_seconds_total{instance="${instance}", mode="idle"}[30s])) * 100

```

![Скриншот 6](https://github.com/cachmc/netology_devops_homework/raw/main/05-monitoring/02-grafana/pictures/task-02-03.png)

<br>

```promql
avg(sum(rate(node_cpu_seconds_total{instance="${instance}", mode!="idle"}[1m])) without (mode)) * 100

```

![Скриншот 7](https://github.com/cachmc/netology_devops_homework/raw/main/05-monitoring/02-grafana/pictures/task-02-04.png)

<br>

```promql
avg(sum(rate(node_cpu_seconds_total{instance="${instance}", mode!="idle"}[5m])) without (mode)) * 100

```

```promql
avg(sum(rate(node_cpu_seconds_total{instance="${instance}", mode!="idle"}[15m])) without (mode)) * 100

```

![Скриншот 8](https://github.com/cachmc/netology_devops_homework/raw/main/05-monitoring/02-grafana/pictures/task-02-05.png)

<br>
<br>

## Задание 3

![Скриншот 9](https://github.com/cachmc/netology_devops_homework/raw/main/05-monitoring/02-grafana/pictures/task-03-00.png)

![Скриншот 10](https://github.com/cachmc/netology_devops_homework/raw/main/05-monitoring/02-grafana/pictures/task-03-01.png)

![Скриншот 11](https://github.com/cachmc/netology_devops_homework/raw/main/05-monitoring/02-grafana/pictures/task-03-02.png)

<br>
<br>

## Задание 4

[dashboard_node_exporter.json](https://github.com/cachmc/netology_devops_homework/tree/main/05-monitoring/02-grafana/src/dashboard_node_exporter.json)

<br>
<br>

## [Docker compose](https://github.com/cachmc/netology_devops_homework/tree/main/05-monitoring/02-grafana/src/compose.yaml)

## [Prometheus scrape config](https://github.com/cachmc/netology_devops_homework/tree/main/05-monitoring/02-grafana/src/prometheus.yaml)
