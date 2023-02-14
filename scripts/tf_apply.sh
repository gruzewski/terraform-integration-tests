#!/bin/sh

terraform init
terraform apply -auto-approve
terraform output -raw cartography_access_key_id > /cartography-credentials/aws_key
terraform output -raw cartography_access_key_secret > /cartography-credentials/aws_secret
