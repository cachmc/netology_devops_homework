pipeline {
    agent {
        label 'molecule'
    }
    stages {
        stage('Clone repo') {
            steps {
                git credentialsId: 'ansible-role-vectore', url: 'https://github.com/cachmc/ansible-role-vector.git'
            }
        }
        stage('Run testing role vector') {
            steps {
                sh 'molecule test -s centos_8'
            }
        }
    }
}
