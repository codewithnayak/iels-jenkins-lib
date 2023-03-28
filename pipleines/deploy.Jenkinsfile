@Library('first-small-lib') _

pipeline{

    environment{
        NEXUS_URL = 'http://34.89.102.18/repository/helm-hosted/'
    }

    parameters{
        string(name:'CHART_VERSION' , defaultValue: '' , description: 'The chart to be deployed , without tgz extension')
        booleanParam(name:'APPROVED' , defaultValue: false , description: 'Approval for the deployment')
    }

    agent{
        kubernetes{
            yaml helmPod()
            retries 2
        }
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
                            dir('resources'){
                                sh "./deploy.sh ${env.NEXUS_URL} ${USERNAME} ${PASSWORD} ${params.CHART_VERSION} "
                            }
                        }
                        
                    }
                
                }
            }
        }
    }

}

