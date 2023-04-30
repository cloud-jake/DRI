#!/bin/bash

source variables.inc

# Task 5: Create a DNS response policy rule for restricted.googleapis.com inside $DNSPOLICY
# https://cloud.google.com/vpc/docs/configure-private-google-access#config-domain
# https://cloud.google.com/dns/docs/zones/manage-response-policies#create-response-policy-rule

gcloud dns response-policies rules create rulerestricted \
  --response-policy=${DNSPOLICY} \
  --dns-name=restricted.googleapis.com. \
  --local-data=name="restricted.googleapis.com.",type="A",ttl=300,rrdatas="199.36.153.4|199.36.153.5|199.36.153.6|199.36.153.7"
