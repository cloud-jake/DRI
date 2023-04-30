#!/bin/bash

source variables.inc

# Task 5 - Data files creation

gsutil cp files/data.csv gs://${GCS_DATA}
gsutil cp files/data_schema.json gs://${GCS_CONFIG}
gsutil cp files/data_udf.js gs://${GCS_CONFIG}


