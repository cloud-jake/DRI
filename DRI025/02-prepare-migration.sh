#!/bin/bash

source varibles.inc

#02 - Prepare Migration
#PubSubTopic=
#SAname=
##SAemail=

# Create Pub/Sub topic
gcloud pubsub topics create ${PubSubTopic}


# Create IAM SA
gcloud iam service-accounts create ${SAname} \
    --display-name="Spanner Migration"

# Create IAM Policy Binding
gcloud projects add-iam-policy-binding ${PROJECT_ID} \
    --role roles/pubsub.publisher \
    --member serviceAccount:${SAname}@${PROJECT_ID}.iam.gserviceaccount.com

# Create Credentials for SA
gcloud iam service-accounts keys create credentials.json \
    --iam-account ${SAname}@${PROJECT_ID}.iam.gserviceaccount.com
