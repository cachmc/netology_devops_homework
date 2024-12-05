pipeline {
    agent {
        label 'linux'
    }
    environment { 
        AWS_ACCESS_KEY_ID         = credentials('jenkins-aws-secret-key-id')
        AWS_SECRET_ACCESS_KEY     = credentials('jenkins-aws-secret-access-key')
        ANSIBLE_HOST_KEY_CHECKING = 'False'
    }
    parameters {
        choice(name: 'CLOUD_ID', choices: ['b1gckqa*************'])
        choice(name: 'FOLDER_ID', choices: ['b1gfoip*************'])
        string(name: 'TOKEN', defaultValue: '')
        string(name: 'NETWORK_PREFIX_NAME', defaultValue: '')
        string(name: 'COUNT_VMS', defaultValue: '')
        string(name: 'SSH_PUBLIC_KEY', defaultValue: '')
    }
    stages {
        stage('Clone repo') {
            steps {
                git branch: 'master', credentialsId: 'netology-jenkins-terraform-ansible', url: 'https://github.com/cachmc/netology-jenkins-terraform-ansible.git'
            }
        }
        stage('Initialization terraform') {
            steps {
                sh "terraform -chdir=./terraform/vpc init"
                sh "terraform -chdir=./terraform/vms init"
            }
        }
        stage('Creation of infrastructure') {
            steps {
                sh "terraform -chdir=./terraform/vpc apply -auto-approve -var 'cloud_id=${params.CLOUD_ID}' -var 'folder_id=${params.FOLDER_ID}' -var 'token=${params.TOKEN}' -var 'prefix_name=${params.NETWORK_PREFIX_NAME}'"
                sh "terraform -chdir=./terraform/vms apply -auto-approve -var 'cloud_id=${params.CLOUD_ID}' -var 'folder_id=${params.FOLDER_ID}' -var 'token=${params.TOKEN}' -var 'count_vms=${params.COUNT_VMS}' -var 'ssh_key=${params.SSH_PUBLIC_KEY}'"
            }
        }
        stage('Setting of infrastructure') {
            steps {
                sh "ansible-playbook -i ./ansible/inventory/test.yml ./ansible/site.yml"
            }
        }
        stage('Destroy infrastructure') {
            steps {
                sh "terraform -chdir=./terraform/vms destroy -auto-approve -var 'cloud_id=${params.CLOUD_ID}' -var 'folder_id=${params.FOLDER_ID}' -var 'token=${params.TOKEN}' -var 'count_vms=${params.COUNT_VMS}' -var 'ssh_key=${params.SSH_PUBLIC_KEY}'"
                sh "terraform -chdir=./terraform/vpc destroy -auto-approve -var 'cloud_id=${params.CLOUD_ID}' -var 'folder_id=${params.FOLDER_ID}' -var 'token=${params.TOKEN}' -var 'prefix_name=${params.NETWORK_PREFIX_NAME}'"
            }
        }
    }
