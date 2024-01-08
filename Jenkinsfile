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
                    def builtImage = docker.build("${IMAGE_NAME}:${env.BUILD_NUMBER}")
                    builtImage.tag('latest')
                }
            }
        }
        stage('Push Image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-credentials-id') {
                        docker.image("${IMAGE_NAME}:${env.BUILD_NUMBER}").push()
                        docker.image("${IMAGE_NAME}:latest").push() 
                    }
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