pipeline {
    agent any

    environment {
        DOCKER_BIN = "/usr/bin/docker" 
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials-id') // ID des credentials Docker dans Jenkins
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout du code source depuis GitHub
                git branch: 'developper', url: 'https://github.com/mokrim-mohamed/projectTest'
            }
        }

        stage('Build') {
            steps {
                  dir(DOCKER_BIN) {
                    // Exemple de commande pour construire votre application dans le répertoire de travail distant
                    sh 'docker build -t votre-image:latest .'
                }
             
            }
        }

        stage('Test') {
            steps {
                // Lancer les tests dans un conteneur Docker
                script {
                    docker.image('votre-image:latest').inside {
                        sh './run_tests.sh' // Script ou commande pour lancer les tests
                    }
                }
            }
        }
        stage('test connection'){
            steps{
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }
        }
        stage('Push Image') {
            when {
                expression {
                    currentBuild.result == null || currentBuild.result == 'SUCCESS'
                }
            }
            steps {
                script {
                    // Login à Docker Hub
                    docker.withRegistry('https://hub.docker.com/u/mokrim/test', 'dockerhub-credentials-id') {
                        // Tag et Push de l'image Docker
                        docker.image('votre-image:latest').push('latest')
                    }
                }
            }
        }
post {
    always {
        // Nettoyer les ressources Docker
        sh "${env.DOCKER_BIN} system prune -f"
    }
    success {
        echo 'Pipeline succeeded!'
    }
    failure {
        echo 'Pipeline failed.'
    }
}

