pipeline {
    agent any

    stages {
        
        stage('Node Build and Test') {
            agent{
                docker{
                    image "node:14-alpine"
                }
          
            }
          
            steps {
                                echo 'Building..'
                 dir ("./DotnetTemplate.Web"){
                    sh 'npm install'
                    sh 'npm run build'
                    sh 'npm run test-with-coverage'
                    sh 'npm run lint'
                }
            }
        }

        stage('Dot Net Build and Test') {
            agent{
                docker{
                    image "mcr.microsoft.com/dotnet/sdk:5.0"
                }
          
            }
            environment {
                   
                DOTNET_CLI_HOME="/tmp/dotnet_cli_home" 
            }
    
          
            steps {
                echo 'Building..'     
                sh 'dotnet build'
                sh 'dotnet test'

            }
        }
        
        stage('Coverage') {
        
            steps {
                echo 'Collecting the coverage stats..'   
                publishCoverage sourceFileResolver: sourceFiles('DotnetTemplate.Web/coverage/cobertura-coverage.xml')  

            }
        }
        
    }
}