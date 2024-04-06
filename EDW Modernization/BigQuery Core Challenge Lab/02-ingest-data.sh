#!/bin/bash

source variables.env


#Task 2. Ingest data into BigQuery dataset and analyze data
#The next task is to ingest data into BigQuery table named <BigQuery Table Name> table under <BigQuery Dataset Name> dataset. 
#The data to be ingested into this table is present in the form of a CSV file named cymbal_investments_report.csv in the Storage Bucket Name <Cloud Storage bucket>.

#Once the table is ingested with data, analyze the table to understand data and schema.

CSVPATH="gs://${BUCKET_NAME}/cymbal_investments_report.csv"

# load data into a new BigQuery table named $TABLE_NAME from the CSV file in storage bucket $CSVPATH
bq load \
    --source_format=CSV \
    --location=US \
    --autodetect \
    $DATASET.$TABLE_NAME \
    $CSVPATH

# analyze the table to understand data and schema
bq show \
    --format=prettyjson \
    $DATASET.$TABLE_NAME