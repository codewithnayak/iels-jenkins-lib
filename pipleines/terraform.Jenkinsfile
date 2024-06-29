library identifier: 'custom-lib@main', retriever: modernSCM(
  [$class: 'GitSCMSource',
   remote: 'https://github.com/codewithnayak/iels-jenkins-shared.git'])

pipeline{

    agent{
        kubernetes{
            yamlFile './pipelines/template/terraform.yaml'
            retries 2
        }
    }

    options {
        skipDefaultCheckout(true)
    }

    stages{
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
