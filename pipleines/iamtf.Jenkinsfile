
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
                            try{
                                sh("terraform init -input=false")
                            }
                            catch(Exception e){
                                println("Error"+e)
                            }
                            
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
                            try{
                                sh("terraform plan -out=tfplan -input=false")
                            }
                            catch(Exception e){
                                println("Error"+e)
                            }
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
                           try{
                             sh("terraform apply tfplan")
                           }
                           catch(Exception e){
                            println("Error"+e)
                           }
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
