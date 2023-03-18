@Library('first-small-lib') _
def imgVersion = ''
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
      string(name:'IMG_VERSION', defaultValue:'', description: 'The image version , if not provided it will be the build number')
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
            imgVersion = getBuildNumber(params.IMG_VERSION)
            echo imgVersion
            sh '''
            /kaniko/executor --context . --destination sekharinweb/ielsmanager:${imgVersion}
            '''
          }
      }
    }
  }
}

def getBuildNumber(imageVersion){
  if(imageVersion == ''){
    return env.BUILD_NUMBER
  }
  return imageVersion
}