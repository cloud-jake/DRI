#!/bin/bash

source variables.inc


# Install AWS Command Line Tool:
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

echo "Run aws setup"
echo "AWS Access Key: ${AWSaccesskey}"
echo "AWS Secret Key: ${AWSsecretkey}