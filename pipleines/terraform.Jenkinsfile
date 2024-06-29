
pipeline{

    agent{
        kubernetes{
            yamlFile 'pipelines/template/terraform.yaml'
            retries 2
        }
    }

    options {
        skipDefaultCheckout(true)
    }

    stages{
        stage("Env"){
            steps{
                script{
                    sh 'ls -l '
                }
            }
        }
        stage("Init"){
            steps{
                script{
                    container(name: 'terraform'){
                        sh('terraform version')
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
