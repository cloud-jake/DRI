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

# Task 5. Implement a fallback
#REPLICA3=
#REPLICA4=

# Task 5. Implement a fallback

## 1 - Create HA cross-region replica
gcloud sql instances create ${REPLICA3} \
    --master-instance-name=${REPLICA1} \
    --region=${REGION1} \
    --availability-type="REGIONAL" \
    --enable-bin-log

## 2 - Promote replica3 as new primary
###First stop the primary and stop replication????????

gcloud sql instances promote-replica ${REPLICA3}



## 3 - Delete Replica1 and Replica 2
### first stop them
gcloud sql instances patch ${REPLICA1} --activation-policy NEVER
gcloud sql instances patch ${REPLICA2} --activation-policy NEVER

### then delete them
gcloud sql instances delete ${REPLICA1}
gcloud sql instances delete ${REPLICA2}


## 4 - create new read replica
gcloud sql instances create ${REPLICA4} \
    --master-instance-name=${REPLICA3} \
    --region=${REGION2} \
    --availability-type="REGIONAL" 

## 2 - Promote replica3 as new primary
###First stop the primary and stop replication????????

gcloud sql instances promote-replica ${REPLICA3}



## 3 - Delete Replica1 and Replica 2
### first stop them
gcloud sql instances patch ${REPLICA1} --activation-policy NEVER
gcloud sql instances patch ${REPLICA2} --activation-policy NEVER

### then delete them
gcloud sql instances delete ${REPLICA1}
gcloud sql instances delete ${REPLICA2}


## 4 - create new read replica
gcloud sql instances create ${REPLICA4} \
    --master-instance-name=${REPLICA3} \
    --region=${REGION2} \
    --availability-type="REGIONAL" 
