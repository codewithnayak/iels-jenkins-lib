#!/bin/bash
# Shell script to install a helm chart .
#

NEXUS_URL=$1
PASSWORD=$3
USERNAME=$2
CHART_VERSION=$4

echo '***** Helm installation started *****'

helm repo add nexus ${NEXUS_URL} --username ${USERNAME} --password ${PASSWORD}
helm repo update
helm upgrade --install dotnettestapi nexus/dotnettestapi \
    --version ${CHART_VERSION} \
    --set tag=${CHART_VERSION} \
    --install --force --debug

echo '***** Helm installation completed *****'
