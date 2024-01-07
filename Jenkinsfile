pipeline {
    agent any
    environment {
        IMAGE_NAME = 'node-app'
        CONTAINER_NAME = 'node-app-container'
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    credentialsId: 'jo-cred',
                    url: 'https://github.com/Jirayut-Jo/qa'
            }
        }
        stage('Build Image') {
            steps {
                script {
                    docker.build("$IMAGE_NAME", "--no-cache .")
                }
            }
        }
        stage('Run Container') {
            steps {
                script {
                    sh "docker run -d --name ${CONTAINER_NAME} -p 3000:3000 ${IMAGE_NAME}"
                }
            }
        }
        stage('Run Robot Tests') {
            steps {
                script {
                    sh "docker exec ${CONTAINER_NAME} robot /app/QA/automate-test/test.robot"
                }
            }
        }
        stage('Performance Test') {
            steps {
                script {
                    sh "docker exec ${CONTAINER_NAME} k6 run /app/automate-test/test-performance.js"
                }
            }
        }
        stage('Cleanup') {
            steps {
                script {
                    sh "docker stop ${CONTAINER_NAME}"
                    sh "docker rm ${CONTAINER_NAME}"
                    sh "docker rmi ${IMAGE_NAME}"
                }
            }
        }
    }
    post {
        always {
            sh "docker stop ${CONTAINER_NAME} || true"
            sh "docker rm ${CONTAINER_NAME} || true"
            sh "docker rmi ${IMAGE_NAME} || true"
        }
        success {
            echo 'Tests passed successfully!'
        }
        failure {
            echo 'Tests failed. Check the logs for more information.'
        }
    }
}
