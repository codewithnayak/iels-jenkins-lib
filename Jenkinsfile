pipeline{
    agent {
        lebe
    }

    stages{
        stage('build'){
            steps{
                echo 'hello world'
            }

        }

        stage('checkout'){
            steps{
                echo '**** code checkout *****'
                checkout scmGit(branches: [[name: 'main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/codewithnayak/els-station-manager.git']])
                echo '**** code checkout successful ****'
            }
        }

        stage('build'){
            steps{
                sh('ls -l')
            }
        }

        stage('test'){
            steps{
                echo '**** test started *****'
                checkout scmGit(branches: [[name: 'main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/codewithnayak/els-station-manager.git']])
                echo '**** test done ****'
                
            }
        }
    }
}