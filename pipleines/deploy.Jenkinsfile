@Library('first-small-lib') _


def constructTags(servcieTagValue , featureTagValue){
    def serviceTagResult
    def featureTagResult

    if(!servcieTagValue && !featureTagValue){
        throw new Exception('Need to select at least one tag')
    }

    if(servcieTagValue){
        serviceTagResult = servcieTagValue.trim().split(',').collect{ it => '@'+it }.join(' or ')
    }

    if(featureTagValue){
        featureTagResult = featureTagValue.trim().split(',').collect{ it=> '@'+it }.join(' or ')
    }

    if(serviceTagResult.contains('or')){
        serviceTagResult = '('+ serviceTagResult +')'
    }

    if(featureTagResult.contains('or')){
        featureTagResult = '('+ featureTagResult +')'
    }

    return  serviceTagResult + (featureTagResult ? featureTagResult : "");
}
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

    stages{
        stage("Deploy"){
            steps{
                script{
                    container(name: 'helm'){
                        withCredentials([usernamePassword(credentialsId: 'nexus-credentials',
                         usernameVariable: 'USERNAME', 
                         passwordVariable: 'PASSWORD')]) 
                        {
                            println params.SERVICE_TAGS
                            println params.FEATURE_TAGS

                            def resultantTags = constructTags(params.SERVICE_TAGS , params.FEATURE_TAGS)
                            println resultantTags 
                        }
                        
                    }
                
                }
            }
        }
    }

}

