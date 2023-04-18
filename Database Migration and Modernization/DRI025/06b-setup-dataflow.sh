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

#Setup a Dataflow job to write streaming data into Spanner

gcloud pubsub subscriptions create ${PubSubSubscription} \
    --topic ${PubSubTopic}

mvn exec:java \
-Dexec.mainClass=com.example.spanner_migration.SpannerStreamingWrite \
-Pdataflow-runner \
-Dexec.args="--project=${PROJECT_ID} \
             --instanceId=${InstanceName} \
             --databaseId=${DatabaseName} \
             --table=Migration \
             --experiments=allow_non_updatable_job \
--subscription=projects/${PROJECT_ID}/subscriptions/${PubSubSubscription} \
--runner=DataflowRunner \
--region=${REGION}"

# Verify Replication
aws dynamodb put-item \
    --table-name Migration \
    --item '{"Username" : {"S" : "my-test-username"}, "Subscribed" : {"BOOL" : false}}'



echo "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
echo ""
echo "Run this command"
echo ""
#echo "gcloud spanner databases execute-sql cymbaldb \
#    --instance=cymbal-direct-instance \
#    --sql="SELECT * FROM Migration WHERE Username='my-test-username'"

