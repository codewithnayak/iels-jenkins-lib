
pipeline{

    agent{
        kubernetes{
            yamlFile 'pipleines/templates/terraform.yaml'
            retries 2
        }
    }

    options {
        skipDefaultCheckout(true)
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
                        dir('bucket') {
                            sh('terraform version')
                            sh 'ls -l '
                            sh 'terraform init'
                            sh """
                            terraform init
                            terraform plan  -out=tfplan -input=false -var region='europe-west2'
                            terraform apply tfplan -auto-approve -input=false
                            """
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
