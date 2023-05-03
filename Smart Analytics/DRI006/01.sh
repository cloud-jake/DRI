#!/bin/bash

source variables.inc

# Create a destination table in BigQuery
# bq --location=US mk -d $dataset
# Dataset already exists

bq mk \
 --table \
 ${dataset}.${table1} \
 files/table1.json



# https://cloud.google.com/bigquery/docs/cloud-storage-transfer#bq
# Configure BigQuery Data Transfer Service

# TODO: fix variable $table1 and path in the params below - within single quote
bq mk --transfer_config \
--target_dataset=${dataset} \
--display_name='My Transfer' \
--params='{"data_path_template":"gs://'${GCS}'/central_america_data/*.csv",
"destination_table_name_template":"'${table1}'",
"file_format":"CSV",
"max_bad_records":"1",
"ignore_unknown_values":"true",
"skip_leading_rows":"1"}' \
--data_source=google_cloud_storage

# need to make sure on-demand, not scheduled



bq mk --transfer_config \
--target_dataset=${dataset} \
--display_name='My Transfer' \
--params='{"data_path_template":"gs://qwiklabs-gcp-02-2b6368712817/central_america_data/*.csv",
"destination_table_name_template":"cym_ca_data",
"file_format":"CSV",
"max_bad_records":"1",
"ignore_unknown_values":"true",
"skip_leading_rows":"1"}' \
--data_source=google_cloud_storage