#!/bin/bash

source variables.env

# Enable BigQuery Reservation API.
gcloud services enable bigqueryreservation.googleapis.com


# Create a BigQuery slot commitment as per the following configuration.
# Commmitment ID = $COMMIT_ID
# Location = $COMMIT_LOCATION
# Capacity Model = Enterprise
# Duration = 1 year
# Slot Count = 100

bq mk \
    --project_id=$PROJECT_ID \
    --location=$COMMIT_LOCATION \
    --capacity_commitment=true \
    --edition=ENTERPRISE \
    --plan=ANNUAL \
    --renewal_plan=NONE \
    --slots=100


# Create a reservation of 50 slots using the Baseline slots option for the Cymbal Investment’s data engineering team. 
# Name this reservation as Reservation Name, and assign Project Id to use this reservation for QUERY job type.

# create a 50 slot reservation named $RESERVATION_NAME in project PROJECT_ID for job type QUERY
bq mk \
    --project_id=$PROJECT_ID \
    --location=$COMMIT_LOCATION \
    --reservation \
    --slots=50 \
    --job_type=QUERY \
    $RESERVATION_NAME


bq mk \
    --project_id=$PROJECT_ID \
    --location=$COMMIT_LOCATION \
    --reservation_assignment \
    --reservation_id=$RESERVATION_NAME \
    --assignee_id=$PROJECT_ID \
    --job_type=QUERY \
    --assignee_type=PROJECT


