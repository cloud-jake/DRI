#!/bin/bash

source variables.inc

# Task 13: Delete VPC default route

# get the default routes to delete:
#gcloud compute routes list --filter="network=${NETWORK}" --filter="destRange=('0.0.0.0/0')" --format=json
#gcloud compute routes list --filter="destRange=('0.0.0.0/0')" --format=json

#gcloud compute routes list --filter="network=${NETWORK}" --format 'value(name)' 

DELETE_DEFVPC=$(gcloud compute routes list --filter="network=${NETWORK}" --filter="destRange=('0.0.0.0/0')" --format 'value(name)' )
DELETE_DEFDEF=$(gcloud compute routes list --filter="network=default" --filter="destRange=('0.0.0.0/0')" --format 'value(name)' )

# NEEDS ATTENTION #
echo "this part needs attention to auotmate"
echo ""
echo "to complete the lab, you can just delete the 2 default routes for this VPC and region in the console"