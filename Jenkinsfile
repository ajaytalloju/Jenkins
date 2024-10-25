pipeline {
    agent {
        docker { image 'ajaytalloju/myrepo:node-16-docker' } // Custom Docker image
    }
    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-cred')
        IMAGE_NAME = 'ajaytalloju/myrepo:node-16-alpine'
    }
    stages {
        stage('Test') {
            steps {
                // Check Node version
                sh 'node --version'
            }
        }
        stage('Tag Image') {
            steps {
                script {
                    // Tagging the Docker image
                    sh "docker tag node:16-alpine ${IMAGE_NAME}"
                }
            }
        }
        stage('Push to Docker Hub') {
            steps {
                script {
                    // Log in to Docker Hub and push the image
                    sh "echo ${DOCKERHUB_CREDENTIALS_PSW} | docker login -u ${DOCKERHUB_CREDENTIALS_USR} --password-stdin"
                    sh "docker push ${IMAGE_NAME}"
                }
            }
        }
    }
}
