pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/Channy-Chhun-IT/Note-App'
            }
        }
        stage('Build') {
            steps {
                sh '''
                    npm install
                    npm run build
                '''
            }
        }
        stage('Package') {
            steps {
                sh '''
                    zip -r app.zip .
                '''
            }
        }
        stage('Send to Server') {
            steps {
                sh '''
                    scp -o StrictHostKeyChecking=no app.zip channy@192.168.49.23:/opt/code_upload/site1
                    scp -o StrictHostKeyChecking=no deploy.sh channy@192.168.49.23:/opt/deploy.sh
                '''
            }
        }
        stage('Deploy on Server') {
            steps {
                sh '''
                    ssh channy@192.168.49.23 "chmod +x /opt/deploy.sh && sudo /opt/deploy.sh"
                '''
            }
        }
    }

    post {
        success {
            echo "Deployment Successful!"
        }
        failure {
            echo "Deployment Failed!"
        }
    }
}
