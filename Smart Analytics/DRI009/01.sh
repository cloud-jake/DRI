#!/bin/bash

source variables.inc

# Task 1 - Create Cloud Storag eBuckets

#GCS_DATA=
#REGION_DATA=$LAB_REGION
#GCS_CONFIG=
#REGION_CONFIG=$LAB_REGION
#GCS_TEMP=
#REGION_TEMP=$LAB_REGION


gsutil mb -l $REGION_DATA $GCS_DATA
gsutil mb -l $REGION_CONFIG $GCS_CONFIG
gsutil mb -l $REGION_TEMP $GCS_TEMP

