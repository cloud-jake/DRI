#!/bin/bash

source variables.inc

# Task 11: Create a DNS response policy rule for *.pkg.dev inside pga-policy

gcloud dns response-policies rules create rulestarpkgdev \
  --response-policy=${DNSPOLICY} \
  --dns-name="*.pkg.dev" \
  --local-data=name="*.pkg.dev.",type="CNAME",ttl=300,rrdatas="restricted.googleapis.com."