#!/bin/bash

source variables.inc


#01 - Spanner Instance
#InstanceName=
#DatabaseName=

#02 - Prepare Migration
#PubSubTopic=
#SAname=

#03 - Migrate Dynamo
#IAMrole=

#04 - AWS Lambda
#LambdaFunction=

#05 - Perform Migration
#S3bucket=
#GCSbucket=
#LABGCPregion=${REGION}
#06 - Dataflow
#PubSubSubscription=

cd dynamodb-spanner-migration/dataflow/
mvn compile
mvn exec:java \
-Dexec.mainClass=com.example.spanner_migration.SpannerBulkWrite \
-Pdataflow-runner \
-Dexec.args="--project=${PROJECT_ID} \
             --instanceId=$InstanceName} \
             --databaseId=$DatabaseName} \
             --table=Migration \
             --importBucket=${GCSbucket} \
             --runner=DataflowRunner \
             --region=${REGION}"


#Setup a Dataflow job to write streaming data into Spanner

gcloud pubsub subscriptions create ${PubSubSubscription} \
    --topic ${PubSubTopic}

mvn exec:java \
-Dexec.mainClass=com.example.spanner_migration.SpannerStreamingWrite \
-Pdataflow-runner \
-Dexec.args="--project=${PROJECT_ID} \
             --instanceId=$InstanceName} \
             --databaseId=$DatabaseName} \
             --table=Migration \
             --experiments=allow_non_updatable_job \
--subscription=projects/${PROJECT_ID}/subscriptions/${PubSubSubscription} \
--runner=DataflowRunner \
--region=${REGION}"

# Verify Replication
aws dynamodb put-item \
    --table-name Migration \
    --item '{"Username" : {"S" : "my-test-username"}, "Subscribed" : {"BOOL" : false}}'





