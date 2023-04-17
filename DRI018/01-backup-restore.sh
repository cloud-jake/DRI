#!/bin/bash

source variables.inc



##############################################
# Task 1. Perform a backup/restore migration


#RDS_INSTANCE=
#SQL_INSTANCE=

#DB=AdventureWorks2017

#AWS_BUCKET=
#GCP_BUCKET=

#RDS_USER=
#RDS_PASSWORD=

#SQL_USER=
#SQL_PASSWORD=

#GCE_VM_INSTANCE=


# Create AWS and GCP Buckets
# Create S3 bucket
echo "Creating AWS S3 bucket..."
aws s3 mb s3://${AWS_BUCKET}

# Create GCS Bucket
echo "Creating GCP GCS bucket..."
gsutil mb -l ${REGION} gs://${GCP_BUCKET}


# Setting up for native backup and restore
# https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/SQLServer.Procedural.Importing.html

echo "Open ${GCE_VM_INSTANCE} in Compute Engine: https://console.cloud.google.com/compute/instances"
echo "Issue the following command:"
echo ""
echo "exec msdb.dbo.rds_backup_database
@source_db_name='${DB}',
@s3_arn_to_backup_to='arn:aws:s3:::${AWS_BUCKET}/backup1.bak',
@overwrite_s3_backup_file=1,
@type='FULL';"
echo ""
echo "Press ENTER when done"
read varname






# Create a backup of the AdventureWorks2017 database and store it in the AWS S3 bucket named AWS Bucket Name.
#exec msdb.dbo.rds_backup_database
#@source_db_name='${DB}',
#@s3_arn_to_backup_to='arn:aws:s3:::${AWS_BUCKET}/backup1.bak',
#@overwrite_s3_backup_file=1,
#@type='FULL';







# Move this backup file for AdventureWorks2017 database to the Google Cloud Storage bucket named GCS Bucket Name.
gsutil rsync -d -r s3://${AWS_BUCKET} gs://${GCP_BUCKET}






# Import the database to the SQL instance Cloud SQL instance, using the backup file stored in GCS Bucket Name bucket. Name the database as AdventureWorks2017 in Cloud SQL instance.

# Hint: The Microsoft Server SQL Management (SSMS) tool is available in the Google Compute Engine VM instance named GCE VM Instance to access the database.
# 


