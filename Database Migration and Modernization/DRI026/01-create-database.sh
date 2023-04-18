#!/bin/bash

#
#INSTANCE_ID=
#PASSWORD=
#REGION1=
#GCS_BUCKET=

source variables.inc

# Create a Cloud SQL for MySQL instance

# --tier="db-n1-standard-2" \

gcloud sql instances create ${INSTANCE_ID} \    
    --region=${REGION1} \
    --availability-type="REGIONAL" \
    --enable-bin-log

gcloud sql users set-password root \
    --host=% \
    --instance ${INSTANCE_ID} \
    --password ${PASSWORD}


# Import data to the Cloud SQL for MySQL instance
## First grant permissions to service account
SVC_EMAIL_ADDRESS=$(gcloud sql instances describe ${INSTANCE_ID} --format='value(serviceAccountEmailAddress)') 
echo $SVC_EMAIL_ADDRESS

gsutil iam ch serviceAccount:${SVC_EMAIL_ADDRESS}:objectViewer gs://${GCS_BUCKET}

gcloud sql import sql ${INSTANCE_ID} gs://${GCS_BUCKET}/employees.sql

