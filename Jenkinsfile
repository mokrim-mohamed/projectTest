pipeline {
    agent any  // Utiliser n'importe quel agent disponible

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
    }

    post {
        success {
            echo 'Le pipeline s\'est terminé avec succès.'
        }

        failure {
            echo 'Le pipeline a échoué.'
        }
    }
}
