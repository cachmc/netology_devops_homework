# Домашнее задание к занятию «Использование Terraform в команде»

## Задание 1

### tflint

```bash
./demonstration1

Warning: Missing version constraint for provider "random" in `required_providers` (terraform_required_providers)

  on main.tf line 8:
   8: resource "random_password" "input_vms" {

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.10.0/docs/rules/terraform_required_providers.md

Warning: Module source "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main" uses a default branch as ref (main) (terraform_module_pinned_source)

  on main.tf line 23:
  23:   source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.10.0/docs/rules/terraform_module_pinned_source.md

Warning: [Fixable] variable "public_key" is declared but not used (terraform_unused_declarations)

  on variables.tf line 3:
   3: variable "public_key" {

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.10.0/docs/rules/terraform_unused_declarations.md
```

```bash
./src

Warning: Missing version constraint for provider "yandex" in `required_providers` (terraform_required_providers)

  on providers.tf line 3:
   3:     yandex = {
   4:       source = "yandex-cloud/yandex"
   5:     }

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.10.0/docs/rules/terraform_required_providers.md

Warning: [Fixable] variable "vms_ssh_root_key" is declared but not used (terraform_unused_declarations)

  on variables.tf line 36:
  36: variable "vms_ssh_root_key" {

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.10.0/docs/rules/terraform_unused_declarations.md
```

<br>

### checkov

```bash
./demonstration1

Check: CKV_TF_1: "Ensure Terraform module sources use a commit hash"
        FAILED for resource: test-vm
        File: /main.tf:22-43
        Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/supply-chain-policies/terraform-policies/ensure-terraform-module-sources-use-git-url-with-commit-hash-revision

                22 | module "test-vm" {
                23 |   source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
                24 |   env_name       = "develop" 
                25 |   network_id     = yandex_vpc_network.develop.id
                26 |   subnet_zones   = ["ru-central1-a","ru-central1-b"]
                27 |   subnet_ids     = [yandex_vpc_subnet.develop_a.id,yandex_vpc_subnet.develop_b.id]
                28 |   instance_name  = "webs"
                29 |   instance_count = 2
                30 |   image_family   = "ubuntu-2004-lts"
                31 |   public_ip      = true
                32 | 
                33 |   labels = { 
                34 |     owner= "i.ivanov",
                35 |     project = "accounting"
                36 |      }
                37 | 
                38 |   metadata = {
                39 |     user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
                40 |     serial-port-enable = 1
                41 |   }
                42 | 
                43 | }

Check: CKV_TF_2: "Ensure Terraform module sources use a tag with a version number"
        FAILED for resource: test-vm
        File: /main.tf:22-43
        Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/supply-chain-policies/terraform-policies/ensure-terraform-module-sources-use-tag

                22 | module "test-vm" {
                23 |   source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
                24 |   env_name       = "develop" 
                25 |   network_id     = yandex_vpc_network.develop.id
                26 |   subnet_zones   = ["ru-central1-a","ru-central1-b"]
                27 |   subnet_ids     = [yandex_vpc_subnet.develop_a.id,yandex_vpc_subnet.develop_b.id]
                28 |   instance_name  = "webs"
                29 |   instance_count = 2
                30 |   image_family   = "ubuntu-2004-lts"
                31 |   public_ip      = true
                32 | 
                33 |   labels = { 
                34 |     owner= "i.ivanov",
                35 |     project = "accounting"
                36 |      }
                37 | 
                38 |   metadata = {
                39 |     user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
                40 |     serial-port-enable = 1
                41 |   }
                42 | 
                43 | }
```

<br>
<br>

## Задание 2

![Скриншот 1](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/05-teamwork/pictures/task-02-00.png)

![Скриншот 2](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/05-teamwork/pictures/task-02-01.png)

![Скриншот 3](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/05-teamwork/pictures/task-02-02.png)

![Скриншот 4](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/05-teamwork/pictures/task-02-03.png)

![Скриншот 5](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/05-teamwork/pictures/task-02-04.png)

![Скриншот 6](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/05-teamwork/pictures/task-02-05.png)

![Скриншот 7](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/05-teamwork/pictures/task-02-06.png)

![Скриншот 8](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/05-teamwork/pictures/task-02-07.png)

<br>
<br>

## Задание 3

### [Pull request](https://github.com/cachmc/netology_devops_homework/pull/1)

```bash
docker run --rm -v <check_directory>:/data -t ghcr.io/terraform-linters/tflint

docker run --tty --rm --volume <check_directory>:/tf --workdir /tf bridgecrew/checkov --directory /tf
```
![Скриншот 9](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/05-teamwork/pictures/task-03-00.png)

![Скриншот 10](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/05-teamwork/pictures/task-03-01.png)

![Скриншот 11](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/05-teamwork/pictures/task-03-02.png)

<br>

[terraform_plan_vpc](https://github.com/cachmc/netology_devops_homework/tree/main/02-terraform/05-teamwork/src/terraform_plan_vpc)

![Скриншот 12](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/05-teamwork/pictures/task-03-03.png)

![Скриншот 13](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/05-teamwork/pictures/task-03-04.png)

![Скриншот 14](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/05-teamwork/pictures/task-03-05.png)

<br>

[terraform_plan_vms](https://github.com/cachmc/netology_devops_homework/tree/main/02-terraform/05-teamwork/src/terraform_plan_vms)

![Скриншот 15](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/05-teamwork/pictures/task-03-06.png)

![Скриншот 16](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/05-teamwork/pictures/task-03-07.png)

<br>
<br>

## Задание 4

[variables_task_4.tf](https://github.com/cachmc/netology_devops_homework/tree/main/02-terraform/05-teamwork/src/terraform/vms/variables_task_4.tf)

![Скриншот 17](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/05-teamwork/pictures/task-04-00.png)

![Скриншот 18](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/05-teamwork/pictures/task-04-01.png)

![Скриншот 19](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/05-teamwork/pictures/task-04-02.png)

<br>
<br>

## Задание 5

[variables_task_5.tf](https://github.com/cachmc/netology_devops_homework/tree/main/02-terraform/05-teamwork/src/terraform/vms/variables_task_5.tf)

<br>
<br>

## Задание 6

```groovy
pipeline {
    agent {
        label 'terraform'
    }
    environment { 
        AWS_ACCESS_KEY_ID     = credentials('jenkins-aws-secret-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('jenkins-aws-secret-access-key')
    }
    parameters {
        string(name: 'CLOUD_ID', defaultValue: '')
        string(name: 'FOLDER_ID', defaultValue: '')
        string(name: 'TOKEN', defaultValue: '')
        string(name: 'NETWORK_PREFIX_NAME', defaultValue: '')
        string(name: 'SSH_PUBLIC_KEY', defaultValue: '')
    }
    stages {
        stage('Clone repo') {
            steps {
                git branch: 'terraform-jenkins', credentialsId: 'netology_devops_homework', url: 'https://github.com/cachmc/netology_devops_homework.git'
            }
        }
        stage('Initialization terraform') {
            steps {
                sh "terraform -chdir=./vpc init"
                sh "terraform -chdir=./vms init"
            }
        }
        stage('Creation of infrastructure') {
            steps {
                sh "terraform -chdir=./vpc apply -auto-approve -var 'cloud_id=${params.CLOUD_ID}' -var 'folder_id=${params.FOLDER_ID}' -var 'token=${params.TOKEN}' -var 'prefix_name=${params.NETWORK_PREFIX_NAME}'"
                sh "terraform -chdir=./vms apply -auto-approve -var 'cloud_id=${params.CLOUD_ID}' -var 'folder_id=${params.FOLDER_ID}' -var 'token=${params.TOKEN}' -var 'ssh_key=${params.SSH_PUBLIC_KEY}'"
            }
        }
        stage('Destroy infrastructure') {
            steps {
                sh "terraform -chdir=./vms destroy -auto-approve -var 'cloud_id=${params.CLOUD_ID}' -var 'folder_id=${params.FOLDER_ID}' -var 'token=${params.TOKEN}' -var 'ssh_key=${params.SSH_PUBLIC_KEY}'"
                sh "terraform -chdir=./vpc destroy -auto-approve -var 'cloud_id=${params.CLOUD_ID}' -var 'folder_id=${params.FOLDER_ID}' -var 'token=${params.TOKEN}' -var 'prefix_name=${params.NETWORK_PREFIX_NAME}'"
            }
        }
    }
}
```

![Скриншот 20](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/05-teamwork/pictures/task-06-00.png)

![Скриншот 21](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/05-teamwork/pictures/task-06-01.png)

![Скриншот 22](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/05-teamwork/pictures/task-06-02.png)

![Скриншот 23](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/05-teamwork/pictures/task-06-03.png)

![Скриншот 24](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/05-teamwork/pictures/task-06-04.png)

![Скриншот 25](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/05-teamwork/pictures/task-06-05.png)

[Branch for Jenkins](https://github.com/cachmc/netology_devops_homework/tree/terraform-jenkins)

<br>
<br>

## Задание 7

![Скриншот 26](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/05-teamwork/pictures/task-07-00.png)

![Скриншот 27](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/05-teamwork/pictures/task-07-01.png)

![Скриншот 28](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/05-teamwork/pictures/task-07-02.png)

![Скриншот 29](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/05-teamwork/pictures/task-07-03.png)

![Скриншот 30](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/05-teamwork/pictures/task-07-04.png)

![Скриншот 31](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/05-teamwork/pictures/task-07-05.png)

![Скриншот 32](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/05-teamwork/pictures/task-07-06.png)

![Скриншот 33](https://github.com/cachmc/netology_devops_homework/raw/main/02-terraform/05-teamwork/pictures/task-07-07.png)

[Terraform module 's3_ydb_tfstate'](https://github.com/cachmc/netology_devops_homework/tree/main/02-terraform/05-teamwork/src/terraform/s3_ydb_tfstate)

<br>
<br>

# [Terraform Code](https://github.com/cachmc/netology_devops_homework/tree/main/02-terraform/05-teamwork/src/terraform)
