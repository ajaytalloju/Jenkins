pipeline {
    agent {
        docker { image 'node:16-alpine' }
    }
    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-cred')
        IMAGE_NAME = 'ajaytalloju/myrepo:node-16-alpine'
    }
    stages {
        stage('Install Docker CLI') {
            steps {
                sh '''
                apk update && \
                apk add --no-cache docker-cli
                '''
            }
        }
        stage('Test') {
            steps {
                sh 'node --version'
            }
        }
        stage('Tag Image') {
            steps {
                script {
                    sh "docker tag node:16-alpine ${IMAGE_NAME}"
                }
            }
        }
        stage('Push to Docker Hub') {
            steps {
                script {
                    sh "echo ${DOCKERHUB_CREDENTIALS_PSW} | docker login -u ${DOCKERHUB_CREDENTIALS_USR} --password-stdin"
                    sh "docker push ${IMAGE_NAME}"
                }
            }
        }
    }
}
