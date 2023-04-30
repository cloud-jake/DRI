#!/bin/bash

source variables.inc

gcloud compute networks subnets create $SUBNET \
    --network=$NETWORK \
    --region=$LAB_REGION \
    --range 10.10.10.0/24 \
    --enable-private-ip-google-access

