#!/bin/bash

# CURRENT GKE DETAILS
PROJECT_ID="imposing-aspect-447113-h4"
ZONE="europe-west1-b"
CLUSTER_NAME="iels-kcl-jan-apr"
NODE_POOL_NAME="iels-kcl-pool"
NUM_NODES=0 # Number of nodes to scale down to

# Authenticate with GCP
gcloud auth login

# Set the project
gcloud config set project $PROJECT_ID

# Scale down the node pool
gcloud container clusters resize $CLUSTER_NAME \
    --node-pool $NODE_POOL_NAME \
    --num-nodes $NUM_NODES \
    --zone $ZONE \
    --quiet

echo "Scaled down the node pool $NODE_POOL_NAME in cluster $CLUSTER_NAME to $NUM_NODES nodes."
