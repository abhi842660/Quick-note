pipeline {
    agent any

    environment {
        IMAGE = "abhi842/quick-note-app:v1"
    }

    stages {

        stage('Build Docker') {
            steps {
                sh '/usr/local/bin/docker --version'
                sh '/usr/local/bin/docker build -t $IMAGE .'
            }
        }

        stage('Push Docker') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh '''
                    /usr/local/bin/docker login -u $USER -p $PASS
                    /usr/local/bin/docker push $IMAGE
                    '''
                }
            }
        }

        stage('Deploy to K8s') {
            steps {
                sh 'kubectl apply -f k8s/deployment.yaml'
                sh 'kubectl apply -f k8s/service.yaml'
            }
        }
    }
}