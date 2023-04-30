#!/bin/bash

source variables.inc

# Task 8: Create a DNS response policy rule for *.run.app inside pga-policy

gcloud dns response-policies rules create rulestarrunapp \
  --response-policy=${DNSPOLICY} \
  --dns-name="*.run.app" \
  --local-data=name="*.run.app.",type="CNAME",ttl=300,rrdatas="restricted.googleapis.com."