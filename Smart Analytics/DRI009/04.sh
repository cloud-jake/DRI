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
    --region=$LAB_REGION \
    --range 10.10.10.0/24


#Create the following firewall rules in Network Name for Dataflow workers to:


## Please add subnet for your custom VPC 'data-network' with source range of '10.10.10.0/24' .
## Please enable 'private Google Access' for your subnet '["job-subnet"]'.

gcloud compute networks subnets update $SUBNET \
--region=$LAB_REGION \
--enable-private-ip-google-access


#Communicate using SSH, RDP and ICMP protocols.
gcloud compute firewall-rules create foo1 --network data-network --allow tcp:22,tcp:3389,icmp --source-ranges 10.10.10.0/24

#Communicate over TCP protocol on ports 12345 and 12346.
gcloud compute firewall-rules create foo2 --network data-network --allow tcp:12345,tcp:12346 --source-ranges 10.10.10.0/24
