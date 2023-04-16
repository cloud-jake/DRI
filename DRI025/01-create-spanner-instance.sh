#!/bin/bash

source variables.inc

#01 - Spanner Instance
#InstanceName=
#DatabaseName=

# Create Spanner Instance
gcloud beta spanner instances create ${InstanceName} \
    --config=regional-${REGION} --processing-units=100 \
    --description="Migration Demo"

# Create Spanner Database
gcloud spanner databases create ${DatabaseName} \
    --instance=${InstanceName} \
    --ddl "CREATE TABLE Migration ( \
            Username STRING(1024) NOT NULL, \
            PointsEarned INT64, \
            ReminderDate DATE, \
            Subscribed BOOL, \
            Zipcode INT64, \
         ) PRIMARY KEY (Username)"
