#!/bin/bash

source variables.inc

#05 - Perform Migration
#S3bucket=
#GCSbucket=
#LABGCPregion=${REGION}


gsutil rsync -d -r s3://${S3bucket} gs://${GCSbucket}
