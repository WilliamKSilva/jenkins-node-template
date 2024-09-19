pipeline {
    agent any  // Use any available agent, which will be our custom Jenkins environment

    stages {
        stage('Install Dependencies') { 
            steps {
                sh 'npm install'
            }
        }
        stage('FOSSA Analyze') { 
            steps {
                sh 'curl -H "Cache-Control: no-cache" https://raw.githubusercontent.com/fossas/fossa-cli/master/install-latest.sh | bash'
                sh 'FOSSA_API_KEY=${FOSSA_API_KEY} fossa analyze'
            }
        }
    }
}
