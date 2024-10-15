#!/bin/bash

# Variables
PROJECT_ID="keen-ally-438611-t7"
ZONE="europe-west1-b"
CLUSTER_NAME="iels-gke-oct-jan"
NODE_POOL_NAME="default-pool"
NUM_NODES=1 # Number of nodes to scale down to

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

echo "Scaled up the node pool $NODE_POOL_NAME in cluster $CLUSTER_NAME to $NUM_NODES nodes."
