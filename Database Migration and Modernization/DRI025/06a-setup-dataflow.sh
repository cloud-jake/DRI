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

#Because this can be an issue....
gcloud services  disable dataflow.googleapis.com
gcloud services  enable dataflow.googleapis.com

cd dynamodb-spanner-migration/dataflow/
mvn compile
mvn exec:java \
-Dexec.mainClass=com.example.spanner_migration.SpannerBulkWrite \
-Pdataflow-runner \
-Dexec.args="--project=${PROJECT_ID} \
             --instanceId=${InstanceName} \
             --databaseId=${DatabaseName} \
             --table=Migration \
             --importBucket=${GCSbucket} \
             --runner=DataflowRunner \
             --region=${REGION}"


# Verify
aws dynamodb describe-table --table-name Migration --query Table.ItemCount

gcloud spanner databases execute-sql ${DatabaseName} \
--instance=${InstanceName} --sql="select count(*) from Migration"



