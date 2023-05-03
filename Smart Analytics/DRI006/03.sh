#!/bin/bash

source variables.inc

#/north_america_data

# Create Pub/Sub resources
#topic2=
#sub2=

#sourcecp=
#instance=
#username=
#password=
#ip=
#destinationcp=

# create a GCS to pubsub trigger
# /north_america_data

# Create Pub/Sub topic
gcloud pubsub topics create ${topic2}

gcloud pubsub subscriptions create $sub2 \
    --topic=${topic2}

# create GCS trigger
# https://www.cloudskillsboost.google/focuses/22950?locale=id&parent=catalog

gsutil notification create -f "json" -p "north_america_data/" -t "${topic2}" "gs://${GCS}"


# Create Datastream resources
# https://cloud.google.com/sdk/gcloud/reference/datastream/connection-profiles/create
gcloud services enable datastream.googleapis.com

#cp1
gcloud datastream connection-profiles create $sourcecp \
    --location=${REGION} --type=mysql \
    --mysql-password=${password} \
    --mysql-username=${username} \
    --display-name=${sourcecp} \
    --mysql-hostname=${instance} --mysql-port=3306 --static-ip-connectivity
# need to add ip allowlist

#cp2
gcloud datastream connection-profiles create $destinationcp \
    --location=${REGION} --type=google-cloud-storage \
    --bucket=${GCS} --root-path=/north_america_data \
    --display-name=${destinationcp}

# create the stream
#stream=

gcloud datastream streams create ${stream} --location=${REGION} \
          --display-name=${stream} --source=${sourcecp} \
          --destination=${destinationcp} \
          --backfill-all

# Deploy Dataflow job
# Stream_GCS_Text_to_BigQuery

#gcloud dataflow flex-template run dri0063 \
#    --project=${PROJECT_ID} \
#    --region=${REGION} \
#    --enable-streaming-engine \
#    --template-file-gcs-location=gs://dataflow-templates/latest/flex/Cloud_Datastream_to_BigQuery \
#    --parameters \
#inputFilePattern=gs://${GCS}/north_america_data/,\
#gcsPubSubSubscription=${sub2},\
#outputDatasetTemplate=${dataset}
  

gcloud dataflow flex-template run dri00603 \
     --template-file-gcs-location \
     gs://dataflow-templates-us-central1/latest/flex/Cloud_Datastream_to_BigQuery \
     --region us-central1  --parameters \
     inputFilePattern=gs://${GCS}/north_america_data/,\
     gcsPubSubSubscription=projects/${PROJECT_ID}/subscriptions/${sub2},\
     inputFileFormat=avro,outputStagingDatasetTemplate=${dataset},\
     outputDatasetTemplate=${dataset},deadLetterQueueDirectory=doo
