#!/bin/bash
set -e

echo "***** Conect to cluster ******"

##CURRENT GKE CLUSTER DETAILS
gcloud container clusters get-credentials iels-kcl-jan-apr --zone europe-west1-b --project imposing-aspect-447113-h4

echo "***** TRY TO INSTALL JENKINS ******"

helm repo add jenkins https://charts.jenkins.io
helm repo update

helm upgrade --namespace jenkins --create-namespace --install -f jenkins-values.yaml iels-jenkins jenkins/jenkins

kubectl get po -n jenkins

kubectl exec --namespace jenkins -it svc/iels-jenkins -c jenkins -- /bin/cat /run/secrets/additional/chart-admin-password && echo
