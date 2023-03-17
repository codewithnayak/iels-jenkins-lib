@library('first-small-lib') _
pipeline {
  agent {
    kubernetes {
      yaml '''
        apiVersion: v1
        kind: Pod
        metadata:
          labels:
            some-label: dotnet-label-value
        spec:
          containers:
          - name: dotnetcore
            image: mcr.microsoft.com/dotnet/sdk:6.0
            command:
            - cat
            tty: true
        '''
      retries 2
    }
  }
  stages {
    stage('Checkout') {
      steps {
        container('dotnetcore') {
            call('main')
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