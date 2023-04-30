#!/bin/bash

source variables.inc
#

# Task 4 - create VPC and Firewall Rules

#NETWORK=
#SUBNET=

gcloud compute networks create $NETWORK \
    --subnet-mode=custom 

gcloud compute networks subnets create $SUBNET \
    --network=$NETWORK \
    --region=$LAB_REGION


#Create the following firewall rules in Network Name for Dataflow workers to:

#Communicate using SSH, RDP and ICMP protocols.
gcloud compute firewall-rules create DF_SSH \
--network $NETWORK --action allow \
--source-service-accounts=service-${PROJ_NUM}@dataflow-service-producer-prod.iam.gserviceaccount.com  \
--rules tcp:22,tcp:3389,icmp

#Communicate over TCP protocol on ports 12345 and 12346.
gcloud compute firewall-rules create DF_SSH \
--network $NETWORK --action allow \
--source-service-accounts=service-${PROJ_NUM}@dataflow-service-producer-prod.iam.gserviceaccount.com  \
--rules tcp:12345-12346