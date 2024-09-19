pipeline {
    agent any

    stages {
        stage('Instalando dependências') { 
            steps {
                sh 'npm install'
            }
        }
        stage('FOSSA Análise') { 
            steps {
               script {
                    // Checa se a CLI do FOSSA já está instalada 
                    def isFossaInstalled = sh(script: 'command -v fossa', returnStatus: true)
                    
                    // Instala a CLI do FOSSA caso ainda não exista 
                    if (isFossaInstalled != 0) {
                        echo 'FOSSA CLI not found. Installing...'
                        sh 'curl -H \'Cache-Control: no-cache\' https://raw.githubusercontent.com/fossas/fossa-cli/master/install-latest.sh | bash'
                    } else {
                        echo 'FOSSA CLI is already installed. Skipping installation.'
                    }
                    
                    // TODO:: adicionar verificação para ver se a análise passou ou não
                    // TODO:: atualizar métricas do FOSSA
                    // Roda a análise do FOSSA 
                    sh 'FOSSA_API_KEY=XXXXXXXXXXXXXXXXXXXX fossa analyze'
                } 
            }
        }
        stage('Codacy Análise') { 
            steps {
               script {
                    // TODO: adicionar validação para ver se já está instalado
                    sh 'curl -L https://github.com/codacy/codacy-analysis-cli/archive/master.tar.gz | tar xvz'
                    sh 'cd codacy-analysis-cli-* && sudo make install'

                    // TODO: validar se está rodando a CLI corretamente
                    sh 'codacy-analysis-cli analyze \
                        --tool <TOOL-SHORT-NAME> \
                        --directory <SOURCE-CODE-PATH>'
                } 
            }
        }
        // Validar Build da imagem e configurar o push
        stage('Build imagem') { 
            steps {
               script {
                    sh 'podman -t app .' 
                } 
            }
        }
        stage('Push imagem') { 
            steps {
               script {
                    sh 'podman push myapp:latest myregistry.com/myapp:latest' 
                } 
            }
        }
    }
}
