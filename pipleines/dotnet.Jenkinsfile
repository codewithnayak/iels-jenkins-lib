@Library('first-small-lib') _

def NEXUS_URL = 'http://34.89.102.18/repository/helm-hosted/'

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
              helm package ./manifest --version=1.${BUILD_NUMBER}.0 --debug
              echo ${NEXUS_URL} 
              '''

              stash('chart',includes: '*.tgz')
          }
      }
      stage('Push Chart'){
      agent{
          kubernetes{
            yaml utilityPod()
            retries 2
          }
      }
      steps{
          container('utility'){
            unstash(name: 'chart')
            withCredentials([usernamePassword(credentialsId: 'nexus-credentials', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) 
            {
              sh '''
              curl -u $USERNAME:$PASSWORD ${NEXUS_URL} --upload-file dotnettestapi-1.${BUILD_NUMBER}.0.tgz -v 
              '''
            }
          }
      }
    }
  }
}

