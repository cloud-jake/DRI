#!/bin/bash

source variables.inc

gcloud compute networks subnets create $SUBNET \
    --network=$NETWORK \
    --region=$LAB_REGION \
    --range 10.10.10.0/24

gcloud compute networks subnets update $SUBNET \
--region=$LAB_REGION \
--enable-private-ip-google-access
