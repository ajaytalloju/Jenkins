pipeline {
    agent {
        docker { image 'node:16-alpine' }
    }
    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-cred') // Make sure this is your credentials ID in Jenkins
        IMAGE_NAME = 'ajaytalloju/myrepo:node-16-alpine'
    }
    stages {
        stage('Test') {
            steps {
                sh 'node --version'
            }
        }
        stage('Tag Image') {
            steps {
                script {
                    // Tag the Docker image
                    sh "docker tag node:16-alpine ${IMAGE_NAME}"
                }
            }
        }
        stage('Push to Docker Hub') {
            steps {
                script {
                    // Log in to Docker Hub
                    sh "echo ${DOCKERHUB_CREDENTIALS_PSW} | docker login -u ${DOCKERHUB_CREDENTIALS_USR} --password-stdin"
                    
                    // Push the tagged image to Docker Hub
                    sh "docker push ${IMAGE_NAME}"
                }
            }
        }
    }
}
