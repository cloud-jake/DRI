#
#
LAB_REGION=
LAB_USER=

# task 1
NETWORK=

# Task 2
SUBNET=

# Task 3
ROUTER=

# Task 4
DNSPOLICY=


PROJECT_ID=`gcloud config get-value project`
PROJ_NUM=$( gcloud projects describe $PROJECT_ID --format 'value(projectNumber)' )


