#!/bin/bash

source variables.inc

# Task 12: Create a DNS response policy rule for pkg.dev inside pga-policy

gcloud dns response-policies rules create rulepkgdev \
  --response-policy=${DNSPOLICY} \
  --dns-name=pkg.dev.googleapis.com. \
  --local-data=name="pkg.dev.",type="A",ttl=300,rrdatas="199.36.153.4|199.36.153.5|199.36.153.6|199.36.153.7"