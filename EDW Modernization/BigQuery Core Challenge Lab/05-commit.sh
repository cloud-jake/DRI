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

gcloud bigquery reservations commitments create $COMMIT_ID \
    --location=$COMMIT_LOCATION \
    --capacity-commitment-plan=ENTERPRISE \
    --duration=365d \
    --slot-count=100



# Create a reservation of 50 slots using the Baseline slots option for the Cymbal Investment’s data engineering team. 
# Name this reservation as Reservation Name, and assign Project Id to use this reservation for QUERY job type.

# create a 50 slot reservation named $RESERVATION_NAME in project PROJECT_ID for job type QUERY
gcloud bigquery reservations reservations create $RESERVATION_NAME \
    --location=$COMMIT_LOCATION \
    --slot-count=50 \
    --project=$PROJECT_ID \
    --job-type=QUERY

