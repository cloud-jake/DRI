#!/bin/bash

source variables.inc

# Create a route to the restricted Google APIs VIP
# https://cloud.google.com/vpc-service-controls/docs/set-up-private-connectivity#configure-custom-routes

# https://cloud.google.com/vpc/docs/configure-private-google-access#domain-options
# private.googleapis.com --> 199.36.153.8/30
# restricted.googleapis.com --> 199.36.153.4/30


gcloud compute routes create $ROUTER \
  --network=${NETWORK} \
  --destination-range=199.36.153.4/30 \
  --next-hop-gateway=default-internet-gateway