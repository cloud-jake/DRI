#!/bin/bash

source variables.inc

# Task 10: Create a DNS response policy rule for gcr.io inside pga-policy

gcloud dns response-policies rules create rulegcrio \
  --response-policy=${DNSPOLICY} \
  --dns-name=gcr.io \
  --local-data=name="gcr.io.",type="A",ttl=300,rrdatas="199.36.153.4|199.36.153.5|199.36.153.6|199.36.153.7"