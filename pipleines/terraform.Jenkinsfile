@Library('first-small-lib') _

pipeline{

    agent{
        kubernetes{
            yaml terraformPod()
            retries 2
        }
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
