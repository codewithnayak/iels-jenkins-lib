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
            image: mcr.microsoft.com/dotnet/sdk:6.0-alpine
        '''
      retries 2
    }
  }
  stages {
    stage('Run dotnet') {
      steps {
        container('dotnetcore') {
          sh 'dotnet -version'
        }
      }
    }
  }
}