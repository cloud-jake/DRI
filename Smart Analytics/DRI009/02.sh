#!/bin/bash

source variables.inc

#

# Task 2 - Create BigQuery dataset

#BQ_DATASET=
#BQ_REGION=$LAB_REGION

bq mk --data_location=$BQ_REGION $BQ_DATASET