pipeline {
    agent any
    
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/devopscbabu/May-Banking.git'
            }
        }
        stage('HTML Reports') {
            steps {
                publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: '/var/lib/jenkins/workspace/Banking-Project/target/surefire-reports', reportFiles: 'index.html', reportName: 'HTML Report', reportTitles: '', useWrapperFileDirectly: true])
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t cbabu85/may-banking-project:1.0 .'
            }
        }
        stage('Docker Push Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'docker_password', usernameVariable: 'docker_login')]) {
                sh 'docker login -u ${docker_login} -p ${docker_password}'
                        }
                sh 'docker push cbabu85/may-banking-project:1.0 '
            }
        }
        stage('Configure Server with terraform and deploy using Ansible') {
           steps {
              dir('my-serverfiles') {
              sh 'sudo chmod 600 Babuckey.pem'
              sh 'terraform init'
              sh 'terraform validate'
              sh 'terraform apply --auto-approve'
                   }   
                }
            }
        }
    }   
