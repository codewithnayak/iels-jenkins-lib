@Library('first-small-lib') _
pipeline {
  agent {
    kubernetes {
      yaml dotnetKanikoPod()
      retries 2
    }
  }

  parameters{
      string(name:'BRANCH_NAME', defaultValue: 'main' , description: 'he branch to be built')
  }
  

  stages {
    stage('Checkout') {
      steps {
        git url: 'https://github.com/codewithnayak/els-station-manager.git' , branch: '${BRANCH_NAME}'
      }
    }


    stage('Build') {
      steps {
        container('dotnetcore') {
            sh '''
             dotnet restore
             dotnet build -c Release
            '''
        }
      }
    }

    stage('Test'){
      steps{
        container('dotnetcore'){
          sh '''
             dotnet test
            '''
        }
      }
    }

    stage('Build And Push Image'){
      steps{
          container('kaniko'){
            sh '''
            /kaniko/executor --context `docker` --destination bibinwilson/hello-kaniko:1.0
            '''
          }
      }
    }
  }
}