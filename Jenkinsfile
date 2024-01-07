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
                    docker.build("$IMAGE_NAME", '.')
                }
            }
        }
        stage('Run Container') {
            steps {
                script {
                    sh "docker run -d --name ${CONTAINER_NAME} -p 3000:3000 ${IMAGE_NAME}"
                    sh "sleep 10"
                    sh "docker logs ${CONTAINER_NAME}"
                }
            }
        }
        stage('Check Container Status') {
            steps {
                script {
                    sh "docker logs node-app-container" 
                }
            }
        }
        stage('Run Robot Tests') {
            steps {
                script {
                    sh "docker exec ${CONTAINER_NAME} robot /app/automate-test/test.robot"
                }
            }
        }
        stage('Copy and Archive Test Results') {
            steps {
                script {
                    sh "docker cp ${CONTAINER_NAME}:/app/output.xml output.xml"
                    sh "docker cp ${CONTAINER_NAME}:/app/log.html log.html"
                    sh "docker cp ${CONTAINER_NAME}:/app/report.html report.html"
                }
                archiveArtifacts artifacts: 'output.xml, log.html, report.html', allowEmptyArchive: true
            }
        }
        stage('Performance Test') {
            steps {
                script {
                    sh "docker exec ${CONTAINER_NAME} k6 run /app/automate-test/test-performance-k6.js"
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
        success {
            echo 'Tests passed successfully!'
        }
        failure {
            echo 'Tests failed. Check the logs for more information.'
        }
    }
}
