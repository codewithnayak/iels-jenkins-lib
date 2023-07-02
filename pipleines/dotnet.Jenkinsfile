@Library('first-small-lib') _
pipeline {

  environment{
      NEXUS_URL = 'http://34.89.102.18/repository/helm-hosted/'
  }

  agent {
    kubernetes {
      yaml dotnetKanikoPod()
      retries 2
    }
  }

  parameters{
      string(name:'BRANCH_NAME', defaultValue: 'main' , description: 'he branch to be built')
      string(name:'SERVICE_NAME',defaultValue:'dotnet-helm-k8-ci-cd',description: 'The service to be built.')
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
            stash(name: 'helm' , includes: '**/manifest/')
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
          script{
            container('helm'){
            unstash(name: 'helm')
            sh '''
              helm package ./manifest/ --version=1.${BUILD_NUMBER}.0 
              '''

              stash(name:'chart',includes: '*.tgz')
          }
        }
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
          script{
            container('utility'){
            unstash(name: 'chart')
            withCredentials([usernamePassword(credentialsId: 'nexus-credentials', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) 
            {
              sh """
              curl -u ${USERNAME}:${PASSWORD} ${env.NEXUS_URL} --upload-file dotnettestapi-1.${BUILD_NUMBER}.0.tgz -v 
              """
            }
          }
        }
      }

      
    }
    post {
        // Clean after build
        always {
            cleanWs(cleanWhenNotBuilt: false,
                    deleteDirs: true,
                    disableDeferredWipeout: true,
                    notFailBuild: true,
                    patterns: [[pattern: '.gitignore', type: 'INCLUDE'],
                               [pattern: '.propsfile', type: 'EXCLUDE']])
        }
    }
  }
}

