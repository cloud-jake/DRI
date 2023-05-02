#!/bin/bash

source variables.inc

# Create a destination table in BigQuery
bq --location=US mk -d $dataset

bq mk \
 --table \
 ${dataset}.${table1} \
 files/table1.json



# https://cloud.google.com/bigquery/docs/cloud-storage-transfer#bq
# Configure BigQuery Data Transfer Service


bq mk --transfer_config \
--target_dataset=${dataset} \
--display_name='My Transfer' \
--params='{"data_path_template":"gs://${GCS}/central_america_data/*.csv",
"destination_table_name_template":"${table}",
"file_format":"CSV",
"max_bad_records":"1",
"ignore_unknown_values":"true",
"field_delimiter":"|",
"quote":";",
"skip_leading_rows":"1",
"allow_quoted_newlines":"true",
"allow_jagged_rows":"false",
"delete_source_files":"true"}' \
--data_source=google_cloud_storage