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
                        sh """
                        echo '***** Deployment started ******'
                        helm repo add nexus ${env.NEXUS_URL}
                        helm repo update 

                        helm upgrade --install dotnettestapi nexus/dotnettestapi \
                            --version ${params.CHART_VERSION} \
                            --set tag=${params.CHART_VERSION} \
                            --install --force \

                        echo '***** Deployment completed ******'
                        """
                    }
                
                }
            }
        }
    }

}

