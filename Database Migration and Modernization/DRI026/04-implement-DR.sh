#!/bin/bash

source variables.inc

#

# Task 1. Create the database
#INSTANCE_ID=
#REGION1=

# Task 2. Deploy a cross-region read replica
#REPLICA1=
#REGION2=

# Task 4. Implement disaster recovery
#REPLICA2=
#REGION3=

# Task 4. Implement disaster recovery

gcloud sql instances promote-replica ${REPLICA1}



#  Delete the original primary database instance to avoid any split-brain situation.
gcloud sql instances delete ${INSTANCE_ID}


# 
gcloud sql instances patch ${REPLICA1} --activation-policy ALWAYS

# create new read-replica
gcloud sql instances create ${REPLICA2} \
    --master-instance-name=${REPLICA1} \
    --region=${REGION3} \
    --availability-type="REGIONAL" 


