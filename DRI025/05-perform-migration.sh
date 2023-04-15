#!/bin/bash

source variables.inc

#05 - Perform Migration
#S3bucket=
#GCSbucket=
#LABGCPregion=${REGION}

# Create S3 bucket
aws s3 mb s3://${S3bucket}

# Create GCS Bucket
gsutil mb -l ${REGION} gs://${GCSbucket}

# export the DynamoDB table with PITR
echo ""
echo "In the AWS Management Console, go to DynamoDB, and click Tables."

echo "Click the Migration table."

echo "Under the Exports and stream tab, click Export to S3."

echo "Enable point-in-time-recovery (PITR) if prompted."

echo "Click Browse S3 to choose the S3 bucket you created earlier."

echo "Click Export."
