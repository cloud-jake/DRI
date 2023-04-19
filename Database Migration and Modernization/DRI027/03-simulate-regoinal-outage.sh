#!/bin/bash

source variables.inc

#INSTANCE_ID=
#REGION1=

#REPLICA1=
#REGION2=

# Task 3. Simulate a regional outage
# https://cloud.google.com/solutions/cloud-sql-mysql-disaster-recovery-complete-failover-fallback#make_the_primary_instance_unavailable

gcloud sql instances patch ${REPLICA1} \
    --no-enable-database-replication

gcloud sql instances patch ${INSTANCE_ID} --activation-policy NEVER
