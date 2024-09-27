
pipeline{

    agent{
        kubernetes{
            yamlFile 'pipleines/templates/terraform.yaml'
            retries 2
        }
    }

    options {
        skipDefaultCheckout(true)
        ansiColor('xterm')
    }

    stages{
        stage('Git Checkout') {
            steps {
                checkout([$class: 'GitSCM',
                          branches: [[name: '*/main']],
                          userRemoteConfigs: [[
                              url: 'https://github.com/codewithnayak/iels-resources-gcp.git',  // Git repository URL
                          ]]
                ])
            }
        }
        stage("Init"){
            steps{
                script{
                    container(name: 'terraform'){
                        dir('iam') {
                            sh("terraform init -input=false")
                        }
                        
                    }
                
                }
            }
        }

        stage("Plan"){
            steps{
                script{
                    container(name: 'terraform'){
                        dir('iam') {
                            sh("terraform plan -out=tfplan -input=false")
                        }
                        
                    }
                
                }
            }
        }
        stage("Apply"){
            steps{
                script{
                    container(name: 'terraform'){
                        dir('iam') {
                            sh("terraform apply tfplan")
                        }
                        
                    }
                
                }
            }
        }
    }

    post {
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
