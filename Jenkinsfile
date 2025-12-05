pipeline {
    agent any

    environment {
        DEPLOY_DIR = "/usr/share/nginx/html/wwwroot"
        BACKUP_DIR = "/opt/deploy_backups"
    }

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

        stage('Backup Old Site') {
            steps {
                sh '''
                    TIMESTAMP=$(date +%F-%H%M%S)
                    mkdir -p $BACKUP_DIR
                '''
            }
        }

        stage('Deploy New Code') {
            steps {
                sh '''
                    # Clean old site
                    sudo rm -rf $DEPLOY_DIR/*

                    # Deploy new files
                    sudo cp -r dist/* $DEPLOY_DIR/

                    echo "New version deployed to $DEPLOY_DIR"
                '''
            }
        }

        stage('Reload Nginx') {
            steps {
                sh '''
                    sudo systemctl reload nginx
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
