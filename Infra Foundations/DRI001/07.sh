#!/bin/bash

source variables.inc

# Task 7: Create a DNS response policy rule for *.cloudfunctions.net inside $DNSPOLICY

gcloud dns response-policies rules create rulefunction \
  --response-policy=${DNSPOLICY} \
  --dns-name="*.cloudfunctions.net" \
  --local-data=name="*.cloudfunctions.net.",type="CNAME",ttl=300,rrdatas="restricted.googleapis.com."