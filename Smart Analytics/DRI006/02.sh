#!/bin/bash

source variables.inc

# Create a destination table in BigQuery

bq mk \
 --table \
 ${dataset}.${table2} \
 files/table1.json


# Deploy a Dataflow streaming job
# https://cloud.google.com/dataflow/docs/tutorials/dataflow-stream-to-bigquery
gcloud services disable dataflow.googleapis.com
gcloud services enable dataflow.googleapis.com


gcloud dataflow jobs run dri006 \
    --gcs-location gs://dataflow-templates/latest/PubSub_to_BigQuery \
    --region $REGION \
    --parameters \
inputTopic=projects/${PROJECT_ID}/topics/$topic1,\
outputTableSpec=${PROJECT_ID}:${dataset}.${table2}
#    --staging-location gs://$GCS/temp \




echo "running pubsub pobsub publisher"

gsutil cp gs://dri006-edw-to-bq-data-source-integration/caribbean_report.sh . && chmod 555 caribbean_report.sh

bash caribbean_report.sh