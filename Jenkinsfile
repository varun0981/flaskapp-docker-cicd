pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                echo 'Downloading source code'
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t flask-app:latest .'
            }
        }

        stage('Test') {
            steps {
                echo 'Application build completed'
            }
        }
    }
}