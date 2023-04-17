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

}

​def buildTags(servcieTagValue,featureTagValue){
    if(!servcieTagValue && !featureTagValue){
        throw new Exception('Need to select at least one tag')
    }
    def serviceTagResult = constructTags(servcieTagValue)
    def featureTagResult = constructTags(featureTagValue)
    if(!serviceTagResult) return featureTagResult 
    return '{' + serviceTagResult + (featureTagResult ? ' and '+ featureTagResult : "") + '}'
}
def constructTags(tagValues){
   if(!tagValues) return null
   def result = tagValues.trim().split(',').collect{'@'+it }.join(' or ')
   if(result.contains(' or ')){
        result = '('+ result +')'
    }
   return result
}
