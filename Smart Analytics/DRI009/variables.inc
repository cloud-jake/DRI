#
#
LAB_REGION=
LAB_USER=

# task 1
GCS_DATA=
REGION_DATA=$LAB_REGION
GCS_CONFIG=
REGION_CONFIG=$LAB_REGION
GCS_TEMP=
REGION_TEMP=$LAB_REGION

# Task 2
BQ_DATASET=
BQ_REGION=$LAB_REGION


# Task 3
SA1=
SA2=
SA3=


# Task 4
NETWORK=
SUBNET=


# Task 5


# Task 6




PROJECT_ID=`gcloud config get-value project`
PROJ_NUM=$( gcloud projects describe $PROJECT_ID --format 'value(projectNumber)' )