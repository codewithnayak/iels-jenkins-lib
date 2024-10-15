#!/bin/bash

echo "*** login****"

gcloud auth login

gcloud config set project keen-ally-438611-t7

gcloud container clusters get-credentials iels-gke-oct-jan --zone europe-west1-b --project keen-ally-438611-t7
