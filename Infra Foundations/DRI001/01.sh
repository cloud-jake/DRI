#!/bin/bash

source variables.inc

gcloud compute networks create $NETWORK \
    --subnet-mode=custom 

