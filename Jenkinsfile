pipeline {
    agent any  // Utiliser n'importe quel agent disponible
    environment{
        DOCKERHUB_CREDENTIALS=credentials('id_token_prv')
        KEY_FILE = credentials('gcp_key_jenkins')
        CLOUDSDK_CORE8PROJECT='protean-depot-430512-d1'

    }


    stages {
        stage('Checkout') {
            steps {
                // Récupérer le code source depuis le repository
                git url: 'https://github.com/mokrim-mohamed/projetArchi', branch: "developper"
            }
        }

        stage('Echo Message') {
            steps {
                // Exemple de commande pour afficher un message
                sh 'echo "Le code a été récupéré avec succès et le pipeline est en cours d\'exécution."'
            }
        }
    stage('Check Docker') {
        steps {
            script {
                    // Vérifier que Docker est accessible et obtenir la version
                sh 'docker --version'
                    
                    // Optionnel : Exécuter un conteneur Docker basique pour vérifier que Docker fonctionne correctement
                sh 'docker run --rm hello-world'
                }
            }
        }
     stage('Build Docker Image') {
        steps {
            script {
                    // Construire l'image Docker
                
                sh 'docker build -t mokrim/test:latest .'
                echo 'image a ete cree'

                }
            }
        }
    stage('Login'){
        steps {
            sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            sh 'echo login succes'
            }
        }
    stage('push'){
        steps {
            
            sh 'docker push mokrim/test:latest'

            }
        }
    stage('Deploy to GCP') {
       steps {
           script {
                    // Authenticate with Google Cloud Platform using the GCP key file
             withCredentials([file(credentialsId: 'gcp_key_jenkins', variable: 'GCP_KEY_FILE')]) {
                sh '''
                    gcloud auth activate-service-account --key-file=$GCP_KEY_FILE'
                    gcloud compute zone list
                    '''
                    }
                }
            }
    }
}

    post {
        success {
            echo 'Le pipeline s\'est terminé avec succès.'
            sh 'docker logout'
        }

        failure {
            echo 'Le pipeline a échoué.'
            sh 'docker logout'
        }
    }
}
