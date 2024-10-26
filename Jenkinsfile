pipeline {
    agent any
    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-cred')
        IMAGE_NAME = 'ajaytalloju/myrepo:node-16-docker'
    }
    stages {
        stage('Build and Push Docker Image') {
            steps {
                script {
                    // Define Dockerfile content and build Docker image
                    writeFile file: 'Dockerfile', text: '''
                    FROM node:16-alpine
                    RUN apk update && apk add --no-cache docker-cli
                    '''
                    sh "docker build -t ${IMAGE_NAME} ."
                    
                    // Login and push the Docker image to Docker Hub
                    sh "echo ${DOCKERHUB_CREDENTIALS_PSW} | docker login -u ${DOCKERHUB_CREDENTIALS_USR} --password-stdin"
                    sh "docker push ${IMAGE_NAME}"
                }
            }
        }
        stage('Test with Docker Image') {
            agent {
                docker { image "${IMAGE_NAME}" }
            }
            steps {
                // Run tests within the Docker image
                sh 'node --version'
            }
        }
    }
}
