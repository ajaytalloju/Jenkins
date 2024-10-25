pipeline {
    agent any
    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-cred')
        CUSTOM_IMAGE_NAME = 'ajaytalloju/myrepo:node-16-docker'
        FINAL_IMAGE_NAME = 'ajaytalloju/myrepo:node-16-alpine'
    }
    stages {
        stage('Build Custom Docker Image') {
            steps {
                script {
                    // Build the custom Docker image with Docker CLI
                    sh '''
                    cat <<EOF > Dockerfile
                    FROM node:16-alpine
                    RUN apk update && apk add --no-cache docker-cli
                    EOF
                    docker build -t ${CUSTOM_IMAGE_NAME} .
                    '''
                }
            }
        }
        stage('Push Custom Docker Image to Docker Hub') {
            steps {
                script {
                    // Log in and push the custom Docker image
                    sh "echo ${DOCKERHUB_CREDENTIALS_PSW} | docker login -u ${DOCKERHUB_CREDENTIALS_USR} --password-stdin"
                    sh "docker push ${CUSTOM_IMAGE_NAME}"
                }
            }
        }
        stage('Test with Custom Image') {
            agent {
                docker { image "${CUSTOM_IMAGE_NAME}" }
            }
            steps {
                // Run tests within the custom Docker image
                sh 'node --version'
            }
        }
        stage('Tag Final Image') {
            steps {
                script {
                    // Tag the Docker image
                    sh "docker tag ${CUSTOM_IMAGE_NAME} ${FINAL_IMAGE_NAME}"
                }
            }
        }
        stage('Push Final Image to Docker Hub') {
            steps {
                script {
                    // Push the tagged image to Docker Hub
                    sh "docker push ${FINAL_IMAGE_NAME}"
                }
            }
        }
    }
}
