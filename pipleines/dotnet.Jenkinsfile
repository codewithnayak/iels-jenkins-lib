@Library('first-small-lib') _
pipeline {
  agent {
    kubernetes {
      yaml dotnetBuildPod()
      retries 2
    }
  }
  stages {
    stage('Checkout') {
      steps {
        container('dotnetcore') {
            welcomeJob('main')
            checkout scmGit(branches: [[name: 'main']],
            extensions: [], 
            userRemoteConfigs: [[url: 'https://github.com/codewithnayak/els-station-manager.git']])
            echo '**** code checkout successful ****'

            sh(script: 'ls -l')
            //build dotnet project 
            sh(script: """
            dotnet restore
            """)

        }
      }
    }
  }
}