#!/bin/bash
set -e

echo "***** Conect to cluster ******"

##This will change based on your cluater
gcloud container clusters get-credentials iels-gke-oct-jan --zone europe-west1-b --project keen-ally-438611-t7

echo "***** TRY TO INSTALL JENKINS ******"

helm repo add jenkins https://charts.jenkins.io
helm repo update

helm upgrade --namespace jenkins --create-namespace --install -f jenkins-values.yaml iels-jenkins jenkins/jenkins

kubectl get po -n jenkins

kubectl exec --namespace jenkins -it svc/iels-jenkins -c jenkins -- /bin/cat /run/secrets/additional/chart-admin-password && echo
