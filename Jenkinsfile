pipeline {
    agent any

    environment {
        DOCKER_BIN = "/usr/bin/docker" 
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials-id') // ID des credentials Docker dans Jenkins
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout du code source depuis GitHubgit url: 'https://github.com/mokrim-mohamed/projetArchi', branch: 'main'
                git branch: 'developper', url: https://github.com/mokrim-mohamed/projetArchi'
            }
        }

        stage('Build') {
            steps {
                script {
                    // Exemple de commande pour construire votre image Docker
                    sh "${env.DOCKER_BIN} build -t votre-image:latest ."
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    // Lancer les tests dans un conteneur Docker
                    docker.image('votre-image:latest').inside {
                        sh './run_tests.sh' // Script ou commande pour lancer les tests
                    }
                }
            }
        }
        
        stage('Test Docker Connection') {
            steps {
                script {
                    // Se connecter à Docker Hub pour vérifier la connexion
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials-id', passwordVariable: 'DOCKERHUB_PSW', usernameVariable: 'DOCKERHUB_USR')]) {
                        sh "${env.DOCKER_BIN} login -u ${env.DOCKERHUB_USR} -p ${env.DOCKERHUB_PSW}"
                    }
                }
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
                    // Pousser l'image vers Docker Hub
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credentials-id') {
                        docker.image('votre-image:latest').push('latest')
                    }
                }
            }
        }
    }

    post {

        success {
            echo 'Pipeline succeeded!'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}
