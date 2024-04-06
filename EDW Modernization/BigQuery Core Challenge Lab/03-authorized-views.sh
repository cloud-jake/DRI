#!/bin/bash

##Task 3. Create authorized views
#Analysts and auditors require access to data to analyze trends. 
# They might not necessarily require sensitive data such as PII.

#In this task, you should create a BigQuery dataset dedicated for this purpose, 
# that would contain BigQuery views, without any sensitive data.

#Therefore in this task, you should;
#Create a dataset named <Shared BigQuery Dataset Name>.
# create a bigquery dataset name $SBQ_DATASET_NAME
bq mk --location=US $SBQ_DATASET_NAME








#Create an authorized view named <Authorized View 2>  Name under Shared BigQuery Dataset Name, that consists of BigQuery activity logs, that are routed to a BigQuery table under Shared BigQuery Dataset Name dataset, through the Cloud Logging Sink Name sink.
bq mk \
    --view \
    --location=US \
    $SBQ_DATASET_NAME.Authorized_View_2 \
    "SELECT * FROM `$PROJECT_ID.$DATASET.$TABLE_NAME`"

#Create an authorized view named <Authorized View 1> Name under <Shared BigQuery Dataset Name>, that consists of all the data from BigQuery Table Name table excluding the following fields: TransactTime, TradeReportID, and MaturityDate.
bq mk \
    --view \
    --location=US \
    $SBQ_DATASET_NAME.${VIEW1} \
    "SELECT * EXCEPT (TransactTime, TradeReportID, MaturityDate) FROM $DATASET.$TABLE_NAME" 


#Create an authorized view named <Authorized View 2 Name> under <Shared BigQuery Dataset Name>, that consists of BigQuery activity logs, that are routed to a BigQuery table under <Shared BigQuery Dataset Name> dataset, through the <Cloud Logging Sink Name> sink.
bq mk \
    --view \
    --location=US \
    $SBQ_DATASET_NAME.${VIEW2} \
    """SELECT * FROM `$PROJECT_ID.$DATASET.$TABLE_NAME`"""