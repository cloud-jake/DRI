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

# give the SA bq-sink permission to create tables in BQ dataset $DATASET using the bq command
# run the following SQL command in BigQuery:
# GRANT `roles/bigquery.dataViewer`
# ON SCHEMA `myProject`.myDataset
# TO "user:raha@example-pet-store.com", "user:sasha@example-pet-store.com"
bq query \
    --use_legacy_sql=false \
    --project_id=$PROJECT_ID \
    "GRANT `roles/bigquery.dataEditor` ON SCHEMA \`$PROJECT_ID\`.\`$DATASET\` TO `serviceAccount:bq-sink@$PROJECT_ID.iam.gserviceaccount.com`"

## maybe dont need to do the?
# GRANT `roles/bigquery.dataEditor` 
# ON SCHEMA  cymbal_dataset 
# TO "serviceAccount:bq-sink@$PROJECT_ID.iam.gserviceaccount.com"



# create a Cloud Logging sink named Cloud Loggin Sink Name to route all logs related to BigQuery to BigQuery Dataset Name dataset.
gcloud logging sinks create $SINKNAME \
    bigquery.googleapis.com/projects/$PROJECT_ID/datasets/$DATASET \
    --log-filter="logName : projects/$PROJECT_ID/logs/cloudaudit.googleapis.com%2Factivity" \
    --service-account="bq-sink@$PROJECT_ID.iam.gserviceaccount.com"



##### Please remember to grant `serviceAccount:service-63696229415@gcp-sa-logging.iam.gserviceaccount.com` the BigQuery Data Editor role on the dataset.
# Construct this for next ttime
#GRANT `roles/bigquery.dataEditor` 
#ON SCHEMA  cymbal_dataset 
#TO "serviceAccount:service-63696229415@gcp-sa-logging.iam.gserviceaccount.com"

