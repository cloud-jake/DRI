#!/bin/bash

source variables.inc

# Task 6 - Dataflow job execution on the created infrastructure

#enable Dataflow API

gcloud services enable dataflow.googleapis.com

# In this step, we expect you to run a Dataflow job in Lab GCP Region region 
# using the Google provided template file to import data from GCS to BigQuery.

gcloud dataflow jobs run dri009 \
    --gcs-location gs://dataflow-templates/latest/GCS_Text_to_BigQuery \
    --region $LAB_REGION \
    --parameters \
javascriptTextTransformFunctionName=transform,\
JSONPath=gs://${GCS_CONFIG}/data_schema.json,\
javascriptTextTransformGcsPath=gs://${GCS_CONFIG}/data_udf.js,\
inputFilePattern=gs://${GCS_DATA}/data.csv,\
outputTable=${PROJECT_ID}:${BQ_DATASET}.footable,\
bigQueryLoadingTemporaryDirectory=gs://${GCS_TEMP}