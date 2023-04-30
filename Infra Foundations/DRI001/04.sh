#!/bin/bash

source variables.inc

# Create a DNS response policy called $DNSPOLICY for Private Google Access
# https://cloud.google.com/dns/docs/zones/manage-response-policies#manage_response_policies

gcloud dns response-policies create $DNSPOLICY \
    --networks=$NETWORK 

