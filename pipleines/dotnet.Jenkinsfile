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
      string(name:'SERVICE_NAME',defaultValue:'',description: 'The service to be built.')
      string(name:'IMG_VERSION', defaultValue:'', description: 'The image version , if not provided it will be the build number.')
      string(name:'IMG_NAME',defaultValue:'dotnettestapi',description:'Give the desired image name here.')
  }
  

  stages {
    stage('Checkout') {
      steps {
        git url: 'https://github.com/codewithnayak/${SERVICE_NAME}.git' , branch: '${BRANCH_NAME}'
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
            /kaniko/executor --context . --destination sekharinweb/${IMG_NAME}:1.${BUILD_NUMBER}.0
            '''
            stash(name: 'helm' , includes: '**/manifest/*')
          }
      }
    }

    stage('Package'){
      agent{
          kubernetes{
            yaml helmPod()
            retries 2
          }
      }
      steps{
          container('helm'){
            unstash(name: 'helm')
            sh '''
            ls -l 
            helm template ./manifest
            '''
          }
      }
    }
  }
}

