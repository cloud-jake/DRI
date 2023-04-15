#!/bin/bash

source variables.inc

gcloud config set compute/zone $ZONE

git clone https://github.com/GoogleCloudPlatform/dynamodb-spanner-migration.git
cd dynamodb-spanner-migration

pip3 install virtualenv
virtualenv env
source env/bin/activate
pip3 install -r requirements.txt

echo "Perform AWS Setup"
echo ""
echo "RUN aws configure"
echo ""


