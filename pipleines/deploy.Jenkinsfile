@Library('first-small-lib') _




pipeline{

    environment{
        NEXUS_URL = 'http://34.89.102.18/repository/helm-hosted/'
    }

    parameters{
        string(name:'CHART_VERSION' , defaultValue: '' , description: 'The chart to be deployed , without tgz extension')
        booleanParam(name:'APPROVED' , defaultValue: false , description: 'Approval for the deployment')
        extendedChoice(name:'FEATURE_TAGS',defaultValue: 'regression',multiSelectDelimiter: ',',type:'PT_CHECKBOX' , value: 'someservcie,anotherservice')
        extendedChoice(name:'SERVICE_TAGS',defaultValue: 'somefeature',multiSelectDelimiter: ',',type:'PT_CHECKBOX' , value: 'somefeature,anotherfeature')
    }

    agent{
        kubernetes{
            yaml helmPod()
            retries 2
        }
    }

    options {
        skipDefaultCheckout(true)
    }
    
    stages{
        stage("Deploy"){
            steps{
                script{
                    container(name: 'helm'){
                        withCredentials([usernamePassword(credentialsId: 'nexus-credentials',
                         usernameVariable: 'USERNAME', 
                         passwordVariable: 'PASSWORD')]) 
                        {
                            println buildTags(params.SERVICE_TAGS,params.FEATURE_TAGS) 
                        }
                        
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
