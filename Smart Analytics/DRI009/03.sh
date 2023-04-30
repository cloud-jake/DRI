#!/bin/bash

source variables.inc

#

#SA1=
#SA2=
#SA3=

#PROJECT_ID

# Task 3 - Setup Service Accounts

gcloud iam service-accounts create $SA1 \
--description="upload data to GCS" \
--display-name=$SA1

gcloud projects add-iam-policy-binding $PROJECT_ID \
--member="serviceAccount:${SA1}@${PROJECT_ID}.iam.gserviceaccount.com" \
--role="roles/storage.objectCreator"


gcloud iam service-accounts create $SA2 \
--description="Dataflow GC to BQ" \
--display-name=$SA2

gcloud projects add-iam-policy-binding $PROJECT_ID \
--member="serviceAccount:${SA2}@${PROJECT_ID}.iam.gserviceaccount.com" \
--role="roles/storage.objectAdmin"

gcloud projects add-iam-policy-binding $PROJECT_ID \
--member="serviceAccount:${SA2}@${PROJECT_ID}.iam.gserviceaccount.com" \
--role="roles/dataflow.admin"



gcloud iam service-accounts create $SA3 \
--description="Trigger Dataflow" \
--display-name=$SA3

gcloud projects add-iam-policy-binding $PROJECT_ID \
--member="serviceAccount:${SA3}@${PROJECT_ID}.iam.gserviceaccount.com" \
--role="roles/dataflow.worker"

gcloud projects add-iam-policy-binding $PROJECT_ID \
--member="serviceAccount:${SA3}@${PROJECT_ID}.iam.gserviceaccount.com" \
--role="roles/storage.objectAdmin"

gcloud projects add-iam-policy-binding $PROJECT_ID \
--member="serviceAccount:${SA3}@${PROJECT_ID}.iam.gserviceaccount.com" \
--role="roles/bigquery.jobUser"

gcloud projects add-iam-policy-binding $PROJECT_ID \
--member="serviceAccount:${SA3}@${PROJECT_ID}.iam.gserviceaccount.com" \
--role="roles/bigquery.dataEditor"



gcloud iam service-accounts add-iam-policy-binding ${SA1}@${PROJECT_ID}.iam.gserviceaccount.com \
--member=user:$LAB_USER --role="roles/iam.serviceAccountTokenCreator"
gcloud iam service-accounts add-iam-policy-binding ${SA2}@${PROJECT_ID}.iam.gserviceaccount.com \
--member=user:$LAB_USER --role="roles/iam.serviceAccountTokenCreator"

gcloud iam service-accounts add-iam-policy-binding ${SA3}@${PROJECT_ID}.iam.gserviceaccount.com \
--member=serviceAccount:${SA2}@${PROJECT_ID}.iam.gserviceaccount.com \
--role="roles/iam.serviceAccountUser"


gcloud beta services identity create --service=dataflow.googleapis.com

gcloud iam service-accounts add-iam-policy-binding ${SA3}@${PROJECT_ID}.iam.gserviceaccount.com \
--member serviceAccount:service-${PROJ_NUM}@dataflow-service-producer-prod.iam.gserviceaccount.com \
--role roles/dataflow.serviceAgent