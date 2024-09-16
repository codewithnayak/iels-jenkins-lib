#!/bin/bash
set -e

echo "***** Conect to cluster ******"

##This will change based on your cluater
gcloud container clusters get-credentials iels-gke-eu-cluster --zone europe-west2-a --project primeval-nectar-431120-j5

echo "***** TRY TO INSTALL JENKINS ******"

helm repo add jenkins https://charts.jenkins.io
helm repo update

helm upgrade --namespace jenkins --create-namespace --install -f jenkins-values.yaml iels-jenkins jenkins/jenkins

kubectl get po -n jenkins

kubectl exec --namespace jenkins -it svc/iels-jenkins -c jenkins -- /bin/cat /run/secrets/additional/chart-admin-password && echo
