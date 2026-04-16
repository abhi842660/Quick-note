pipeline {
    agent any

    environment {
        IMAGE = "abhi842/quick-note-app:v1"
        DOCKER_CONFIG = "/tmp/docker-config"
    }

    stages {

        stage('Prepare Docker Config') {
            steps {
                sh '''
                mkdir -p /tmp/docker-config
                echo '{ "auths": {} }' > /tmp/docker-config/config.json
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '/usr/local/bin/docker --version'
                sh '/usr/local/bin/docker build -t $IMAGE .'
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh '''
                    /usr/local/bin/docker login -u $USER -p $PASS
                    /usr/local/bin/docker push $IMAGE
                    '''
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh '/opt/homebrew/bin/kubectl apply -f k8s/deployment.yaml'
                sh '/opt/homebrew/bin/kubectl apply -f k8s/service.yaml'
            }
        }
    }
}