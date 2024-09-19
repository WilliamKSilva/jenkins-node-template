pipeline {
    agent any

    stages {
        stage('Install Dependencies') { 
            steps {
                sh 'npm install'
            }
        }
        stage('FOSSA Analyze') { 
            steps {
               script {
                    // Check if FOSSA CLI is available, adjust the command based on your agent's shell
                    def isFossaInstalled = sh(script: 'command -v fossa', returnStatus: true)
                    
                    // Install FOSSA CLI if not already installed
                    if (isFossaInstalled != 0) {
                        echo 'FOSSA CLI not found. Installing...'
                        sh 'curl -H \'Cache-Control: no-cache\' https://raw.githubusercontent.com/fossas/fossa-cli/master/install-latest.sh | bash'
                    } else {
                        echo 'FOSSA CLI is already installed. Skipping installation.'
                    }
                    
                    // Run Fossa analysis
                    sh 'FOSSA_API_KEY=XXXXXXXXXXXXXXXXXXXX fossa analyze'
                } 
            }
        }
    }
}
