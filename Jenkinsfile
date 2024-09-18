pipeline {
    agent {
        docker {
            image 'node:20.17.0-alpine3.20'
        }
    }
    stages {
        stage('Build') { 
            steps {
                sh 'npm install'
            }
        }
        stage('FOSSA Analyze') { 
            steps {
                sh 'curl -H \'Cache-Control: no-cache\' https://raw.githubusercontent.com/fossas/fossa-cli/master/install-latest.sh | bash'
                sh 'FOSSA_API_KEY=XXXXXXXXXXXXXXXXXXXX fossa analyze'
            }
        }
    }
}
