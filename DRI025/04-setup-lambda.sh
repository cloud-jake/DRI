#!/bin/bash

source variables.inc

#04 - AWS Lambda
#LambdaFunction=

#Create a variable to capture the Amazon Resource Name (ARN) 
LAMBDA_ROLE=$(aws iam list-roles \
    --query 'Roles[?RoleName==`${IAMrole}`].[Arn]' \
    --output text)
#fixme - quotes for IAMrole


# Use the pubsub-lambda.zip package to create the AWS Lambda function.
aws lambda create-function --function-name ${LambdaFunction}  \
    --runtime python3.9 --role ${LAMBDA_ROLE} \
    --handler ddbpubsub.lambda_handler --zip fileb://pubsub-lambda.zip \
    --environment Variables="{SVCACCT=$(base64 -w 0 credentials.json),PROJECT=${PROJECT_ID},TOPIC=$PubSubTopic}"


# Create a variable to capture the ARN of the Amazon DynamoDB stream for your table.
STREAMARN=$(aws dynamodb describe-table \
    --table-name Migration \
    --query "Table.LatestStreamArn" \
    --output text)

# Attach Lambda function to DynamoDB Table
aws lambda create-event-source-mapping --event-source ${STREAMARN} \
    --function-name ${LambdaFunction} --enabled \
    --starting-position TRIM_HORIZON
