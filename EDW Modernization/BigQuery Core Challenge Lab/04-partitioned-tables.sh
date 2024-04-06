#!/bin/bash

source variables.env

# Task 4. Create partitioned and clustered tables

# In this task, create a BigQuery table named <Table Name 2> under <BigQuery Dataset Name> dataset, 
# consisting of data present in BigQuery <BigQuery Table Name> table partitioned by TradeDate and clustered by Symbol.

# create a bigquert table named FOO from the query SELECT * FROM GOO partitioned by TradeDate and clustered by Symbol
bq query \
    --use_legacy_sql=false \
    --location=US \
    --destination_table=$DATASET.$TABLE_NAME2 \
    --time_partitioning_field="TradeDate" \ 
    --time_partitioning_type="DAY" \
    --clustering_fields="Symbol" \
    "SELECT * FROM $DATASET.$TABLE_NAME"



# bq query     --use_legacy_sql=false     --location=US     --destination_table=$DATASET.$TABLE_NAME2     --time_partitioning_field="TradeDate"     --time_partitioning_type="DAY"     --clustering_fields="Symbol"     "SELECT * FROM $DATASET.$TABLE_NAME"


    # create a partitioned table partitioned by ethe FFFFFF field
bq mk \
    --location=US \
    --time_partitioning_type=DAY \
    $DATASET.$TABLE_NAME3