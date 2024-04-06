#!/bin/bash

source variables.env

# The Data Engineering team requires logs related to <BigQuery dataset> used in the organization. 
# Therefore, the first task is to create a Cloud Logging sink to store all the logs related to BigQuery at a single location.

#Therefore in this task, you should create;
# - A BigQuery dataset named <BigQuery Dataset Name> in US location.

#create a bigquery dataset nanmed $DATASET in location US
bq mk --location=US $DATASET

# - A Cloud Logging sink named Cloud Loggin Sink Name to route all logs related to BigQuery to BigQuery Dataset Name dataset.
# create a service account named bq-sink
gcloud iam service-accounts create bq-sink

# give the SA bq-sink the bigquery editor role
gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member="serviceAccount:bq-sink@$PROJECT_ID.iam.gserviceaccount.com" \
    --role="roles/bigquery.dataEditor"  


# create a Cloud Logging sink named Cloud Loggin Sink Name to route all logs related to BigQuery to BigQuery Dataset Name dataset.
gcloud logging sinks create $SINKNAME \
    bigquery.googleapis.com/projects/$PROJECT_ID/datasets/$DATASET \
    --log-filter="logName : projects/$PROJECT_ID/logs/cloudaudit.googleapis.com%2Factivity" \
    --service-account="bq-sink@$PROJECT_ID.iam.gserviceaccount.com"
