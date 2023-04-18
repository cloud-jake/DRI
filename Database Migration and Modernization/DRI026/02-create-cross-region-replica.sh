#!/bin/bash

#

source variables.inc

# Task 1. Create the database
#INSTANCE_ID=
#PASSWORD=
#REGION1=
#GCS_BUCKET=

# Task 2. Deploy a cross-region read replica
#REPLICA1=
#REGION2=

# Task 2. Deploy a cross-region read replica

gcloud sql instances create ${REPLICA1} \
    --master-instance-name=${INSTANCE_ID} \
    --region=${REGION2} \
    --availability-type="REGIONAL"

