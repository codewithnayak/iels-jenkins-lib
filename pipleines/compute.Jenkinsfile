
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

    parameters {
        booleanParam(name: 'APPLY_TERRAFORM', defaultValue: false, description: 'Apply Terraform changes')
        booleanParam(name: 'DESTROY_TERRAFORM', defaultValue: false, description: 'Destroy Terraform infrastructure')
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
                        dir('gce') {
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
                        dir('gce') {
                            sh("terraform plan -out=tfplan -input=false")
                        }
                        
                    }
                
                }
            }
        }
        stage("Apply"){
            when {
                expression {
                    return params.APPLY_TERRAFORM == true
                }
            }
            steps{
                script{
                    container(name: 'terraform'){
                        dir('gce') {
                           sh("terraform apply tfplan")
                        }
                        
                    }
                
                }
            }
        }

        stage("Destroy"){
            when {
                expression {
                    return params.DESTROY_TERRAFORM == true
                }
            }
            steps{
                script{
                    container(name: 'terraform'){
                        dir('gce') {
                           sh '''
                              terraform destroy -auto-approve
                             '''
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

        failure {
            echo 'Pipeline failed!'
        }

        success {
            echo 'Pipeline succeeded!'
        }
    }

}
