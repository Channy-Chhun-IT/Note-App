pipeline {
    agent any

    environment {
        DEPLOY_DIR = "/usr/share/nginx/html/wwwroot"
        BACKUP_DIR = "/opt/deploy_backups"
        NODEJS = tool name: 'Node20'
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
                script {
                    sh '''
                        if [ -d FE ]; then
                            cd FE
                        fi

                        if [ -f package.json ]; then
                            export PATH=${NODEJS}/bin:$PATH
                            npm install
                            npm run build
                        else
                            echo "No package.json found Skipping build."
                        fi
                    '''
                }
            }
        }

        stage('Backup Old Site') {
            steps {
                sh '''
                    TIMESTAMP=$(date +%F-%H%M%S)
                    mkdir -p $BACKUP_DIR
                    zip -r $BACKUP_DIR/site-$TIMESTAMP.zip $DEPLOY_DIR
                '''
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                    sudo rm -rf $DEPLOY_DIR/*

                    if [ -d FE ]; then
                        cd FE
                    fi

                    if [ -d dist ]; then
                        OUTPUT=dist
                    else [ -d build ]; then
                        OUTPUT=build
                    fi

                    echo "Deploying from: $OUTPUT"
                    sudo cp -r $OUTPUT/* $DEPLOY_DIR/
                '''
            }
        }

        stage('Reload Nginx') {
            steps {
                sh "sudo systemctl reload nginx"
            }
        }
    }

    post {
        success { echo "Deployment Successful!" }
        failure { echo "Deployment Failed!" }
    }
}
