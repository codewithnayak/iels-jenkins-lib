#!/bin/sh
# As alpine image , it does not have bash .Need to install bash if required .
# Shell script to install a helm chart .
# Params used

NEXUS_URL=$1
PASSWORD=$3
USERNAME=$2
CHART_VERSION=$4

echo '***** Helm installation started *****'

helm repo add nexus ${NEXUS_URL} --username ${USERNAME} --password ${PASSWORD}
helm repo update
helm upgrade dotnettestapi nexus/dotnettestapi \
    --namespace dev \
    --version ${CHART_VERSION} \
    --set tag=${CHART_VERSION} \
    --install --force --debug

echo '***** Helm installation completed *****'
