#!/bin/bash

source variables.inc

#03 - Migrate Dynamo
#IAMrole=

#PubSubTopic=


# Enable Amazon DynamoDB streams on the source table,
pip3 install --ignore-installed --target=lambda-deps google-cloud-pubsub

cd lambda-deps; zip -r9 ../pubsub-lambda.zip *; cd -

zip -g pubsub-lambda.zip ddbpubsub.py

# Create AWS IAM Role

echo "Create an AWS IAM role for AWS Lambda"
echo ""
echo "In the AWS console, go to the IAM section, click Roles, and then select Create role."
echo "Under Trusted entity type, ensure that AWS service is selected."
echo "Under Use case, select Lambda, and then click Next."
echo "In the Permission policies filter box, enter AWSLambdaDynamoDBExecutionRole and press Return to search."
echo "Select the AWSLambdaDynamoDBExecutionRole checkbox, and then click Next."
echo "In the Role name box, enter ${IAMrole} , and then click Create role."

aws dynamodb update-table --table-name Migration \
    --stream-specification StreamEnabled=true,StreamViewType=NEW_AND_OLD_IMAGES
