pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials-id') 
        IMAGE_NAME = 'jirayutrungsuwan/ci-cd' 
    }

    stages {
        stage('Build Image') {
            steps {
                script {
                    docker.build("${IMAGE_NAME}:${env.BUILD_NUMBER}")
                }
            }
        }
        stage('Push Image') {
            steps {
                script {
                    docker.image("${IMAGE_NAME}:${env.BUILD_NUMBER}").push()
                    docker.image("${IMAGE_NAME}:latest").push() 
                }
            }
        }
    }
    post {
        always {
            echo 'The pipeline is finished!'
        }
    }
}