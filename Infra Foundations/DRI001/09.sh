#!/bin/bash

source variables.inc

# Task 9: Create a DNS response policy rule for *.gcr.io inside pga-policy

gcloud dns response-policies rules create rulestargcrio \
  --response-policy=${DNSPOLICY} \
  --dns-name="*.gcr.io." \
  --local-data=name="*.gcr.io.",type="CNAME",ttl=300,rrdatas="restricted.googleapis.com."