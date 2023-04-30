#!/bin/bash

source variables.inc

# Task 6: Create a DNS response policy rule for *.googleapis.com inside $DNSPOLLICY
# https://cloud.google.com/vpc/docs/configure-private-google-access#config-domain

# create a CNAME record for *.googleapis.com that points to the domain that you've configured: 
#   private.googleapis.com or restricted.googleapis.com

gcloud dns response-policies rules create rulestarapi \
  --response-policy=${DNSPOLICY} \
  --dns-name="*.googleapis.com" \
  --local-data=name="*.googleapis.com.",type="CNAME",ttl=300,rrdatas="restricted.googleapis.com."